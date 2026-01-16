import '../models/user_model.dart';

/// 원격 인증 데이터소스 인터페이스
///
/// Firebase/Supabase 등 백엔드 구현을 추상화합니다.
/// 실제 구현은 integrations 패키지에서 제공됩니다.
abstract interface class AuthDataSource {
  /// 이메일과 비밀번호로 로그인
  ///
  /// [email] 사용자 이메일
  /// [password] 사용자 비밀번호
  /// Returns UserModel
  /// Throws 인증 실패 시 예외 발생
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });

  /// 이메일과 비밀번호로 회원가입
  ///
  /// [email] 사용자 이메일
  /// [password] 사용자 비밀번호
  /// [displayName] 사용자 표시 이름 (선택)
  /// Returns UserModel
  /// Throws 회원가입 실패 시 예외 발생
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// 로그아웃
  ///
  /// Throws 로그아웃 실패 시 예외 발생
  Future<void> signOut();

  /// 현재 로그인된 사용자 가져오기
  ///
  /// Returns UserModel? (null이면 미인증)
  Future<UserModel?> getCurrentUser();

  /// 비밀번호 재설정 이메일 전송
  ///
  /// [email] 비밀번호를 재설정할 이메일
  /// Throws 이메일 전송 실패 시 예외 발생
  Future<void> sendPasswordResetEmail({required String email});

  /// 인증 상태 변화 스트림
  ///
  /// Returns 사용자 정보 스트림 (null이면 미인증)
  Stream<UserModel?> get authStateChanges;
}
