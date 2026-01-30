# Tiny Tree App Template - Packages 구현 계획

## 📋 프로젝트 개요

Tiny Tree App Template의 모노레포 패키지 구조를 완성하는 계획입니다. 현재 `packages/core/domain`만 구현되어 있으며, 나머지 필수 패키지들을 단계적으로 구현합니다.

### 현재 상태

- ✅ `packages/core/domain` - 완전 구현 (Result, Failure, Entity, UseCase, ValueObject)
- ❌ `packages/core/network`, `storage`, `utils` - 미구현
- ❌ `packages/app_core/*` - 전체 디렉토리 미생성
- ❌ `packages/testing` - 미구현

### 목표

- 8개 Phase로 나누어 모든 필수 패키지 구현
- 각 Phase는 별도 브랜치에서 2시간 이내 완료
- 모든 패키지에 테스트 코드 필수 포함
- CLAUDE.md의 아키텍처 원칙 엄격히 준수

---

## 🎯 Phase 1: packages/core/network

### 브랜치

```bash
git checkout -b feat/package-core-network
```

### 작업 내용

#### 1. 패키지 생성

```bash
cd packages/core
dart create network
cd network
```

#### 2. pubspec.yaml

```yaml
name: network
description: HTTP client wrapper with Result pattern integration
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0

dependencies:
  domain:
    path: ../domain
  dio: ^5.7.0

dev_dependencies:
  lints: ^6.0.0
  test: ^1.25.6
  mockito: ^5.4.4
  build_runner: ^2.4.13
```

#### 3. analysis_options.yaml

```yaml
include: ../../../analysis_options.yaml
```

#### 4. 디렉토리 구조

```text
lib/
├── network.dart (배럴 파일)
└── src/
    ├── client/
    │   ├── api_client.dart
    │   └── api_client_config.dart
    ├── interceptor/
    │   ├── logging_interceptor.dart
    │   └── error_interceptor.dart
    ├── exception/
    │   └── network_exception.dart
    └── mapper/
        └── failure_mapper.dart
```

#### 5. 핵심 구현 사항

- **ApiClient**: Dio 래핑, Result 패턴 반환
  - `Future<Result<NetworkFailure, T>> get<T>(String path)`
  - `Future<Result<NetworkFailure, T>> post<T>(String path, dynamic data)`
  - `Future<Result<NetworkFailure, T>> put<T>(String path, dynamic data)`
  - `Future<Result<NetworkFailure, T>> delete<T>(String path)`
- **FailureMapper**: DioException → NetworkFailure 변환
- **ErrorInterceptor**: 자동 에러 처리

#### 6. 테스트

```text
test/
├── client/api_client_test.dart
├── interceptor/error_interceptor_test.dart
└── mapper/failure_mapper_test.dart
```

#### 7. 루트 pubspec.yaml 업데이트

```yaml
workspace:
  - packages/core/domain
  - packages/core/network  # 추가
```

### 검증

```bash
cd packages/core/network
dart analyze
dart test
cd ../../..
melos bootstrap
```

### 예상 소요 시간: 2시간

- 패키지 생성 및 설정: 15분
- ApiClient 구현: 45분
- Interceptor 및 Mapper: 30분
- 테스트 작성: 30분

---

## 🎯 Phase 2: packages/core/storage + utils

### 브랜치

```bash
git checkout -b feat/package-core-storage-utils
```

### 작업 내용

#### packages/core/storage (인터페이스만)

##### 1. 패키지 생성

```bash
cd packages/core
dart create storage
cd storage
```

##### 2. pubspec.yaml

```yaml
name: storage
description: Storage interfaces for TinyTree
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0

dependencies:
  domain:
    path: ../domain

dev_dependencies:
  lints: ^6.0.0
  test: ^1.25.6
```

##### 3. 구조

```text
lib/
├── storage.dart
└── src/
    ├── storage_interface.dart
    └── secure_storage_interface.dart
```

##### 4. 핵심 인터페이스

```dart
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

abstract class ISecureStorage {
  Future<Result<StorageFailure, void>> write(String key, String value);
  Future<Result<StorageFailure, String?>> read(String key);
  Future<Result<StorageFailure, void>> delete(String key);
  Future<Result<StorageFailure, void>> deleteAll();
}
```

##### 5. Failure 추가 (domain 패키지에)

```dart
// packages/core/domain/lib/src/failure/failure.dart에 추가
final class StorageFailure extends Failure {
  const StorageFailure(super.message, {this.key});
  final String? key;

  @override
  List<Object?> get props => <Object?>[message, key];
}
```

#### packages/core/utils (순수 Dart 유틸리티)

##### 1. 패키지 생성

```bash
cd packages/core
dart create utils
cd utils
```

##### 2. pubspec.yaml

```yaml
name: utils
description: Pure Dart utilities
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0

dependencies:
  intl: ^0.20.1

dev_dependencies:
  lints: ^6.0.0
  test: ^1.25.6
```

##### 3. 구조

```text
lib/
├── utils.dart
└── src/
    ├── string_utils.dart
    ├── date_utils.dart
    ├── number_utils.dart
    └── validation_utils.dart
```

##### 4. 핵심 유틸리티

- **StringUtils**: `isNullOrEmpty`, `capitalize`, `truncate`
- **DateUtils**: `formatDate`, `parseIso8601`, `daysBetween`
- **NumberUtils**: `formatCurrency`, `roundTo`, `toPercentage`
- **ValidationUtils**: `isValidEmail`, `isValidPhone`, `isValidUrl`

### 검증

```bash
cd packages/core/storage && dart analyze && dart test
cd ../utils && dart analyze && dart test
cd ../../..
melos bootstrap
```

### 예상 소요 시간: 2시간

- storage 인터페이스: 30분
- utils 구현: 60분
- 테스트: 30분

---

## 🎯 Phase 3: packages/app_core/theme

### 브랜치

```bash
git checkout -b feat/package-app-core-theme
```

### 작업 내용

#### 1. app_core 디렉토리 생성

```bash
mkdir -p packages/app_core
cd packages/app_core
flutter create --template=package theme
cd theme
```

#### 2. pubspec.yaml

```yaml
name: theme
description: Material3 theme for TinyTree apps
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0
  flutter: ">=3.38.0"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0
```

#### 3. analysis_options.yaml

```yaml
include: ../../../analysis_options.yaml
```

#### 4. 구조

```text
lib/
├── theme.dart
└── src/
    ├── colors/
    │   ├── app_colors.dart
    │   └── color_schemes.dart
    ├── typography/
    │   ├── app_text_styles.dart
    │   └── app_fonts.dart
    ├── theme/
    │   ├── app_theme.dart
    │   ├── light_theme.dart
    │   └── dark_theme.dart
    └── constants/
        └── spacing.dart
```

#### 5. 핵심 구현

- **AppColors**: Material3 색상 팔레트
- **ColorSchemes**: Light/Dark ColorScheme
- **AppTextStyles**: Display, Headline, Body, Label
- **AppTheme**: `light()`, `dark()` ThemeData 생성
- **Spacing**: xs(4), sm(8), md(16), lg(24), xl(32), xxl(48)

#### 6. Material3 적용

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(...),
  textTheme: TextTheme(...),
)
```

### 검증

```bash
cd packages/app_core/theme
flutter analyze
flutter test
cd ../../..
melos bootstrap
```

### 예상 소요 시간: 2시간

- 색상 정의: 30분
- Typography: 30분
- ThemeData 구성: 30분
- 테스트: 30분

---

## 🎯 Phase 4: packages/app_core/ui_kit

### 브랜치

```bash
git checkout -b feat/package-app-core-ui-kit
```

### 작업 내용

#### 1. 패키지 생성

```bash
cd packages/app_core
flutter create --template=package ui_kit
cd ui_kit
```

#### 2. pubspec.yaml

```yaml
name: ui_kit
description: Reusable UI components
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0
  flutter: ">=3.38.0"

dependencies:
  flutter:
    sdk: flutter
  theme:
    path: ../theme

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0
```

#### 3. 구조

```text
lib/
├── ui_kit.dart
└── src/
    ├── buttons/
    │   ├── primary_button.dart
    │   ├── secondary_button.dart
    │   └── text_button.dart
    ├── cards/
    │   ├── app_card.dart
    │   └── list_tile_card.dart
    ├── dialogs/
    │   ├── alert_dialog.dart
    │   └── confirmation_dialog.dart
    ├── inputs/
    │   ├── app_text_field.dart
    │   └── search_field.dart
    └── loading/
        ├── loading_indicator.dart
        └── shimmer_loading.dart
```

#### 4. 핵심 위젯

- **PrimaryButton**: FilledButton 기반
- **SecondaryButton**: OutlinedButton 기반
- **AppCard**: Material3 카드
- **AppAlertDialog**: 커스텀 다이얼로그
- **AppTextField**: 검증 지원
- **LoadingIndicator**: 로딩 표시

### 검증

```bash
cd packages/app_core/ui_kit
flutter analyze
flutter test
cd ../../..
melos bootstrap
```

### 예상 소요 시간: 2시간

- Buttons: 30분
- Cards: 20분
- Dialogs: 30분
- Inputs: 20분
- Loading: 10분
- 테스트: 30분

---

## 🎯 Phase 5: packages/app_core/storage + utils

### 브랜치

```bash
git checkout -b feat/package-app-core-storage-utils
```

### 작업 내용

#### packages/app_core/storage (구현체)

##### 1. 패키지 생성

```bash
cd packages/app_core
flutter create --template=package storage
cd storage
```

##### 2. pubspec.yaml

```yaml
name: storage
description: Storage implementations for Flutter
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0
  flutter: ">=3.38.0"

dependencies:
  flutter:
    sdk: flutter
  domain:
    path: ../../core/domain
  storage:
    path: ../../core/storage
  shared_preferences: ^2.3.4
  flutter_secure_storage: ^9.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0
  mockito: ^5.4.4
```

##### 3. 구조

```text
lib/
├── storage.dart
└── src/
    ├── shared_prefs_storage.dart
    ├── secure_storage_impl.dart
    └── storage_keys.dart
```

##### 4. 핵심 구현

- **SharedPrefsStorage implements IStorage**
- **SecureStorageImpl implements ISecureStorage**
- Result 패턴으로 모든 메서드 구현

#### packages/app_core/utils (Flutter 유틸리티)

##### 1. 패키지 생성

```bash
cd packages/app_core
flutter create --template=package utils
cd utils
```

##### 2. pubspec.yaml

```yaml
name: utils
description: Flutter utility functions
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0
  flutter: ">=3.38.0"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0
```

##### 3. 구조

```text
lib/
├── utils.dart
└── src/
    ├── context_extensions.dart
    ├── widget_utils.dart
    ├── responsive_utils.dart
    └── snackbar_utils.dart
```

##### 4. 핵심 기능

- **ContextExtensions**: `context.theme`, `context.mediaQuery`
- **ResponsiveUtils**: `isMobile`, `isTablet`, `isDesktop`
- **SnackbarUtils**: `showSuccessSnackbar`, `showErrorSnackbar`

### 검증

```bash
cd packages/app_core/storage && flutter analyze && flutter test
cd ../utils && flutter analyze && flutter test
cd ../../..
melos bootstrap
```

### 예상 소요 시간: 2시간

- storage 구현: 60분
- utils 구현: 30분
- 테스트: 30분

---

## 🎯 Phase 6: packages/testing

### 브랜치

```bash
git checkout -b feat/package-testing
```

### 작업 내용

#### 1. 패키지 생성

```bash
cd packages
flutter create --template=package testing
cd testing
```

#### 2. pubspec.yaml

```yaml
name: testing
description: Testing utilities and mocks
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0
  flutter: ">=3.38.0"

dependencies:
  flutter:
    sdk: flutter
  domain:
    path: ../core/domain
  network:
    path: ../core/network
  storage:
    path: ../core/storage
  theme:
    path: ../app_core/theme
  mockito: ^5.4.4
  flutter_test:
    sdk: flutter

dev_dependencies:
  flutter_lints: ^7.0.0
  build_runner: ^2.4.13
```

#### 3. 구조

```text
lib/
├── testing.dart
└── src/
    ├── mocks/
    │   ├── mock_api_client.dart
    │   ├── mock_storage.dart
    │   └── mock_secure_storage.dart
    ├── fixtures/
    │   ├── json_fixture.dart
    │   └── test_data.dart
    └── helpers/
        ├── widget_test_helpers.dart
        └── pump_app.dart
```

#### 4. 핵심 구현

- **MockApiClient**: network Mock
- **MockStorage**: storage Mock
- **JsonFixture**: JSON 로드 헬퍼
- **pumpApp()**: MaterialApp 래핑 헬퍼

### 검증

```bash
cd packages/testing
flutter analyze
flutter test
cd ../..
melos bootstrap
```

### 예상 소요 시간: 1.5시간

---

## 🎯 Phase 7: Melos workspace 통합 및 검증

### 브랜치

```bash
git checkout -b feat/workspace-integration
```

### 작업 내용

#### 1. 루트 pubspec.yaml 완성

```yaml
workspace:
  - packages/core/domain
  - packages/core/network
  - packages/core/storage
  - packages/core/utils
  - packages/app_core/theme
  - packages/app_core/ui_kit
  - packages/app_core/storage
  - packages/app_core/utils
  - packages/testing
```

#### 2. Melos Scripts 추가

```yaml
melos:
  scripts:
    analyze:
      description: Analyze all packages
      run: melos exec -- flutter analyze

    test:
      description: Run tests for all packages
      run: melos exec -- flutter test

    format:
      description: Format all packages
      run: melos exec -- dart format .

    clean:
      description: Clean all packages
      run: melos exec -- flutter clean
```

#### 3. 전체 검증

```bash
melos clean
melos bootstrap
melos run analyze
melos run test
melos run format
```

#### 4. 의존성 그래프 문서화

```text
domain
  ↓
network, storage, utils
  ↓
theme
  ↓
ui_kit, app_core/storage, app_core/utils
  ↓
testing
```

### 검증

```bash
melos bootstrap
melos run analyze
melos run test
```

### 예상 소요 시간: 1시간

---

## 🎯 Phase 8: 샘플 앱 생성 (apps/example)

### 브랜치

```bash
git checkout -b feat/app-example
```

### 작업 내용

#### 1. apps 디렉토리 및 앱 생성

```bash
mkdir -p apps
cd apps
flutter create example
cd example
```

#### 2. pubspec.yaml

```yaml
name: example
description: Example app using TinyTree packages
version: 1.0.0
publish_to: none

environment:
  sdk: ^3.10.0
  flutter: ">=3.38.0"

dependencies:
  flutter:
    sdk: flutter

  # Core packages
  domain:
    path: ../../packages/core/domain
  network:
    path: ../../packages/core/network
  utils:
    path: ../../packages/core/utils

  # App Core packages
  theme:
    path: ../../packages/app_core/theme
  ui_kit:
    path: ../../packages/app_core/ui_kit
  storage:
    path: ../../packages/app_core/storage

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0
  testing:
    path: ../../packages/testing
```

#### 3. 구조

```text
lib/
├── main.dart
├── app.dart
└── features/
    ├── home/
    │   └── home_screen.dart
    ├── demo/
    │   ├── theme_demo_screen.dart
    │   ├── ui_kit_demo_screen.dart
    │   └── storage_demo_screen.dart
    └── settings/
        └── settings_screen.dart
```

#### 4. 기능

- Material3 테마 적용
- UI Kit 위젯 데모
- Storage 사용 예시
- Network 호출 예시 (Mock API)

#### 5. 루트 pubspec.yaml에 앱 추가

```yaml
workspace:
  # ... 기존 패키지들
  - apps/example
```

### 검증

```bash
cd apps/example
flutter analyze
flutter test
flutter run -d chrome
```

### 예상 소요 시간: 2시간

---

## 📊 전체 작업 요약

| Phase | 브랜치 | 작업 내용 | 시간 | 누적 |
| :---: | :--- | :--- | :---: | :---: |
| 1 | feat/package-core-network | core/network | 2h | 2h |
| 2 | feat/package-core-storage-utils | core/storage + utils | 2h | 4h |
| 3 | feat/package-app-core-theme | app_core/theme | 2h | 6h |
| 4 | feat/package-app-core-ui-kit | app_core/ui_kit | 2h | 8h |
| 5 | feat/package-app-core-storage-utils | app_core/storage + utils | 2h | 10h |
| 6 | feat/package-testing | testing | 1.5h | 11.5h |
| 7 | feat/workspace-integration | Melos 통합 | 1h | 12.5h |
| 8 | feat/app-example | 샘플 앱 | 2h | 14.5h |

**총 예상 시간**: 14.5시간

---

## ✅ 각 Phase별 완료 체크리스트

각 Phase 완료 시 다음을 확인:

- [ ] 브랜치 생성 및 체크아웃
- [ ] 패키지 디렉토리 생성
- [ ] `pubspec.yaml` 작성
- [ ] `analysis_options.yaml` 생성
- [ ] 배럴 파일 작성
- [ ] 핵심 기능 구현
- [ ] 테스트 코드 작성
- [ ] `flutter analyze` 또는 `dart analyze` 통과
- [ ] `flutter test` 또는 `dart test` 모든 테스트 통과
- [ ] README.md 작성 (사용 예시 포함)
- [ ] 루트 `pubspec.yaml` workspace 업데이트
- [ ] `melos bootstrap` 성공
- [ ] PR 생성 및 리뷰
- [ ] main 브랜치 머지

---

## 🔍 검증 방법

### Phase 완료 시

```bash
# 개별 패키지
cd packages/[category]/[package_name]
flutter analyze  # 또는 dart analyze
flutter test     # 또는 dart test

# 전체 workspace
cd [project_root]
melos bootstrap
melos run analyze
melos run test
```

### 최종 검증 (Phase 7 후)

```bash
melos clean
melos bootstrap
melos run analyze
melos run test
melos run format

# 샘플 앱 실행 (Phase 8 후)
cd apps/example
flutter run -d chrome
```

---

## 📦 중요 파일 경로

### 참고 파일

- `/packages/core/domain/lib/src/result/result.dart` - Result 패턴
- `/packages/core/domain/lib/src/failure/failure.dart` - Failure 타입
- `/packages/core/domain/pubspec.yaml` - pubspec 템플릿
- `/pubspec.yaml` - Workspace 설정
- `/analysis_options.yaml` - Linter 규칙

### 생성될 파일

각 Phase에서 생성되는 패키지의 핵심 파일 경로는 위의 각 Phase 설명을 참고하세요.

---

## 🚨 주의사항

1. **의존성 순서**: core → app_core → features/apps 순서 준수
2. **Result 패턴**: 모든 비동기 메서드는 `Result<Failure, T>` 반환
3. **테스트 커버리지**: 핵심 기능은 반드시 테스트 작성
4. **analysis_options.yaml**: 모든 패키지는 루트 설정 참조
5. **pubspec.yaml**: `resolution: workspace` 필수
6. **브랜치 전략**: 각 Phase는 main에서 분기, 리뷰 후 머지
7. **Melos bootstrap**: 패키지 추가 시마다 실행

---

## 📚 추가 리소스

- [CLAUDE.md](../../CLAUDE.md) - 프로젝트 전체 가이드
- [Melos 공식 문서](https://melos.invertase.dev/)
- [Material 3 디자인 가이드](https://m3.material.io/)
- [Dart 패키지 가이드](https://dart.dev/guides/libraries/create-packages)
