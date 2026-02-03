import 'package:logging/logging.dart';

/// ApiClient의 설정을 정의하는 클래스.
///
/// HTTP 클라이언트의 기본 URL, 타임아웃, 헤더 등을 설정합니다.
class ApiClientConfig {
  /// ApiClientConfig를 생성합니다.
  ///
  /// [baseUrl]: API의 기본 URL (필수)
  /// [connectTimeout]: 연결 타임아웃 (기본값: 30초)
  /// [receiveTimeout]: 응답 수신 타임아웃 (기본값: 30초)
  /// [sendTimeout]: 요청 전송 타임아웃 (기본값: 30초)
  /// [headers]: 기본 헤더 (기본값: 빈 맵)
  /// [enableLogging]: 로깅 활성화 여부 (기본값: false)
  /// [logger]: 커스텀 Logger 인스턴스 (null이면 기본 Logger 사용)
  /// [logLevel]: 로깅 레벨 (기본값: Level.INFO)
  const ApiClientConfig({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
    this.headers = const <String, String>{},
    this.enableLogging = false,
    this.logger,
    this.logLevel = Level.INFO,
  });

  /// API의 기본 URL
  final String baseUrl;

  /// 서버 연결 타임아웃
  final Duration connectTimeout;

  /// 응답 수신 타임아웃
  final Duration receiveTimeout;

  /// 요청 전송 타임아웃
  final Duration sendTimeout;

  /// 모든 요청에 포함될 기본 헤더
  final Map<String, String> headers;

  /// 디버깅용 로깅 활성화 여부
  final bool enableLogging;

  /// 커스텀 Logger 인스턴스 (null이면 기본 Logger 사용)
  final Logger? logger;

  /// 로깅 레벨 (기본값: Level.INFO)
  ///
  /// 개발 환경: Level.FINE 또는 Level.ALL
  /// 프로덕션 환경: Level.WARNING 또는 Level.OFF
  final Level logLevel;
}
