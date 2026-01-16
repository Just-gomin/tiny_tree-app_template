import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/src/storage_repository.dart';

/// SharedPreferences 기반 저장소 구현체
///
/// 일반적인 데이터 저장에 사용합니다.
/// 토큰이나 민감한 데이터는 [SecureStorageRepository]를 사용하세요.
class SharedPreferencesStorage implements StorageRepository {
  SharedPreferencesStorage({SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  SharedPreferences? _sharedPreferences;

  /// SharedPreferences 인스턴스를 가져옵니다.
  Future<SharedPreferences> get _prefs async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  @override
  Future<void> save(String key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
  }

  @override
  Future<String?> get(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    final prefs = await _prefs;
    return prefs.containsKey(key);
  }
}
