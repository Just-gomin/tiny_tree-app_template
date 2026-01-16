import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../failures/auth_failure.dart';

/// 인증 리포지토리 인터페이스
///
/// Domain과 Data 계층의 계약을 정의합니다.
/// Data 계층에서 이 인터페이스를 구현합니다.
abstract interface class AuthRepository {
  /// 이메일과 비밀번호로 로그인
  ///
  /// [email] 사용자 이메일
  /// [password] 사용자 비밀번호
  /// Returns Either\<AuthFailure, User> 실패 또는 사용자 정보
  Future<Either<AuthFailure, User>> signInWithEmail({
    required String email,
    required String password,
  });

  /// 이메일과 비밀번호로 회원가입
  ///
  /// [email] 사용자 이메일
  /// [password] 사용자 비밀번호
  /// [displayName] 사용자 표시 이름 (선택)
  /// Returns Either\<AuthFailure, User> 실패 또는 사용자 정보
  Future<Either<AuthFailure, User>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// 로그아웃
  ///
  /// Returns Either\<AuthFailure, void> 실패 또는 성공
  Future<Either<AuthFailure, void>> signOut();

  /// 현재 로그인된 사용자 가져오기
  ///
  /// Returns Either\<AuthFailure, User?> 실패 또는 사용자 정보 (null이면 미인증)
  Future<Either<AuthFailure, User?>> getCurrentUser();

  /// 비밀번호 재설정 이메일 전송
  ///
  /// [email] 비밀번호를 재설정할 이메일
  /// Returns Either\<AuthFailure, void> 실패 또는 성공
  Future<Either<AuthFailure, void>> sendPasswordResetEmail({
    required String email,
  });

  /// 인증 상태 변화 스트림
  ///
  /// 실시간으로 인증 상태 변화를 감지합니다.
  /// Returns Stream\<User?> 사용자 정보 스트림 (null이면 미인증)
  Stream<User?> get authStateChanges;
}
