/// 저장소 추상 인터페이스
///
/// 키-값 쌍으로 데이터를 저장, 조회, 삭제하는 기능을 제공합니다.
/// SharedPreferences 또는 SecureStorage 등 다양한 구현체를 사용할 수 있습니다.
abstract interface class StorageRepository {
  /// 키에 해당하는 값을 저장합니다.
  ///
  /// [key] 저장할 데이터의 키
  /// [value] 저장할 데이터의 값
  Future<void> save(String key, String value);

  /// 키에 해당하는 값을 조회합니다.
  ///
  /// [key] 조회할 데이터의 키
  /// Returns 저장된 값 또는 null (값이 없는 경우)
  Future<String?> get(String key);

  /// 키에 해당하는 값을 삭제합니다.
  ///
  /// [key] 삭제할 데이터의 키
  Future<void> delete(String key);

  /// 모든 저장된 데이터를 삭제합니다.
  Future<void> clear();

  /// 특정 키가 존재하는지 확인합니다.
  ///
  /// [key] 확인할 데이터의 키
  /// Returns 키가 존재하면 true, 그렇지 않으면 false
  Future<bool> containsKey(String key);
}
