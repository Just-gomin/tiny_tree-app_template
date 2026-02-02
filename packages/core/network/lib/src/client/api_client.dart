import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../interceptor/error_interceptor.dart';
import '../interceptor/logging_interceptor.dart';
import '../mapper/failure_mapper.dart';
import 'api_client_config.dart';

/// Dio 기반 HTTP 클라이언트로 Result 패턴을 통합합니다.
///
/// 모든 HTTP 메서드는 `Result<NetworkFailure, T>`를 반환하여
/// type-safe한 에러 처리를 제공합니다.
class ApiClient {
  /// ApiClientConfig를 사용하여 ApiClient를 생성합니다.
  ///
  /// [config]: API 클라이언트 설정
  ApiClient(ApiClientConfig config)
    : _dio = Dio(
        BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: config.connectTimeout,
          receiveTimeout: config.receiveTimeout,
          sendTimeout: config.sendTimeout,
          headers: config.headers,
        ),
      ),
      _failureMapper = const FailureMapper() {
    // Interceptor 등록 순서: Logging -> Error
    if (config.enableLogging) {
      _dio.interceptors.add(
        LoggingInterceptor(
          logger: config.logger,
          logLevel: config.logLevel,
        ),
      );
    }
    _dio.interceptors.add(ErrorInterceptor());
  }

  // Test purpose only: Inject custom Dio instance
  /// 테스트용 생성자: 커스텀 Dio 인스턴스를 주입합니다.
  ///
  /// 이 생성자는 테스트 목적으로만 사용됩니다.
  ApiClient.withDio(this._dio) : _failureMapper = const FailureMapper();

  final Dio _dio;
  final FailureMapper _failureMapper;

  /// HTTP GET 요청을 수행하고 Result로 래핑합니다.
  ///
  /// [path]: API 엔드포인트 경로 (baseUrl 이후 경로)
  /// [queryParameters]: 쿼리 파라미터 (optional)
  /// [options]: 추가 Dio 옵션 (optional)
  ///
  /// Returns: `Result<NetworkFailure, T>`
  ///   - `Success<NetworkFailure, T>`: 요청 성공, value는 Response.data
  ///   - `Error<NetworkFailure, T>`: 요청 실패, failure는 NetworkFailure
  Future<Result<NetworkFailure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response<T> response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return Success<NetworkFailure, T>(response.data as T);
    } on DioException catch (e) {
      return Error<NetworkFailure, T>(_failureMapper.map(e));
    } on Exception catch (e) {
      // DioException이 아닌 예외 (예: JSON 파싱 에러)
      return Error<NetworkFailure, T>(NetworkFailure('Unexpected error: $e'));
    }
  }

  /// HTTP POST 요청을 수행하고 Result로 래핑합니다.
  ///
  /// [path]: API 엔드포인트 경로
  /// [data]: 전송할 데이터 (optional)
  /// [queryParameters]: 쿼리 파라미터 (optional)
  /// [options]: 추가 Dio 옵션 (optional)
  ///
  /// Returns: `Result<NetworkFailure, T>`
  Future<Result<NetworkFailure, T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response<T> response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Success<NetworkFailure, T>(response.data as T);
    } on DioException catch (e) {
      return Error<NetworkFailure, T>(_failureMapper.map(e));
    } on Exception catch (e) {
      return Error<NetworkFailure, T>(NetworkFailure('Unexpected error: $e'));
    }
  }

  /// HTTP PUT 요청을 수행하고 Result로 래핑합니다.
  ///
  /// [path]: API 엔드포인트 경로
  /// [data]: 전송할 데이터 (optional)
  /// [queryParameters]: 쿼리 파라미터 (optional)
  /// [options]: 추가 Dio 옵션 (optional)
  ///
  /// Returns: `Result<NetworkFailure, T>`
  Future<Result<NetworkFailure, T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response<T> response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Success<NetworkFailure, T>(response.data as T);
    } on DioException catch (e) {
      return Error<NetworkFailure, T>(_failureMapper.map(e));
    } on Exception catch (e) {
      return Error<NetworkFailure, T>(NetworkFailure('Unexpected error: $e'));
    }
  }

  /// HTTP DELETE 요청을 수행하고 Result로 래핑합니다.
  ///
  /// [path]: API 엔드포인트 경로
  /// [data]: 전송할 데이터 (optional)
  /// [queryParameters]: 쿼리 파라미터 (optional)
  /// [options]: 추가 Dio 옵션 (optional)
  ///
  /// Returns: `Result<NetworkFailure, T>`
  Future<Result<NetworkFailure, T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response<T> response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Success<NetworkFailure, T>(response.data as T);
    } on DioException catch (e) {
      return Error<NetworkFailure, T>(_failureMapper.map(e));
    } on Exception catch (e) {
      return Error<NetworkFailure, T>(NetworkFailure('Unexpected error: $e'));
    }
  }

  /// HTTP PATCH 요청을 수행하고 Result로 래핑합니다.
  ///
  /// [path]: API 엔드포인트 경로
  /// [data]: 전송할 데이터 (optional)
  /// [queryParameters]: 쿼리 파라미터 (optional)
  /// [options]: 추가 Dio 옵션 (optional)
  ///
  /// Returns: `Result<NetworkFailure, T>`
  Future<Result<NetworkFailure, T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response<T> response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Success<NetworkFailure, T>(response.data as T);
    } on DioException catch (e) {
      return Error<NetworkFailure, T>(_failureMapper.map(e));
    } on Exception catch (e) {
      return Error<NetworkFailure, T>(NetworkFailure('Unexpected error: $e'));
    }
  }
}
