import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../failures/auth_failure.dart';
import '../repositories/auth_repository.dart';

/// 현재 사용자 조회 유스케이스
///
/// 비즈니스 로직을 캡슐화하여 재사용 가능하게 합니다.
class GetCurrentUser {
  /// 현재 사용자 조회 유스케이스 생성자
  const GetCurrentUser(this._repository);

  final AuthRepository _repository;

  /// 현재 로그인된 사용자 조회 실행
  ///
  /// Returns Either 타입으로 실패 또는 사용자 정보 반환 (null이면 미인증)
  Future<Either<AuthFailure, User?>> call() async {
    return _repository.getCurrentUser();
  }
}
