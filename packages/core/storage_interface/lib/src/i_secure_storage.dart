import 'package:domain/domain.dart';

abstract class ISecureStorage {
  Future<Result<StorageFailure, void>> write(String key, String value);
  Future<Result<StorageFailure, String?>> read(String key);
  Future<Result<StorageFailure, void>> delete(String key);
  Future<Result<StorageFailure, void>> deleteAll();
}
