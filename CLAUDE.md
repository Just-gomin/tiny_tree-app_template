# CLAUDE.md

## Answering Request

- Please answer in korean.

## Project Overview

Tiny Tree App Template은 AI 기반 소프트웨어 개발 자동화 시스템의 Flutter 앱 템플릿 프로젝트입니다.

- **초기 목표**: 1시간 내 MVP 생성 및 배포
- **중장기 목표**: 대규모 프로젝트의 지속 가능한 개발 지원

### 기술 스택

- Dart 3.9+
- Flutter (Web, Mobile)
- Melos 7.3+ (모노레포 관리)
- Firebase / Supabase (서버리스 백엔드)

### 관련 프로젝트

- [tiny_tree-slack_bot](https://github.com/Just-gomin/tiny_tree-slack_bot): Slack Bot - 사용자 인터페이스, 파이프라인 오케스트레이션

## Project Structure

```text
tiny_tree-app_template/
├── apps/                    # 생성된 앱들
│   └── [app_name]/          # 개별 앱 프로젝트
├── packages/                # 재사용 가능한 패키지
│   ├── core/                # 필수 기반 (모든 앱 공통)
│   │   ├── theme/           # 테마, 색상, 타이포그래피
│   │   ├── ui_kit/          # 공용 위젯
│   │   ├── utils/           # 유틸리티 함수
│   │   ├── storage/         # 로컬 저장소 추상화
│   │   └── network/         # HTTP 클라이언트, 에러 핸들링
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
├── melos.yaml               # Melos 설정
├── pubspec.yaml             # 루트 pubspec
└── analysis_options.yaml    # Dart 분석 옵션
```

## Package Architecture

### 설계 원칙

| 원칙 | 설명 |
| :------: | :------: |
| **기능별 분리** | 레이어별이 아닌 기능별로 패키지 분리 |
| **선택적 의존성** | 필요한 기능만 import하여 사용 |
| **독립적 확장** | 각 패키지 내부만 수정하여 기능 고도화 |
| **명확한 Public API** | 배럴 파일을 통한 인터페이스 제공 |

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

| 분류 | 용도 | 필수 여부 |
| :------: | :------: | :----------: |
| `core/` | 모든 앱에서 사용하는 기반 | 필수 |
| `features/` | 앱별로 선택적 사용 | 선택 |
| `integrations/` | 특정 서드파티 필요 시 | 선택 |
| `testing/` | 테스트 유틸리티 | 개발 시 |

## Creating New Package

### 패키지 생성 절차

1. `packages/[category]/[package_name]/` 디렉토리 생성
2. `pubspec.yaml` 작성
3. `lib/[package_name].dart` 배럴 파일 생성
4. `lib/src/` 하위에 구현 코드 작성
5. `melos bootstrap` 실행

### pubspec.yaml 템플릿

```yaml
name: [package_name]
description: [패키지 설명]
version: 0.1.0
publish_to: none

environment:
  sdk: ^3.9.0
  flutter: ">=3.29.0"

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

### melos.yaml에 의존성 관리

```yaml
...

command:
  ...
  bootstrap:
    environment:
      sdk: ^3.9.0
    dependencies:
      # 패키지들에서 사용하는 의존성 추가
    dev_dependencies:
      # 패키지 개발에 필요한 의존성 추가
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
  sdk: ^3.9.0

dependencies:
  flutter:
    sdk: flutter
  
  # Core packages (필수)
  theme:
    path: ../../packages/core/theme
  ui_kit:
    path: ../../packages/core/ui_kit
  
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
# melos.yaml의 packages 설정 확인
melos bootstrap
```

#### 분석 오류

```bash
# 생성 파일 재생성
flutter pub run build_runner build --delete-conflicting-outputs
```
