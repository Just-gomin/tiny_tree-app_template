# CLAUDE.md

## Answering Request

- Please answer in korean.

## Project Overview

Tiny Tree App Template은 AI 기반 소프트웨어 개발 자동화 시스템의 Flutter 앱 템플릿 프로젝트입니다.

- **초기 목표**: 1시간 내 MVP 생성 및 배포
- **중장기 목표**: 대규모 프로젝트의 지속 가능한 개발 지원

### 기술 스택

- Dart 3.10+
- Flutter (Web, Mobile) 3.38+
- Melos 7.0+ (Dart Pub Workspace 기반 모노레포 관리)
- Firebase / Supabase (서버리스 백엔드)

### 관련 프로젝트

- [tiny_tree-slack_bot](https://github.com/Just-gomin/tiny_tree-slack_bot): Slack Bot - 사용자 인터페이스, 파이프라인 오케스트레이션

## Project Structure

```text
tiny_tree-app_template/
├── apps/                    # 생성된 앱들
│   └── [app_name]/          # 개별 앱 프로젝트
├── packages/                # 재사용 가능한 패키지
│   ├── core/                # 순수 Dart 패키지 (Flutter 의존성 없음)
│   │   ├── domain/          # Entity, Value Object, Failure, Exception
│   │   ├── network/         # HTTP 클라이언트 (dio 등)
│   │   └── utils/           # 순수 Dart 유틸리티 (문자열, 날짜, 숫자 등)
│   ├── app_core/            # Flutter 의존 패키지 (모든 앱 공통)
│   │   ├── theme/           # Material Theme, 색상, 타이포그래피
│   │   ├── ui_kit/          # 공용 위젯 (버튼, 카드, 다이얼로그)
│   │   ├── storage/         # SharedPreferences, Hive 래퍼
│   │   └── utils/           # Flutter 관련 유틸리티
│   ├── features/            # 비즈니스 기능 (선택적)
│   │   ├── auth/            # 인증
│   │   ├── payment/         # 결제
│   │   ├── analytics/       # 분석
│   │   ├── notification/    # 알림
│   │   ├── onboarding/      # 온보딩
│   │   ├── settings/        # 설정
│   │   └── feedback/        # 사용자 피드백
│   ├── integrations/        # 서드파티 래퍼 (교체 가능)
│   │   ├── firebase/
│   │   ├── supabase/
│   │   └── revenue_cat/
│   └── testing/             # 테스트 유틸리티
│       ├── mocks/
│       └── fixtures/
├── pubspec.yaml             # 루트 pubspec (Melos 및 Workspace 설정 포함)
└── analysis_options.yaml    # Dart 분석 옵션
```

### 패키지 분류 기준

- **packages/core/**: 순수 Dart 구현체로 Flutter 의존성이 없습니다. Slack Bot, CLI 도구, 백엔드 서버에서도 재사용 가능합니다.
- **packages/app_core/**: Flutter에 의존하는 패키지로 Widget, Material, Theme 등을 사용합니다.
- **packages/features/**: 비즈니스 기능별 패키지로 presentation layer를 포함합니다.

## Package Architecture

### 설계 원칙

| 원칙 | 설명 |
| :------: | :------: |
| **의존성 명확성** | Flutter 의존 여부를 디렉토리 레벨에서 구분 (core vs app_core) |
| **기능별 분리** | 레이어별이 아닌 기능별로 패키지 분리 |
| **선택적 의존성** | 필요한 기능만 import하여 사용 |
| **독립적 확장** | 각 패키지 내부만 수정하여 기능 고도화 |
| **명확한 Public API** | 배럴 파일을 통한 인터페이스 제공 |
| **크로스 플랫폼 재사용** | core 패키지는 Flutter 외 Dart 프로젝트에서도 재사용 가능 |

### 기능 패키지 내부 구조

각 기능 패키지는 내부에서 레이어를 유지하되 단순화합니다:

```text
packages/features/[feature_name]/
├── lib/
│   ├── [feature_name].dart  # 배럴 파일 (public API)
│   └── src/
│       ├── domain/          # 엔티티, 유스케이스
│       ├── data/            # 레포지토리 구현
│       └── presentation/    # 위젯, 화면
├── test/                    # 테스트
└── pubspec.yaml
```

### 패키지 분류

| 분류 | 용도 | Flutter 의존 | 필수 여부 |
| :------: | :------: | :----------: | :----------: |
| `core/` | 순수 Dart 기반 (Entity, 비즈니스 로직, HTTP 클라이언트) | 없음 | 필수 |
| `app_core/` | Flutter 의존 기반 (Widget, Theme, Storage) | 있음 | 필수 |
| `features/` | 비즈니스 기능 (UI 포함) | 있음 | 선택 |
| `integrations/` | 서드파티 SDK 래퍼 | 혼재 | 선택 |
| `testing/` | 테스트 유틸리티 | 혼재 | 개발 시 |

## Creating New Package

### 패키지 분류 결정하기

새 패키지를 생성하기 전에 `packages/core/` 또는 `packages/app_core/`에 위치시킬지 결정해야 합니다.

**간단한 체크리스트**:

- [ ] Widget, BuildContext, Material 등을 사용하는가? → `app_core`
- [ ] Color, TextStyle, ThemeData 등 UI 관련 타입을 사용하는가? → `app_core`
- [ ] Slack Bot, CLI, 백엔드에서 재사용할 수 있는가? → `core`
- [ ] Entity, 비즈니스 로직, HTTP 클라이언트인가? → `core`

상세한 분류 기준은 아래 문서의 "Package Classification Guide" 섹션을 참고하세요.

### 패키지 생성 절차

1. 패키지 위치 결정: `packages/core/` 또는 `packages/app_core/`
2. `packages/[category]/[package_name]/` 디렉토리 생성
3. `packages/package_template` 디렉토리 하위 파일 내용을 복사
4. 패키지 정보 변경
    - `pubspec.yaml`의 `name`, `description`, 의존성
    - `README.md`의 제목과 설명
5. `analysis_options.yaml` 경로 수정
    - `include: ../../../analysis_options.yaml`
6. `lib/src/` 하위에 구현 코드 작성
7. `melos bootstrap` 실행

### pubspec.yaml 템플릿

#### packages/core/ 패키지 (순수 Dart)

```yaml
name: [package_name]
description: [패키지 설명]
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0

# 순수 Dart 의존성만 추가
dependencies:
  # 예: http, dio, json_serializable 등

dev_dependencies:
  lints: ^6.0.0
  test: ^1.25.6
```

#### packages/app_core/ 패키지 (Flutter 의존)

```yaml
name: [package_name]
description: [패키지 설명]
version: 0.1.0
publish_to: none
resolution: workspace

environment:
  sdk: ^3.10.0
  flutter: ">=3.38.0"

dependencies:
  flutter:
    sdk: flutter
  # 필요한 의존성 추가

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0
```

### 배럴 파일 템플릿

```dart
/// [Package Name] - [간단한 설명]
library;

// Domain
export 'src/domain/entities/entities.dart';
export 'src/domain/usecases/usecases.dart';

// Data
export 'src/data/repositories/repositories.dart';

// Presentation
export 'src/presentation/screens/screens.dart';
export 'src/presentation/widgets/widgets.dart';
```

## Creating New App

### 앱 생성 절차

1. `apps/[app_name]/` 디렉토리에 Flutter 프로젝트 생성
2. 필요한 패키지를 `pubspec.yaml`에 의존성으로 추가
3. `melos bootstrap` 실행

### 앱 pubspec.yaml 예시

```yaml
name: [app_name]
description: [앱 설명]
version: 1.0.0
publish_to: none

environment:
  sdk: ^3.10.0

dependencies:
  flutter:
    sdk: flutter

  # Core packages - 순수 Dart (필요 시)
  domain:
    path: ../../packages/core/domain
  network:
    path: ../../packages/core/network

  # App Core packages - Flutter 의존 (필수)
  theme:
    path: ../../packages/app_core/theme
  ui_kit:
    path: ../../packages/app_core/ui_kit

  # Feature packages (선택)
  auth:
    path: ../../packages/features/auth

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0

flutter:
  uses-material-design: true
```

## Bash Commands

### Melos 명령어

**참고**: Melos 7.0+ 이상부터는 Dart의 pub workspace 기능을 기반으로 동작합니다.
별도의 `melos.yaml` 파일 없이 루트 `pubspec.yaml`에서 workspace와 Melos 설정을 통합 관리합니다.

```bash
# 의존성 설치 및 링크
melos bootstrap

# 모든 패키지 분석
melos run analyze

# 모든 패키지 테스트
melos run test

# 모든 패키지 포맷
melos run format

# 특정 패키지만 실행
melos exec --scope="package_name" -- flutter test
```

### Flutter 명령어

```bash
# 앱 실행 (특정 앱 디렉토리에서)
flutter run

# 웹 빌드
flutter build web --release

# 분석
flutter analyze

# 테스트
flutter test

# 의존성 업데이트
flutter pub get
```

## Code Style

### Dart 코드 스타일

- 모든 linter 규칙 적용 (`all_linter_rules.yaml` 참조)
- Strict mode 활성화 (`strict-casts`, `strict-inference`, `strict-raw-types`)
- 타입 명시적 선언 권장

### 비활성화된 규칙

```yaml
always_put_required_named_parameters_first: false
avoid_annotating_with_dynamic: false
avoid_classes_with_only_static_members: false
cascade_invocations: false
comment_references: false
library_private_types_in_public_api: false
omit_obvious_property_types: false  # 타입 명시적 선언
one_member_abstracts: false
prefer_double_quotes: false
prefer_expression_function_bodies: false
prefer_final_parameters: false
unnecessary_final: false
```

### 네이밍 컨벤션

| 항목 | 규칙 | 예시 |
| :------: | :------: | :------: |
| 파일명 | snake_case | `user_repository.dart` |
| 클래스 | PascalCase | `UserRepository` |
| 변수/함수 | camelCase | `getUserById` |
| 상수 | camelCase 또는 SCREAMING_SNAKE_CASE | `defaultTimeout`, `MAX_RETRY_COUNT` |
| Private | underscore prefix | `_privateMethod` |

### Import 순서

```dart
// 1. Dart SDK
import 'dart:async';
import 'dart:convert';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. 외부 패키지
import 'package:provider/provider.dart';

// 4. 프로젝트 내부 패키지
import 'package:core/core.dart';
import 'package:auth/auth.dart';

// 5. 상대 경로
import '../widgets/custom_button.dart';
import 'user_model.dart';
```

## Testing

### 테스트 파일 위치

- 단위 테스트: `packages/[package]/test/`
- 위젯 테스트: `packages/[package]/test/`
- 통합 테스트: `apps/[app]/integration_test/`

### 테스트 파일 네이밍

```text
[테스트_대상]_test.dart
```

예시:

- `user_repository_test.dart`
- `login_screen_test.dart`

### 테스트 구조

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClassName', () {
    late ClassName instance;

    setUp(() {
      instance = ClassName();
    });

    tearDown(() {
      // 정리 코드
    });

    test('should do something', () {
      // Arrange
      final input = 'test';

      // Act
      final result = instance.doSomething(input);

      // Assert
      expect(result, equals(expected));
    });
  });
}
```

## MVP Generation Guidelines

### MVP 생성 시 준수사항

1. **범위 제한**
   - 핵심 기능 3개 이하
   - 단일 화면 또는 최대 3개 화면
   - 로컬 상태만 사용 (SharedPreferences)

2. **패키지 사용**
   - `core/` 패키지는 항상 포함
   - `features/` 패키지는 필요한 것만 선택
   - 불필요한 의존성 최소화

3. **코드 품질**
   - `flutter analyze` 통과 필수
   - Material3 디자인 적용
   - 반응형 레이아웃 (모바일/데스크톱)

4. **산출물**
   - `PLAN.md`: 구현 계획
   - `SPEC.md`: 기획서 원본 (있는 경우)
   - Flutter 앱 코드

### MVP 앱 구조 예시

```text
apps/[mvp_name]/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   └── features/
│       └── home/
│           ├── home_screen.dart
│           └── widgets/
├── web/
│   └── index.html
├── pubspec.yaml
├── PLAN.md
└── SPEC.md (선택)
```

## Workflow

### 개발 워크플로우

1. 기능 브랜치 생성: `feat/[feature-name]`
2. 패키지 또는 앱 개발
3. `melos bootstrap` 실행
4. `flutter analyze` 통과 확인
5. 테스트 작성 및 실행
6. PR 생성

### 주의사항

- 코드 변경 후 항상 `flutter analyze` 실행
- 테스트는 개별 실행 권장 (전체 실행 시 느림)
- 테스트 통과를 위해 억지로 테스트 코드를 수정하지 않음
- 패키지 간 순환 의존성 금지

## Troubleshooting

### 일반적인 문제

#### Melos bootstrap 실패

```bash
# 캐시 정리 후 재시도
melos clean
melos bootstrap
```

#### 패키지를 찾을 수 없음

```bash
# pubspec.yaml의 path 경로 확인
# pubspec.yaml의 workspace 및 melos:command:bootstrap 설정 확인
melos bootstrap
```

#### 분석 오류

```bash
# 생성 파일 재생성
flutter pub run build_runner build --delete-conflicting-outputs
```

## Package Classification Guide

### 패키지 분류 의사결정 플로우

새 패키지를 `packages/core/` 또는 `packages/app_core/`에 배치할지 결정하는 가이드입니다.

```text
새 패키지 생성 필요
        │
        ▼
[Q1] Widget, MaterialApp, BuildContext 등을 사용하는가?
        │
    ┌───┴───┐
   YES      NO
    │        │
    │        ▼
    │   [Q2] 화면 렌더링과 관련이 있는가? (색상, 폰트, 스타일 등)
    │        │
    │    ┌───┴───┐
    │   YES      NO
    │    │        │
    │    │        ▼
    │    │   [Q3] Flutter SDK의 dart:ui, dart:io 를 사용하는가?
    │    │        │
    │    │    ┌───┴───┐
    │    │   YES      NO
    │    │    │        │
    │    │    │        ▼
    │    │    │   [Q4] Dart VM에서도 실행되어야 하는가?
    │    │    │        (Slack Bot, CLI, 백엔드에서 재사용)
    │    │    │        │
    │    │    │    ┌───┴───┐
    │    │    │   YES      NO
    │    │    │    │        │
    │    ▼    ▼    │        ▼
    │  app_core    │      app_core
    │              ▼
    └────────────> core
```

### 의사결정 체크리스트

새 패키지 생성 전 다음을 확인하세요:

- [ ] **Q1**: `import 'package:flutter/...'` 필요한가?
  - YES → `packages/app_core/`
  - NO → 계속
- [ ] **Q2**: Widget, Color, TextStyle 등 UI 타입 사용?
  - YES → `packages/app_core/`
  - NO → 계속
- [ ] **Q3**: `dart:ui` 또는 Flutter 전용 `dart:io` 사용?
  - YES → `packages/app_core/`
  - NO → 계속
- [ ] **Q4**: Slack Bot, CLI, 백엔드에서 재사용 가능?
  - YES → `packages/core/`
  - NO → `packages/app_core/`

### 패키지 분류 예시

#### packages/core/ (순수 Dart)

| 패키지명 | 설명 | 이유 |
| :------: | :------: | :------: |
| `domain` | Entity, Value Object, Failure, Exception | 모든 플랫폼에서 공유 |
| `network` | HTTP 클라이언트, API 엔드포인트 | dio/http는 순수 Dart |
| `utils` | 문자열, 날짜, 숫자 유틸리티 | UI 무관 |
| `validation` | 이메일, 전화번호 등 검증 로직 | 비즈니스 규칙 |

**코드 예시**:

```dart
// packages/core/domain/lib/src/entities/user.dart
class User {
  final String id;
  final String email;

  User({required this.id, required this.email});
}

// packages/core/network/lib/src/api_client.dart
class ApiClient {
  final Dio _dio;

  Future<Response> get(String path) => _dio.get(path);
}
```

#### packages/app_core/ (Flutter 의존)

| 패키지명 | 설명 | 이유 |
| :------: | :------: | :------: |
| `theme` | Material Theme, 색상, 타이포그래피 | ThemeData, Color 사용 |
| `ui_kit` | 공통 위젯 (버튼, 카드, 다이얼로그) | Widget 클래스 |
| `navigation` | 라우팅, Navigator 래퍼 | Navigator, Route 사용 |
| `storage` | SharedPreferences, Hive 래퍼 | Flutter 플러그인 |

**코드 예시**:

```dart
// packages/app_core/theme/lib/src/app_theme.dart
class AppTheme {
  static ThemeData light() => ThemeData(
    primaryColor: AppColors.primary,
    textTheme: AppTextStyles.textTheme,
  );
}

// packages/app_core/ui_kit/lib/src/widgets/custom_button.dart
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
```

### 애매한 케이스 처리

#### Storage (로컬 저장소)

**문제**: SharedPreferences는 Flutter 플러그인이지만, 인터페이스는 순수 Dart로 정의 가능

**해결책**: 인터페이스-구현 분리

```dart
// packages/core/storage/lib/src/storage_interface.dart
abstract class IStorage {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
}

// packages/app_core/storage/lib/src/shared_prefs_storage.dart
class SharedPrefsStorage implements IStorage {
  final SharedPreferences _prefs;

  @override
  Future<void> saveString(String key, String value) {
    return _prefs.setString(key, value);
  }
}
```

**결론**:

- `packages/core/storage/` → 인터페이스만
- `packages/app_core/storage/` → SharedPreferences 구현
- `packages/features/[feature]/` → 실제 사용

#### Utils (유틸리티 함수)

**해결책**: 분리하여 두 곳에 배치

```text
packages/core/utils/        → 순수 Dart (string_utils, date_utils)
packages/app_core/utils/    → Flutter 필요 (widget_utils, responsive_utils)
```

### 경계 케이스 규칙

1. **의심스러우면 core 우선**: 나중에 app_core로 이동하는 것이 반대보다 쉬움
2. **50% 룰**: 코드의 50% 이상이 Flutter 관련이면 app_core
3. **단일 책임**: 하나의 패키지는 하나의 카테고리에만 속함 (혼재 금지)
4. **인터페이스 분리**: 애매하면 인터페이스(core) + 구현(app_core) 분리

### 실제 사용 예시

#### 예시 1: 인증 기능

```text
사용자 인증 기능을 추가하려고 함

분석:
- Entity (User, AuthToken): Slack Bot과 공유 필요 → packages/core/domain/
- API 호출 (LoginUseCase): HTTP만 사용 → packages/core/domain/
- 로그인 화면 (LoginScreen): Widget 사용 → packages/features/auth/
- 생체인증 (BiometricAuth): local_auth 플러그인 → packages/app_core/security/
```

#### 예시 2: 로깅 시스템

```text
로깅 시스템을 추가하려고 함

분석:
- 로그 인터페이스: → packages/core/logging/
- 콘솔 출력 구현: → packages/core/logging/ (순수 Dart)
- Firebase Crashlytics 구현: → packages/integrations/firebase/
- 앱 내 로그 뷰어 UI: → packages/app_core/debug_ui/ (미래에 추가 가능)
```
