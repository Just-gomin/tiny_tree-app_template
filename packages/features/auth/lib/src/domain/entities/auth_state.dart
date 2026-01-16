import 'user.dart';

/// 인증 상태를 나타내는 sealed class
///
/// 패턴 매칭으로 모든 케이스를 처리하도록 강제합니다.
sealed class AuthState {
  /// 인증 상태 생성자
  const AuthState();
}

/// 초기 상태 (앱 시작 시)
class AuthInitial extends AuthState {
  /// 초기 상태 생성자
  const AuthInitial();
}

/// 인증됨 (로그인 성공)
class Authenticated extends AuthState {
  /// 인증됨 상태 생성자
  const Authenticated(this.user);

  /// 현재 로그인한 사용자
  final User user;
}

/// 인증되지 않음 (로그아웃 또는 미인증)
class Unauthenticated extends AuthState {
  /// 인증되지 않음 상태 생성자
  const Unauthenticated();
}

/// 로딩 중 (인증 처리 진행 중)
class AuthLoading extends AuthState {
  /// 로딩 중 상태 생성자
  const AuthLoading();
}

/// 에러 발생
class AuthError extends AuthState {
  /// 에러 상태 생성자
  const AuthError(this.message);

  /// 에러 메시지
  final String message;
}
