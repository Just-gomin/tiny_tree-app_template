# network

HTTP 클라이언트 래퍼 패키지로, Dio를 기반으로 Result 패턴을 통합합니다.

## 특징

- ✅ **Type-safe 에러 처리**: 모든 HTTP 메서드가 `Result<NetworkFailure, T>` 반환
- ✅ **자동 에러 변환**: DioException → NetworkFailure 자동 매핑
- ✅ **한국어 에러 메시지**: 사용자 친화적인 에러 메시지 제공
- ✅ **디버깅 지원**: 선택적 로깅 인터셉터
- ✅ **확장 가능**: 401 토큰 갱신 등 향후 기능 추가 용이

## 설치

`pubspec.yaml`에 의존성 추가:

```yaml
dependencies:
  network:
    path: ../packages/core/network
```

## 사용법

### 1. ApiClient 생성

```dart
import 'package:network/network.dart';

final ApiClient apiClient = ApiClient(
  ApiClientConfig(
    baseUrl: 'https://api.example.com',
    connectTimeout: Duration(seconds: 10),
    enableLogging: true, // 개발 환경에서만 사용
  ),
);
```

### 2. GET 요청

```dart
final Result<NetworkFailure, dynamic> result =
    await apiClient.get<dynamic>('/users/1');

// 패턴 매칭으로 처리
switch (result) {
  case Success(:final value):
    print('User: $value');
  case Error(:final failure):
    print('Error: ${failure.message}');
}

// 또는 fold 사용
result.fold(
  onSuccess: (data) => print('User: $data'),
  onError: (failure) => print('Error: ${failure.message}'),
);
```

### 3. POST 요청

```dart
final Result<NetworkFailure, dynamic> result =
    await apiClient.post<dynamic>(
      '/users',
      data: {'name': 'John', 'email': 'john@example.com'},
    );

if (result.isSuccess) {
  print('User created: ${result.valueOrNull}');
}
```

### 4. 쿼리 파라미터 사용

```dart
final result = await apiClient.get<dynamic>(
  '/users',
  queryParameters: {'page': '1', 'limit': '10'},
);
```

### 5. JSON 파싱

ApiClient는 순수 Dart 패키지이므로 JSON 파싱은 호출자가 담당합니다:

```dart
// Repository에서
class UserRepository {
  final ApiClient _apiClient;

  Future<Result<NetworkFailure, User>> getUser(String id) async {
    final result = await _apiClient.get<dynamic>('/users/$id');

    // Result의 map 메서드로 JSON → Entity 변환
    return result.map((json) => User.fromJson(json as Map<String, dynamic>));
  }
}
```

## 에러 처리

NetworkFailure는 다음 정보를 포함합니다:

- `message`: 사용자 친화적인 한국어 에러 메시지
- `statusCode`: HTTP 상태 코드 (있는 경우)

```dart
final result = await apiClient.get<dynamic>('/users/999');

if (result.isError) {
  final failure = result.failureOrNull!;

  if (failure.statusCode == 404) {
    print('사용자를 찾을 수 없습니다.');
  } else if (failure.statusCode == 401) {
    print('인증이 필요합니다.');
  } else {
    print('에러: ${failure.message}');
  }
}
```

## 설정

### ApiClientConfig 옵션

| 옵션 | 타입 | 기본값 | 설명 |
| :------: | :------: | :--------: | :------: |
| `baseUrl` | `String` | - | API 기본 URL (필수) |
| `connectTimeout` | `Duration` | 30초 | 연결 타임아웃 |
| `receiveTimeout` | `Duration` | 30초 | 응답 수신 타임아웃 |
| `sendTimeout` | `Duration` | 30초 | 요청 전송 타임아웃 |
| `headers` | `Map<String, String>` | {} | 기본 헤더 |
| `enableLogging` | `bool` | false | 로깅 활성화 |

### 로깅

개발 환경에서 HTTP 요청/응답을 콘솔에 출력하려면:

```dart
final apiClient = ApiClient(
  ApiClientConfig(
    baseUrl: 'https://api.example.com',
    enableLogging: true, // ← 개발 환경에서만
  ),
);
```

**주의**: 프로덕션에서는 민감한 정보(토큰, 비밀번호) 노출 방지를 위해 비활성화하세요.

## 테스트

```bash
cd packages/core/network
dart test
```

### 테스트에서 사용

```dart
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:network/network.dart';

void main() {
  test('example', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
    final dioAdapter = DioAdapter(dio: dio);
    final apiClient = ApiClient.withDio(dio);

    dioAdapter.onGet('/users/1', (server) => server.reply(200, {'id': '1'}));

    final result = await apiClient.get<dynamic>('/users/1');
    expect(result.isSuccess, isTrue);
  });
}
```

## 아키텍처

```text
network/
├── ApiClient          # Dio 래퍼, Result 패턴 반환
├── ApiClientConfig    # 설정 관리
├── FailureMapper      # DioException → NetworkFailure 변환
├── ErrorInterceptor   # 공통 에러 처리
└── LoggingInterceptor # 디버깅용 로깅
```

## 라이선스

이 패키지는 Tiny Tree App Template 프로젝트의 일부입니다.
