import 'package:equatable/equatable.dart';

/// 비즈니스 로직 실패를 나타내는 sealed 클래스.
///
/// 모든 실패 타입은 이 클래스를 확장해야 하며,
/// sealed 특성으로 인해 pattern matching 시 exhaustive checking이 가능합니다.
///
/// 예시:
/// ```dart
/// final result = await someUseCase.call();
/// switch (result) {
///   case Success(:final value):
///     print('Success: $value');
///   case Error(:final failure):
///     switch (failure) {
///       case NetworkFailure(:final message):
///         print('Network error: $message');
///       case ValidationFailure(:final message, :final field):
///         print('Validation error on $field: $message');
///       // 컴파일러가 모든 케이스를 체크
///     }
/// }
/// ```
sealed class Failure extends Equatable {
  /// Failure를 생성합니다.
  const Failure(this.message);

  /// 실패에 대한 설명 메시지.
  final String message;

  @override
  List<Object?> get props => <Object?>[message];

  @override
  bool get stringify => true;
}

/// 네트워크 관련 실패.
///
/// HTTP 요청 실패, 연결 타임아웃, 인터넷 연결 없음 등의 경우에 사용합니다.
final class NetworkFailure extends Failure {
  /// NetworkFailure를 생성합니다.
  const NetworkFailure(super.message, {this.statusCode});

  /// HTTP 상태 코드 (선택적).
  final int? statusCode;

  @override
  List<Object?> get props => <Object?>[message, statusCode];
}

/// 검증(validation) 실패.
///
/// 입력 데이터가 비즈니스 규칙을 만족하지 못할 때 사용합니다.
final class ValidationFailure extends Failure {
  /// ValidationFailure를 생성합니다.
  const ValidationFailure(super.message, {this.field});

  /// 검증에 실패한 필드명 (선택적).
  final String? field;

  @override
  List<Object?> get props => <Object?>[message, field];
}

/// 리소스를 찾을 수 없음을 나타내는 실패.
///
/// 데이터베이스 조회 실패, 존재하지 않는 ID 등의 경우에 사용합니다.
final class NotFoundFailure extends Failure {
  /// NotFoundFailure를 생성합니다.
  const NotFoundFailure(super.message, {this.resourceId});

  /// 찾을 수 없는 리소스의 식별자 (선택적).
  final String? resourceId;

  @override
  List<Object?> get props => <Object?>[message, resourceId];
}

/// 인증되지 않은 접근을 나타내는 실패.
///
/// 로그인이 필요하거나, 토큰이 만료되었거나, 권한이 없는 경우에 사용합니다.
final class UnauthorizedFailure extends Failure {
  /// UnauthorizedFailure를 생성합니다.
  const UnauthorizedFailure(super.message);
}

/// 서버 내부 오류를 나타내는 실패.
///
/// 5xx 에러, 예상치 못한 서버 응답 등의 경우에 사용합니다.
final class ServerFailure extends Failure {
  /// ServerFailure를 생성합니다.
  const ServerFailure(super.message, {this.errorCode});

  /// 서버 에러 코드 (선택적).
  final String? errorCode;

  @override
  List<Object?> get props => <Object?>[message, errorCode];
}

/// 알 수 없는 실패.
///
/// 다른 실패 타입으로 분류할 수 없는 경우에 사용합니다.
final class UnknownFailure extends Failure {
  /// UnknownFailure를 생성합니다.
  const UnknownFailure(super.message, {this.error, this.stackTrace});

  /// 원본 에러 객체 (선택적).
  final Object? error;

  /// 스택 트레이스 (선택적).
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => <Object?>[message, error, stackTrace];
}
