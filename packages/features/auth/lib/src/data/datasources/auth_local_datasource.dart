import '../models/auth_token_model.dart';
import '../models/user_model.dart';

/// 로컬 인증 데이터소스 인터페이스
///
/// 토큰, 사용자 정보 로컬 저장소 관리를 추상화합니다.
abstract interface class AuthLocalDataSource {
  /// 토큰 저장
  ///
  /// [token] 저장할 인증 토큰
  Future<void> saveToken(AuthTokenModel token);

  /// 토큰 조회
  ///
  /// Returns AuthTokenModel? (저장된 토큰이 없으면 null)
  Future<AuthTokenModel?> getToken();

  /// 토큰 삭제
  Future<void> deleteToken();

  /// 사용자 정보 저장 (캐싱)
  ///
  /// [user] 저장할 사용자 정보
  Future<void> saveUser(UserModel user);

  /// 사용자 정보 조회
  ///
  /// Returns UserModel? (저장된 사용자 정보가 없으면 null)
  Future<UserModel?> getUser();

  /// 사용자 정보 삭제
  Future<void> deleteUser();
}
