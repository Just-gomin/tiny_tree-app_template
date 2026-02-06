# TinyTree core/storage_interface

Tiny Tree의 저장소 추상클래스를 정의하는 패키지입니다.

## Features

- `IStorage`: 일반 키-값 저장소 인터페이스 (설정, 캐시 등)
- `ISecureStorage`: 보안 저장소 인터페이스 (토큰, 비밀번호 등)

## Usage

### IStorage 사용 예시

```dart
import 'package:storage_interface/storage_interface.dart';
import 'package:domain/domain.dart';

class MyRepository {
  final IStorage storage;
  
  Future<void> saveTheme(String theme) async {
    final result = await storage.saveString('theme', theme);
    result.when(
      success: (_) => print('테마 저장 성공'),
      failure: (error) => print('저장 실패: $error'),
    );
  }
}
```

### ISecureStorage 사용 예시

```dart
class AuthRepository {
  final ISecureStorage secureStorage;
  
  Future<void> saveToken(String token) async {
    final result = await secureStorage.write('auth_token', token);
    // handle result...
  }
}
```

## Implementation

이 패키지는 인터페이스만 정의합니다. 실제 구현체는 `app_core/storage_impl`에서 제공됩니다.
