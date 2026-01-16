import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../failures/auth_failure.dart';
import '../repositories/auth_repository.dart';

/// 이메일 로그인 유스케이스
///
/// 비즈니스 로직을 캡슐화하여 재사용 가능하게 합니다.
class SignInWithEmail {
  /// 이메일 로그인 유스케이스 생성자
  const SignInWithEmail(this._repository);

  final AuthRepository _repository;

  /// 이메일과 비밀번호로 로그인 실행
  ///
  /// [email] 사용자 이메일
  /// [password] 사용자 비밀번호
  /// Returns Either 타입으로 실패 또는 사용자 정보 반환
  Future<Either<AuthFailure, User>> call({
    required String email,
    required String password,
  }) async {
    // 입력 검증 (도메인 수준)
    if (email.isEmpty || !email.contains('@')) {
      return const Left(InvalidCredentialsFailure());
    }

    if (password.isEmpty || password.length < 6) {
      return const Left(InvalidCredentialsFailure());
    }

    // Repository 호출
    return _repository.signInWithEmail(
      email: email.trim(),
      password: password,
    );
  }
}
