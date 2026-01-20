// 인증 관련 예외 클래스들 (integrations 패키지에서 실제 구현 시 사용)
///
///
sealed class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException($message)';
}

/// 잘못된 인증 정보 예외
class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException() : super('인증 정보가 유효하지 않습니다.');
}

/// 네트워크 예외
class NetworkException extends AuthException {
  const NetworkException() : super('네트워크 오류가 발생했습니다.');
}

/// 사용자 중복 예외
class UserAlreadyExistsException extends AuthException {
  const UserAlreadyExistsException() : super('이미 가입된 사용자 입니다.');
}

/// 세션 만료 예외
class SessionExpiredException extends AuthException {
  const SessionExpiredException() : super('세션이 만료됐습니다.');
}

/// 사용자 없음 예외
class UserNotFoundException extends AuthException {
  const UserNotFoundException() : super('해당하는 사용자가 존재하지 않습니다.');
}
