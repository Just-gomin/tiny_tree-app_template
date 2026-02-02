import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

/// HTTP 요청과 응답을 로깅하는 인터셉터.
///
/// [logging](https://pub.dev/packages/logging) 패키지를 사용하여
/// 개발 환경에서 디버깅을 위한 로그를 출력합니다.
///
/// 프로덕션에서는 민감한 정보(토큰, 비밀번호) 노출 방지를 위해
/// [Level.WARNING] 이상으로 설정하거나 비활성화 권장합니다.
///
/// ## 사용 예시
///
/// ```dart
/// // 기본 사용
/// final interceptor = LoggingInterceptor();
///
/// // 커스텀 Logger 사용
/// final logger = Logger('MyApp.Http');
/// final interceptor = LoggingInterceptor(logger: logger);
///
/// // 로그 레벨 지정
/// final interceptor = LoggingInterceptor(logLevel: Level.FINE);
/// ```
class LoggingInterceptor extends Interceptor {
  /// LoggingInterceptor를 생성합니다.
  ///
  /// [logger]: 사용할 Logger 인스턴스 (null이면 기본 Logger 생성)
  /// [logLevel]: 로깅 레벨 (기본값: Level.INFO)
  LoggingInterceptor({
    Logger? logger,
    this.logLevel = Level.INFO,
  }) : _logger = logger ?? Logger('ApiClient.Http');

  final Logger _logger;

  /// 로깅 레벨
  final Level logLevel;

  // 민감 정보 필드명 (소문자로 비교)
  static const List<String> _sensitiveKeys = <String>[
    'authorization',
    'token',
    'password',
    'secret',
    'apikey',
    'api_key',
  ];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (_shouldLog(Level.INFO)) {
      final StringBuffer buffer = StringBuffer();
      buffer.writeln('╔════════════════════════════════════════');
      buffer.writeln('║ REQUEST: ${options.method} ${options.uri}');
      buffer.writeln('╠────────────────────────────────────────');

      // Headers 로깅
      buffer.writeln('║ Headers:');
      options.headers.forEach((String key, dynamic value) {
        buffer.writeln('║   $key: ${_maskSensitiveData(key, value)}');
      });

      // Query Parameters 로깅
      if (options.queryParameters.isNotEmpty) {
        buffer.writeln('║ Query Parameters:');
        options.queryParameters.forEach((String key, dynamic value) {
          buffer.writeln('║   $key: $value');
        });
      }

      // Body 로깅 (FINE 레벨 이상)
      if (options.data != null && _shouldLog(Level.FINE)) {
        buffer.writeln('║ Body: ${_formatBody(options.data)}');
      }

      buffer.write('╚════════════════════════════════════════');

      _logger.info(buffer.toString());
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (_shouldLog(Level.INFO)) {
      final StringBuffer buffer = StringBuffer();
      buffer.writeln('╔════════════════════════════════════════');
      buffer.writeln(
        '║ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}',
      );
      buffer.writeln('╠────────────────────────────────────────');

      // Response data 로깅 (FINE 레벨 이상)
      if (_shouldLog(Level.FINE)) {
        buffer.writeln('║ Data: ${_formatBody(response.data)}');
      } else {
        buffer.writeln('║ Status: Success');
      }

      buffer.write('╚════════════════════════════════════════');

      _logger.info(buffer.toString());
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_shouldLog(Level.WARNING)) {
      final StringBuffer buffer = StringBuffer();
      buffer.writeln('╔════════════════════════════════════════');
      buffer.writeln('║ ERROR: ${err.type} ${err.requestOptions.uri}');
      buffer.writeln('╠────────────────────────────────────────');
      buffer.writeln('║ Message: ${err.message}');

      if (err.response != null) {
        buffer.writeln('║ Status Code: ${err.response?.statusCode}');

        // Error response data 로깅 (FINE 레벨 이상)
        if (_shouldLog(Level.FINE)) {
          buffer.writeln('║ Data: ${_formatBody(err.response?.data)}');
        }
      }

      buffer.write('╚════════════════════════════════════════');

      _logger.warning(buffer.toString(), err, err.stackTrace);
    }

    super.onError(err, handler);
  }

  /// 현재 로그 레벨에서 지정된 레벨의 로그를 출력할지 여부를 확인합니다.
  bool _shouldLog(Level level) {
    return logLevel <= level;
  }

  /// 민감한 정보를 마스킹합니다.
  String _maskSensitiveData(String key, dynamic value) {
    final String lowerKey = key.toLowerCase();

    for (final String sensitiveKey in _sensitiveKeys) {
      if (lowerKey.contains(sensitiveKey)) {
        return '***MASKED***';
      }
    }

    return value.toString();
  }

  /// Body 데이터를 포맷팅합니다 (너무 길면 잘라냄).
  String _formatBody(dynamic data) {
    if (data == null) {
      return 'null';
    }

    final String dataString = data.toString();
    const int maxLength = 1000;

    if (dataString.length > maxLength) {
      return '${dataString.substring(0, maxLength)}... (truncated)';
    }

    return dataString;
  }
}
