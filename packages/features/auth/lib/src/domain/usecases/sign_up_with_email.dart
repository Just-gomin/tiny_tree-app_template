import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../failures/auth_failure.dart';
import '../repositories/auth_repository.dart';

/// 이메일 회원가입 유스케이스
///
/// 비즈니스 로직을 캡슐화하여 재사용 가능하게 합니다.
class SignUpWithEmail {
  /// 이메일 회원가입 유스케이스 생성자
  const SignUpWithEmail(this._repository);

  final AuthRepository _repository;

  /// 이메일과 비밀번호로 회원가입 실행
  ///
  /// [email] 사용자 이메일
  /// [password] 사용자 비밀번호
  /// [displayName] 사용자 표시 이름 (선택)
  /// Returns Either 타입으로 실패 또는 사용자 정보 반환
  Future<Either<AuthFailure, User>> call({
    required String email,
    required String password,
    String? displayName,
  }) async {
    // 입력 검증 (도메인 수준)
    if (email.isEmpty || !email.contains('@')) {
      return const Left(InvalidCredentialsFailure());
    }

    if (password.isEmpty || password.length < 6) {
      return const Left(InvalidCredentialsFailure());
    }

    // Repository 호출
    return _repository.signUpWithEmail(
      email: email.trim(),
      password: password,
      displayName: displayName?.trim(),
    );
  }
}
