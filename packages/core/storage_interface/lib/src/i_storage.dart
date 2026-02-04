import 'package:domain/domain.dart';

abstract class IStorage {
  Future<Result<StorageFailure, void>> saveString(String key, String value);
  Future<Result<StorageFailure, String?>> getString(String key);
  Future<Result<StorageFailure, void>> saveInt(String key, int value);
  Future<Result<StorageFailure, int?>> getInt(String key);
  Future<Result<StorageFailure, void>> saveBool(String key, bool value);
  Future<Result<StorageFailure, bool?>> getBool(String key);
  Future<Result<StorageFailure, void>> remove(String key);
  Future<Result<StorageFailure, void>> clear();
}
