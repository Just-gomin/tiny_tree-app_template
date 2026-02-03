import 'package:dio/dio.dart';

/// 에러를 가로채서 공통 처리를 수행하는 인터셉터.
///
/// 현재는 단순히 에러를 전달하지만, 향후 다음과 같은 기능 추가 가능:
/// - 401 발생 시 토큰 자동 갱신
/// - 특정 에러 코드에 대한 자동 재시도
/// - 에러 로깅 강화
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 향후 확장: 401 Unauthorized 시 토큰 갱신
    // if (err.response?.statusCode == 401) {
    //   final newToken = await refreshToken();
    //   final retryResponse = await retry(err.requestOptions, newToken);
    //   return handler.resolve(retryResponse);
    // }

    // 현재는 그대로 전달
    super.onError(err, handler);
  }
}
