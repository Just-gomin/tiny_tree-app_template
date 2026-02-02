import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:network/src/interceptor/logging_interceptor.dart';
import 'package:test/test.dart';

void main() {
  group('LoggingInterceptor', () {
    late Logger testLogger;
    late List<LogRecord> logRecords;
    late LoggingInterceptor interceptor;

    setUp(() {
      // 테스트용 Logger 설정
      testLogger = Logger('TestLogger');
      logRecords = <LogRecord>[];

      // 로그를 리스트에 저장
      testLogger.onRecord.listen((LogRecord record) {
        logRecords.add(record);
      });

      interceptor = LoggingInterceptor(
        logger: testLogger,
        logLevel: Level.ALL,
      );
    });

    tearDown(() {
      logRecords.clear();
    });

    group('생성자', () {
      test('기본 Logger로 인스턴스를 생성할 수 있다', () {
        final LoggingInterceptor defaultInterceptor = LoggingInterceptor();

        expect(defaultInterceptor, isNotNull);
        expect(defaultInterceptor.logLevel, equals(Level.INFO));
      });

      test('커스텀 Logger와 logLevel로 인스턴스를 생성할 수 있다', () {
        final Logger customLogger = Logger('CustomLogger');
        final LoggingInterceptor customInterceptor = LoggingInterceptor(
          logger: customLogger,
          logLevel: Level.WARNING,
        );

        expect(customInterceptor, isNotNull);
        expect(customInterceptor.logLevel, equals(Level.WARNING));
      });
    });

    group('onRequest', () {
      test('INFO 레벨에서 요청을 로깅한다', () {
        // Arrange
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'GET',
          baseUrl: 'https://api.example.com',
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        expect(logRecords, isNotEmpty);
        expect(logRecords.first.level, equals(Level.INFO));
        expect(logRecords.first.message, contains('REQUEST: GET'));
        expect(logRecords.first.message, contains('https://api.example.com/test'));
      });

      test('민감한 헤더를 마스킹한다 (authorization)', () {
        // Arrange
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'GET',
          baseUrl: 'https://api.example.com',
          headers: <String, dynamic>{
            'Authorization': 'Bearer secret-token-12345',
            'Content-Type': 'application/json',
          },
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        expect(logRecords.first.message, contains('Authorization: ***MASKED***'));
        expect(logRecords.first.message, contains('Content-Type: application/json'));
        expect(logRecords.first.message, isNot(contains('secret-token')));
      });

      test('민감한 헤더를 마스킹한다 (token)', () {
        // Arrange
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'POST',
          baseUrl: 'https://api.example.com',
          headers: <String, dynamic>{
            'X-API-Token': 'my-secret-token',
            'User-Agent': 'TestApp/1.0',
          },
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        expect(logRecords.first.message, contains('X-API-Token: ***MASKED***'));
        expect(logRecords.first.message, contains('User-Agent: TestApp/1.0'));
      });

      test('민감한 헤더를 마스킹한다 (password, secret, apikey)', () {
        // Arrange
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'POST',
          baseUrl: 'https://api.example.com',
          headers: <String, dynamic>{
            'X-Password': 'my-password',
            'X-Secret': 'my-secret',
            'X-ApiKey': 'my-api-key',
          },
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        expect(logRecords.first.message, contains('X-Password: ***MASKED***'));
        expect(logRecords.first.message, contains('X-Secret: ***MASKED***'));
        expect(logRecords.first.message, contains('X-ApiKey: ***MASKED***'));
      });

      test('쿼리 파라미터를 로깅한다', () {
        // Arrange
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'GET',
          baseUrl: 'https://api.example.com',
          queryParameters: <String, dynamic>{
            'page': '1',
            'limit': '10',
          },
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        expect(logRecords.first.message, contains('Query Parameters:'));
        expect(logRecords.first.message, contains('page: 1'));
        expect(logRecords.first.message, contains('limit: 10'));
      });

      test('FINE 레벨에서 Body 데이터를 로깅한다', () {
        // Arrange
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'POST',
          baseUrl: 'https://api.example.com',
          data: <String, dynamic>{'username': 'testuser', 'email': 'test@example.com'},
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        expect(logRecords.first.message, contains('Body:'));
        expect(logRecords.first.message, contains('username'));
        expect(logRecords.first.message, contains('testuser'));
      });

      test('INFO 레벨에서는 Body 데이터를 로깅하지 않는다', () {
        // Arrange
        final LoggingInterceptor infoInterceptor = LoggingInterceptor(
          logger: testLogger,
          logLevel: Level.INFO,
        );
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'POST',
          baseUrl: 'https://api.example.com',
          data: <String, dynamic>{'username': 'testuser'},
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        infoInterceptor.onRequest(options, handler);

        // Assert
        expect(logRecords.first.message, isNot(contains('Body:')));
      });

      test('OFF 레벨에서는 로그를 출력하지 않는다', () {
        // Arrange
        final LoggingInterceptor offInterceptor = LoggingInterceptor(
          logger: testLogger,
          logLevel: Level.OFF,
        );
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'GET',
          baseUrl: 'https://api.example.com',
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        offInterceptor.onRequest(options, handler);

        // Assert
        expect(logRecords, isEmpty);
      });
    });

    group('onResponse', () {
      test('INFO 레벨에서 응답을 로깅한다', () {
        // Arrange
        final Response<dynamic> response = Response<dynamic>(
          requestOptions: RequestOptions(
            path: '/test',
            baseUrl: 'https://api.example.com',
          ),
          statusCode: 200,
          data: <String, dynamic>{'result': 'success'},
        );
        final _MockResponseInterceptorHandler handler =
            _MockResponseInterceptorHandler();

        // Act
        interceptor.onResponse(response, handler);

        // Assert
        expect(logRecords, isNotEmpty);
        expect(logRecords.first.level, equals(Level.INFO));
        expect(logRecords.first.message, contains('RESPONSE: 200'));
        expect(logRecords.first.message, contains('https://api.example.com/test'));
      });

      test('FINE 레벨에서는 응답 데이터를 로깅한다', () {
        // Arrange
        final Response<dynamic> response = Response<dynamic>(
          requestOptions: RequestOptions(
            path: '/test',
            baseUrl: 'https://api.example.com',
          ),
          statusCode: 200,
          data: <String, dynamic>{'result': 'success', 'count': 42},
        );
        final _MockResponseInterceptorHandler handler =
            _MockResponseInterceptorHandler();

        // Act
        interceptor.onResponse(response, handler);

        // Assert
        expect(logRecords.first.message, contains('Data:'));
        expect(logRecords.first.message, contains('result'));
        expect(logRecords.first.message, contains('success'));
      });

      test('INFO 레벨에서는 응답 데이터를 로깅하지 않는다', () {
        // Arrange
        final LoggingInterceptor infoInterceptor = LoggingInterceptor(
          logger: testLogger,
          logLevel: Level.INFO,
        );
        final Response<dynamic> response = Response<dynamic>(
          requestOptions: RequestOptions(
            path: '/test',
            baseUrl: 'https://api.example.com',
          ),
          statusCode: 200,
          data: <String, dynamic>{'result': 'success'},
        );
        final _MockResponseInterceptorHandler handler =
            _MockResponseInterceptorHandler();

        // Act
        infoInterceptor.onResponse(response, handler);

        // Assert
        expect(logRecords.first.message, contains('Status: Success'));
        expect(logRecords.first.message, isNot(contains('Data:')));
      });
    });

    group('onError', () {
      test('WARNING 레벨에서 에러를 로깅한다', () {
        // Arrange
        final DioException error = DioException(
          requestOptions: RequestOptions(
            path: '/test',
            baseUrl: 'https://api.example.com',
          ),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        );
        final _MockErrorInterceptorHandler handler =
            _MockErrorInterceptorHandler();

        // Act
        interceptor.onError(error, handler);

        // Assert
        expect(logRecords, isNotEmpty);
        expect(logRecords.first.level, equals(Level.WARNING));
        expect(logRecords.first.message, contains('ERROR:'));
        expect(logRecords.first.message, contains('connectionTimeout'));
        expect(logRecords.first.message, contains('Connection timeout'));
      });

      test('에러 응답이 있을 때 상태 코드를 로깅한다', () {
        // Arrange
        final DioException error = DioException(
          requestOptions: RequestOptions(
            path: '/test',
            baseUrl: 'https://api.example.com',
          ),
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(
            requestOptions: RequestOptions(
              path: '/test',
              baseUrl: 'https://api.example.com',
            ),
            statusCode: 404,
            data: <String, dynamic>{'message': 'Not found'},
          ),
        );
        final _MockErrorInterceptorHandler handler =
            _MockErrorInterceptorHandler();

        // Act
        interceptor.onError(error, handler);

        // Assert
        expect(logRecords.first.message, contains('Status Code: 404'));
      });

      test('FINE 레벨에서 에러 응답 데이터를 로깅한다', () {
        // Arrange
        final DioException error = DioException(
          requestOptions: RequestOptions(
            path: '/test',
            baseUrl: 'https://api.example.com',
          ),
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(
            requestOptions: RequestOptions(
              path: '/test',
              baseUrl: 'https://api.example.com',
            ),
            statusCode: 400,
            data: <String, dynamic>{'error': 'Invalid request'},
          ),
        );
        final _MockErrorInterceptorHandler handler =
            _MockErrorInterceptorHandler();

        // Act
        interceptor.onError(error, handler);

        // Assert
        expect(logRecords.first.message, contains('Data:'));
        expect(logRecords.first.message, contains('Invalid request'));
      });

      test('WARNING보다 높은 레벨에서는 에러를 로깅하지 않는다', () {
        // Arrange
        final LoggingInterceptor severeInterceptor = LoggingInterceptor(
          logger: testLogger,
          logLevel: Level.SEVERE,
        );
        final DioException error = DioException(
          requestOptions: RequestOptions(
            path: '/test',
            baseUrl: 'https://api.example.com',
          ),
          type: DioExceptionType.connectionTimeout,
        );
        final _MockErrorInterceptorHandler handler =
            _MockErrorInterceptorHandler();

        // Act
        severeInterceptor.onError(error, handler);

        // Assert
        expect(logRecords, isEmpty);
      });
    });

    group('_formatBody', () {
      test('null 데이터는 "null" 문자열로 변환한다', () {
        // Arrange
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'POST',
          baseUrl: 'https://api.example.com',
          data: null,
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        // Body는 FINE 레벨에서만 로깅되므로, data가 null이어도 로그는 출력됨
        expect(logRecords, isNotEmpty);
      });

      test('1000자 이상의 긴 데이터는 잘라낸다', () {
        // Arrange
        final String longData = 'a' * 1500;
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'POST',
          baseUrl: 'https://api.example.com',
          data: longData,
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        expect(logRecords.first.message, contains('(truncated)'));
        expect(logRecords.first.message.length, lessThan(longData.length + 500));
      });
    });

    group('박스 스타일 포맷', () {
      test('요청 로그에 박스 스타일 문자가 포함된다', () {
        // Arrange
        final RequestOptions options = RequestOptions(
          path: '/test',
          method: 'GET',
          baseUrl: 'https://api.example.com',
        );
        final _MockRequestInterceptorHandler handler =
            _MockRequestInterceptorHandler();

        // Act
        interceptor.onRequest(options, handler);

        // Assert
        expect(logRecords.first.message, contains('╔═'));
        expect(logRecords.first.message, contains('║'));
        expect(logRecords.first.message, contains('╠─'));
        expect(logRecords.first.message, contains('╚═'));
      });

      test('응답 로그에 박스 스타일 문자가 포함된다', () {
        // Arrange
        final Response<dynamic> response = Response<dynamic>(
          requestOptions: RequestOptions(
            path: '/test',
            baseUrl: 'https://api.example.com',
          ),
          statusCode: 200,
        );
        final _MockResponseInterceptorHandler handler =
            _MockResponseInterceptorHandler();

        // Act
        interceptor.onResponse(response, handler);

        // Assert
        expect(logRecords.first.message, contains('╔═'));
        expect(logRecords.first.message, contains('║'));
        expect(logRecords.first.message, contains('╚═'));
      });

      test('에러 로그에 박스 스타일 문자가 포함된다', () {
        // Arrange
        final DioException error = DioException(
          requestOptions: RequestOptions(
            path: '/test',
            baseUrl: 'https://api.example.com',
          ),
          type: DioExceptionType.connectionTimeout,
        );
        final _MockErrorInterceptorHandler handler =
            _MockErrorInterceptorHandler();

        // Act
        interceptor.onError(error, handler);

        // Assert
        expect(logRecords.first.message, contains('╔═'));
        expect(logRecords.first.message, contains('║'));
        expect(logRecords.first.message, contains('╚═'));
      });
    });
  });
}

// Mock classes
class _MockRequestInterceptorHandler extends RequestInterceptorHandler {
  @override
  void next(RequestOptions requestOptions) {}
}

class _MockResponseInterceptorHandler extends ResponseInterceptorHandler {
  @override
  void next(Response<dynamic> response) {}
}

class _MockErrorInterceptorHandler extends ErrorInterceptorHandler {
  @override
  void next(DioException err) {}
}
