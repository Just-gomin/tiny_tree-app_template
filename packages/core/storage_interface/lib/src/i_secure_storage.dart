import 'package:domain/domain.dart';

/// 보안이 필요한 데이터를 안전하게 저장하기 위한 인터페이스입니다.
///
/// 이 인터페이스는 민감한 데이터(인증 토큰, 비밀번호, API 키 등)를 암호화하여
/// 저장하는데 사용됩니다. 민감하지 않은 데이터는 [IStorage]를 사용하세요.
///
/// 구현체는 플랫폼별 보안 저장소를 사용해야 합니다:
/// - Android: EncryptedSharedPreferences 또는 Keystore
/// - iOS: Keychain
/// - Web: 브라우저의 보안 저장소 (제한적)
///
/// 모든 메서드는 [Result] 타입을 반환하여 실패 케이스를 타입 안전하게 처리합니다.
///
/// Example:
/// ```dart
/// final secureStorage = FlutterSecureStorageImpl();
/// final result = await secureStorage.write('auth_token', 'eyJhbGc...');
/// result.when(
///   success: (_) => print('토큰 저장 성공'),
///   failure: (error) => print('토큰 저장 실패: $error'),
/// );
/// ```
abstract class ISecureStorage {
  /// 민감한 데이터를 암호화하여 저장합니다.
  ///
  /// [key]: 저장할 키
  /// [value]: 저장할 문자열 값 (암호화됨)
  ///
  /// Returns: 성공 시 `Success(void)`, 실패 시 `Failure(StorageFailure)`
  Future<Result<StorageFailure, void>> write(String key, String value);

  /// 저장된 민감한 데이터를 복호화하여 가져옵니다.
  ///
  /// [key]: 가져올 키
  ///
  /// Returns: 성공 시 `Success(String?)`, 실패 시 `Failure(StorageFailure)`
  /// 키가 존재하지 않으면 `null`을 반환합니다.
  Future<Result<StorageFailure, String?>> read(String key);

  /// 특정 키의 데이터를 삭제합니다.
  ///
  /// [key]: 삭제할 키
  ///
  /// Returns: 성공 시 `Success(void)`, 실패 시 `Failure(StorageFailure)`
  Future<Result<StorageFailure, void>> delete(String key);

  /// 보안 저장소의 모든 데이터를 삭제합니다.
  ///
  /// ⚠️ 주의: 이 메서드는 민감한 데이터를 모두 삭제합니다.
  /// 로그아웃이나 계정 삭제 시에만 사용하세요.
  ///
  /// Returns: 성공 시 `Success(void)`, 실패 시 `Failure(StorageFailure)`
  Future<Result<StorageFailure, void>> deleteAll();
}
