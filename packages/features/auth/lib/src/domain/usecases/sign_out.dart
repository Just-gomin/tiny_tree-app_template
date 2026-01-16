import 'package:fpdart/fpdart.dart';

import '../failures/auth_failure.dart';
import '../repositories/auth_repository.dart';

/// 로그아웃 유스케이스
///
/// 비즈니스 로직을 캡슐화하여 재사용 가능하게 합니다.
class SignOut {
  /// 로그아웃 유스케이스 생성자
  const SignOut(this._repository);

  final AuthRepository _repository;

  /// 로그아웃 실행
  ///
  /// Returns Either 타입으로 실패 또는 성공 반환
  Future<Either<AuthFailure, void>> call() async {
    return _repository.signOut();
  }
}
