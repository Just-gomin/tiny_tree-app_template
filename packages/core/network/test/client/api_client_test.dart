import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http_mock_adapter/src/handlers/request_handler.dart';
import 'package:network/src/client/api_client.dart';
import 'package:test/test.dart';

void main() {
  late ApiClient apiClient;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
    dioAdapter = DioAdapter(dio: dio);
    apiClient = ApiClient.withDio(dio);
  });

  group('ApiClient GET', () {
    test('성공 시 Success를 반환한다', () async {
      // Arrange
      const String path = '/users/1';
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'id': '1',
        'name': 'John Doe',
      };

      dioAdapter.onGet(
        path,
        (MockServer server) => server.reply(200, mockResponse),
      );

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .get<dynamic>(path);

      // Assert
      expect(result, isA<Success<NetworkFailure, dynamic>>());
      expect(result.valueOrNull, equals(mockResponse));
    });

    test('404 에러 시 NetworkFailure를 반환한다', () async {
      // Arrange
      const String path = '/users/999';

      dioAdapter.onGet(path, (MockServer server) => server.reply(404, null));

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .get<dynamic>(path);

      // Assert
      expect(result, isA<Error<NetworkFailure, dynamic>>());
      expect(result.failureOrNull?.statusCode, equals(404));
    });

    test('쿼리 파라미터와 함께 요청할 수 있다', () async {
      // Arrange
      const String path = '/users';
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'page': '1',
        'limit': '10',
      };
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'users': <dynamic>[],
      };

      dioAdapter.onGet(
        path,
        (MockServer server) => server.reply(200, mockResponse),
        queryParameters: queryParams,
      );

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .get<dynamic>(path, queryParameters: queryParams);

      // Assert
      expect(result, isA<Success<NetworkFailure, dynamic>>());
    });
  });

  group('ApiClient POST', () {
    test('데이터를 전송하고 Success를 반환한다', () async {
      // Arrange
      const String path = '/users';
      final Map<String, dynamic> requestData = <String, dynamic>{
        'name': 'Jane Doe',
        'email': 'jane@example.com',
      };
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'id': '2',
        ...requestData,
      };

      dioAdapter.onPost(
        path,
        (MockServer server) => server.reply(201, mockResponse),
        data: requestData,
      );

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .post<dynamic>(path, data: requestData);

      // Assert
      expect(result, isA<Success<NetworkFailure, dynamic>>());
      expect(result.valueOrNull, equals(mockResponse));
    });

    test('400 에러 시 NetworkFailure를 반환한다', () async {
      // Arrange
      const String path = '/users';
      final Map<String, dynamic> requestData = <String, dynamic>{
        'email': 'invalid-email',
      };

      dioAdapter.onPost(
        path,
        (MockServer server) => server.reply(400, <String, dynamic>{
          'message': 'Invalid email format',
        }),
        data: requestData,
      );

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .post<dynamic>(path, data: requestData);

      // Assert
      expect(result, isA<Error<NetworkFailure, dynamic>>());
      expect(result.failureOrNull?.statusCode, equals(400));
      expect(result.failureOrNull?.message, contains('Invalid email format'));
    });
  });

  group('ApiClient PUT', () {
    test('데이터를 업데이트하고 Success를 반환한다', () async {
      // Arrange
      const String path = '/users/1';
      final Map<String, dynamic> requestData = <String, dynamic>{
        'name': 'Updated Name',
      };
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'id': '1',
        'name': 'Updated Name',
      };

      dioAdapter.onPut(
        path,
        (MockServer server) => server.reply(200, mockResponse),
        data: requestData,
      );

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .put<dynamic>(path, data: requestData);

      // Assert
      expect(result, isA<Success<NetworkFailure, dynamic>>());
      expect(result.valueOrNull, equals(mockResponse));
    });
  });

  group('ApiClient DELETE', () {
    test('리소스를 삭제하고 Success를 반환한다', () async {
      // Arrange
      const String path = '/users/1';

      dioAdapter.onDelete(path, (MockServer server) => server.reply(204, null));

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .delete<dynamic>(path);

      // Assert
      expect(result, isA<Success<NetworkFailure, dynamic>>());
    });
  });

  group('ApiClient PATCH', () {
    test('일부 데이터를 업데이트하고 Success를 반환한다', () async {
      // Arrange
      const String path = '/users/1';
      final Map<String, dynamic> requestData = <String, dynamic>{
        'email': 'newemail@example.com',
      };
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'id': '1',
        'name': 'John Doe',
        'email': 'newemail@example.com',
      };

      dioAdapter.onPatch(
        path,
        (MockServer server) => server.reply(200, mockResponse),
        data: requestData,
      );

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .patch<dynamic>(path, data: requestData);

      // Assert
      expect(result, isA<Success<NetworkFailure, dynamic>>());
      expect(result.valueOrNull, equals(mockResponse));
    });
  });

  group('ApiClient 에러 처리', () {
    test('500 서버 에러를 적절히 처리한다', () async {
      // Arrange
      const String path = '/error';

      dioAdapter.onGet(path, (MockServer server) => server.reply(500, null));

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .get<dynamic>(path);

      // Assert
      expect(result, isA<Error<NetworkFailure, dynamic>>());
      expect(result.failureOrNull?.statusCode, equals(500));
      expect(result.failureOrNull?.message, contains('서버 내부 오류'));
    });

    test('연결 타임아웃을 적절히 처리한다', () async {
      // Arrange
      const String path = '/timeout';

      dioAdapter.onGet(
        path,
        (MockServer server) => server.throws(
          404,
          DioException(
            requestOptions: RequestOptions(path: path),
            type: DioExceptionType.connectionTimeout,
          ),
        ),
      );

      // Act
      final Result<NetworkFailure, dynamic> result = await apiClient
          .get<dynamic>(path);

      // Assert
      expect(result, isA<Error<NetworkFailure, dynamic>>());
      expect(result.failureOrNull?.message, contains('연결 시간이 초과'));
    });
  });
}
