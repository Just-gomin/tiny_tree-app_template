import 'package:domain/domain.dart';

/// 일반적인 키-값 저장소를 위한 인터페이스입니다.
///
/// 이 인터페이스는 민감하지 않은 데이터(설정값, 캐시 등)를 저장하는데 사용됩니다.
/// 민감한 데이터(토큰, 비밀번호 등)는 [ISecureStorage]를 사용하세요.
///
/// 모든 메서드는 [Result] 타입을 반환하여 실패 케이스를 타입 안전하게 처리합니다.
///
/// Example:
/// ```dart
/// final storage = SharedPreferencesStorage();
/// final result = await storage.saveString('theme', 'dark');
/// result.when(
///   success: (_) => print('저장 성공'),
///   failure: (error) => print('저장 실패: $error'),
/// );
/// ```
abstract class IStorage {
  /// 문자열 값을 저장합니다.
  ///
  /// [key]: 저장할 키
  /// [value]: 저장할 문자열 값
  ///
  /// Returns: 성공 시 `Success(void)`, 실패 시 `Failure(StorageFailure)`
  Future<Result<StorageFailure, void>> saveString(String key, String value);

  /// 저장된 문자열 값을 가져옵니다.
  ///
  /// [key]: 가져올 키
  ///
  /// Returns: 성공 시 `Success(String?)`, 실패 시 `Failure(StorageFailure)`
  /// 키가 존재하지 않으면 `null`을 반환합니다.
  Future<Result<StorageFailure, String?>> getString(String key);

  /// 정수 값을 저장합니다.
  ///
  /// [key]: 저장할 키
  /// [value]: 저장할 정수 값
  ///
  /// Returns: 성공 시 `Success(void)`, 실패 시 `Failure(StorageFailure)`
  Future<Result<StorageFailure, void>> saveInt(String key, int value);

  /// 저장된 정수 값을 가져옵니다.
  ///
  /// [key]: 가져올 키
  ///
  /// Returns: 성공 시 `Success(int?)`, 실패 시 `Failure(StorageFailure)`
  /// 키가 존재하지 않으면 `null`을 반환합니다.
  Future<Result<StorageFailure, int?>> getInt(String key);

  /// 불린 값을 저장합니다.
  ///
  /// [key]: 저장할 키
  /// [value]: 저장할 불린 값
  ///
  /// Returns: 성공 시 `Success(void)`, 실패 시 `Failure(StorageFailure)`
  // ignore: avoid_positional_boolean_parameters
  Future<Result<StorageFailure, void>> saveBool(String key, bool value);

  /// 저장된 불린 값을 가져옵니다.
  ///
  /// [key]: 가져올 키
  ///
  /// Returns: 성공 시 `Success(bool?)`, 실패 시 `Failure(StorageFailure)`
  /// 키가 존재하지 않으면 `null`을 반환합니다.
  Future<Result<StorageFailure, bool?>> getBool(String key);

  /// 특정 키의 값을 삭제합니다.
  ///
  /// [key]: 삭제할 키
  ///
  /// Returns: 성공 시 `Success(void)`, 실패 시 `Failure(StorageFailure)`
  Future<Result<StorageFailure, void>> remove(String key);

  /// 저장소의 모든 데이터를 삭제합니다.
  ///
  /// Returns: 성공 시 `Success(void)`, 실패 시 `Failure(StorageFailure)`
  Future<Result<StorageFailure, void>> clear();
}
