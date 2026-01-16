/// 인증 관련 실패를 나타내는 sealed class
///
/// 타입 안전하게 에러를 표현하고 패턴 매칭으로 처리합니다.
sealed class AuthFailure {
  /// 인증 실패 생성자
  const AuthFailure(this.message);

  /// 에러 메시지
  final String message;

  @override
  String toString() => message;
}

/// 잘못된 인증 정보 (이메일 또는 비밀번호 오류)
class InvalidCredentialsFailure extends AuthFailure {
  /// 잘못된 인증 정보 실패 생성자
  const InvalidCredentialsFailure() : super('이메일 또는 비밀번호가 올바르지 않습니다.');
}

/// 이미 존재하는 사용자 (회원가입 시)
class UserAlreadyExistsFailure extends AuthFailure {
  /// 사용자 중복 실패 생성자
  const UserAlreadyExistsFailure() : super('이미 가입된 이메일입니다.');
}

/// 네트워크 에러
class NetworkFailure extends AuthFailure {
  /// 네트워크 실패 생성자
  const NetworkFailure() : super('네트워크 연결을 확인해주세요.');
}

/// 서버 에러
class ServerFailure extends AuthFailure {
  /// 서버 실패 생성자
  const ServerFailure([super.message = '서버 오류가 발생했습니다.']);
}

/// 사용자를 찾을 수 없음
class UserNotFoundFailure extends AuthFailure {
  /// 사용자 없음 실패 생성자
  const UserNotFoundFailure() : super('사용자를 찾을 수 없습니다.');
}

/// 세션 만료
class SessionExpiredFailure extends AuthFailure {
  /// 세션 만료 실패 생성자
  const SessionExpiredFailure() : super('세션이 만료되었습니다. 다시 로그인해주세요.');
}

/// 알 수 없는 에러
class UnknownFailure extends AuthFailure {
  /// 알 수 없는 실패 생성자
  const UnknownFailure(super.message);
}
