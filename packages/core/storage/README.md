# Storage Package

Tiny Tree의 로컬 저장소 추상화 패키지입니다.

## 개요

이 패키지는 SharedPreferences와 FlutterSecureStorage에 대한 추상화 계층을 제공하여 데이터 저장소를 쉽게 교체할 수 있도록 합니다.

## 주요 기능

- **StorageRepository**: 저장소 추상 인터페이스
- **SharedPreferencesStorage**: 일반 데이터 저장용 (SharedPreferences 기반)
- **SecureStorageRepository**: 민감한 데이터 저장용 (FlutterSecureStorage 기반)

## 사용 방법

### 일반 데이터 저장 (SharedPreferencesStorage)

```dart
import 'package:storage/storage.dart';

final storage = SharedPreferencesStorage();

// 저장
await storage.save('user_name', 'John Doe');

// 조회
final userName = await storage.get('user_name');

// 삭제
await storage.delete('user_name');

// 전체 삭제
await storage.clear();
```

### 민감한 데이터 저장 (SecureStorageRepository)

```dart
import 'package:storage/storage.dart';

final secureStorage = SecureStorageRepository();

// 토큰 저장
await secureStorage.save('auth_token', 'eyJhbGciOiJIUzI1NiIs...');

// 토큰 조회
final token = await secureStorage.get('auth_token');

// 토큰 삭제
await secureStorage.delete('auth_token');
```

## 아키텍처

```
StorageRepository (인터페이스)
    ├── SharedPreferencesStorage (구현체)
    └── SecureStorageRepository (구현체)
```

## 의존성

- `shared_preferences: ^2.3.3` - SharedPreferences 구현용
- `flutter_secure_storage: ^9.2.2` - SecureStorage 구현용
