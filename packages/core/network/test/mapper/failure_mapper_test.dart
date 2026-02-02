import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:network/src/mapper/failure_mapper.dart';
import 'package:test/test.dart';

void main() {
  late FailureMapper mapper;

  setUp(() {
    mapper = const FailureMapper();
  });

  group('FailureMapper - DioExceptionType', () {
    test('connectionTimeout을 NetworkFailure로 변환한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.message, contains('연결 시간이 초과'));
      expect(failure.statusCode, isNull);
    });

    test('sendTimeout을 NetworkFailure로 변환한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.sendTimeout,
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.message, contains('전송 시간이 초과'));
      expect(failure.statusCode, isNull);
    });

    test('receiveTimeout을 NetworkFailure로 변환한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.receiveTimeout,
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.message, contains('수신 시간이 초과'));
      expect(failure.statusCode, isNull);
    });

    test('badResponse (404)를 NetworkFailure로 변환한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 404,
          data: <String, dynamic>{'message': 'Not found'},
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(404));
      expect(failure.message, contains('Not found'));
    });

    test('badResponse (500)를 NetworkFailure로 변환한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(500));
      expect(failure.message, contains('서버 내부 오류'));
    });

    test('connectionError를 NetworkFailure로 변환한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.message, contains('네트워크 연결에 실패'));
      expect(failure.statusCode, isNull);
    });

    test('cancel을 NetworkFailure로 변환한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.cancel,
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.message, contains('취소'));
      expect(failure.statusCode, isNull);
    });

    test('badCertificate를 NetworkFailure로 변환한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badCertificate,
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.message, contains('SSL 인증서'));
      expect(failure.statusCode, isNull);
    });

    test('unknown을 NetworkFailure로 변환한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        message: 'Custom error message',
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.message, contains('알 수 없는 네트워크 오류'));
      expect(failure.message, contains('Custom error message'));
      expect(failure.statusCode, isNull);
    });
  });

  group('FailureMapper - HTTP Status Codes', () {
    test('400 Bad Request를 적절히 처리한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 400,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(400));
      expect(failure.message, contains('잘못된 요청'));
    });

    test('401 Unauthorized를 적절히 처리한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(401));
      expect(failure.message, contains('인증이 필요'));
    });

    test('403 Forbidden을 적절히 처리한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 403,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(403));
      expect(failure.message, contains('접근 권한'));
    });

    test('404 Not Found를 적절히 처리한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 404,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(404));
      expect(failure.message, contains('리소스를 찾을 수 없'));
    });

    test('422 Unprocessable Entity를 적절히 처리한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 422,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(422));
      expect(failure.message, contains('데이터를 처리할 수 없'));
    });

    test('429 Too Many Requests를 적절히 처리한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 429,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(429));
      expect(failure.message, contains('너무 많은 요청'));
    });

    test('502 Bad Gateway를 적절히 처리한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 502,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(502));
      expect(failure.message, contains('게이트웨이 오류'));
    });

    test('503 Service Unavailable을 적절히 처리한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 503,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(503));
      expect(failure.message, contains('일시적으로 사용할 수 없'));
    });

    test('서버의 커스텀 에러 메시지를 추출한다 (message 키)', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 422,
          data: <String, dynamic>{
            'message': 'Validation failed: Email already exists',
          },
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(422));
      expect(
        failure.message,
        equals('Validation failed: Email already exists'),
      );
    });

    test('서버의 커스텀 에러 메시지를 추출한다 (error 키 - 문자열)', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 400,
          data: <String, dynamic>{'error': 'Invalid input format'},
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(400));
      expect(failure.message, equals('Invalid input format'));
    });

    test('서버의 커스텀 에러 메시지를 추출한다 (error.message 키)', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
          data: <String, dynamic>{
            'error': <String, dynamic>{'message': 'Database connection failed'},
          },
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(500));
      expect(failure.message, equals('Database connection failed'));
    });

    test('응답 데이터가 문자열인 경우 그대로 사용한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
          data: 'Internal Server Error - Custom Message',
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(500));
      expect(failure.message, equals('Internal Server Error - Custom Message'));
    });

    test('응답 데이터가 없으면 기본 메시지를 사용한다', () {
      // Arrange
      final DioException exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
      );

      // Act
      final NetworkFailure failure = mapper.map(exception);

      // Assert
      expect(failure.statusCode, equals(500));
      expect(failure.message, contains('서버 내부 오류'));
    });
  });
}
