import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storage/src/storage_repository.dart';

/// FlutterSecureStorage 기반 저장소 구현체
///
/// 토큰, 비밀번호 등 민감한 데이터 저장에 사용합니다.
/// iOS Keychain과 Android KeyStore를 활용하여 안전하게 데이터를 저장합니다.
class SecureStorageRepository implements StorageRepository {
  SecureStorageRepository({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> save(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> get(String key) async {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _secureStorage.containsKey(key: key);
  }
}
