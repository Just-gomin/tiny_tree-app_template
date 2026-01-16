import 'package:fpdart/fpdart.dart';

import '../failures/auth_failure.dart';
import '../repositories/auth_repository.dart';

/// 비밀번호 재설정 유스케이스
///
/// 비즈니스 로직을 캡슐화하여 재사용 가능하게 합니다.
class ResetPassword {
  /// 비밀번호 재설정 유스케이스 생성자
  const ResetPassword(this._repository);

  final AuthRepository _repository;

  /// 비밀번호 재설정 이메일 전송 실행
  ///
  /// [email] 비밀번호를 재설정할 이메일
  /// Returns Either 타입으로 실패 또는 성공 반환
  Future<Either<AuthFailure, void>> call({
    required String email,
  }) async {
    // 입력 검증 (도메인 수준)
    if (email.isEmpty || !email.contains('@')) {
      return const Left(InvalidCredentialsFailure());
    }

    // Repository 호출
    return _repository.sendPasswordResetEmail(
      email: email.trim(),
    );
  }
}
