# CLAUDE.md - Tiny Tree App Template

## Answering Request

- Please answer in korean.

## Project Overview

Melos 기반 Flutter 모노레포로 재사용 가능한 패키지를 관리합니다.  
Claude Code가 이 패키지들을 조합하여 light/full 모드의 MVP를 생성합니다.

**현재 Phase**: 2 (핵심 패키지 개발)

## Project Structure

```text
packages/
├── core/                    # 순수 Dart (Flutter 의존성 없음)
│   ├── domain/              # ✅ Result, Failure, Entity
│   ├── network/             # 📅 HTTP Client
│   ├── storage_interface/   # 📅 Storage Contract
│   └── utils/               # 📅 순수 Dart Utils
│
├── app_core/                # Flutter 의존
│   ├── auth/                # 📅 우선순위 1
│   ├── theme/               # 📅 우선순위 2
│   ├── ui_kit/              # 📅 우선순위 3
│   ├── storage_impl/        # 📅 구현체
│   └── utils/               # 📅 Flutter Utils
│
├── features/                # Phase 3+
├── integrations/            # Phase 3+
└── testing/                 # Phase 3+
```

## Key Decisions

### 1. 패키지 개발 우선순위

**강민님 결정사항**:

1. core (domain → network → storage_interface → utils)
2. app_core/auth
3. app_core/theme
4. app_core/ui_kit

**근거**: MVP 생성에 필수적인 순서

### 2. core vs app_core 분리

**core**: Flutter 의존성 없음, Dart VM에서 실행 가능  
**app_core**: Flutter 필요, Widget/Material 사용

**판단 기준**:

- Widget, BuildContext 사용? → app_core
- 화면 렌더링 관련? → app_core
- Slack Bot/CLI 재사용? → core

### 3. light vs full 모드 전략

| 측면 | light | full |
| :------: | :-------: | :------: |
| 패키지 | 사용 안함 | app_core 활용 |
| 구조 | lib/ 직접 작성 | packages/ 모듈화 |
| 외부 | http, shared_preferences | 제한 없음 |
| 상태 | setState | Provider 등 |

### 4. 패키지 아키텍처 원칙

1. **의존성 명확성**: core는 Flutter 의존 없음
2. **기능별 분리**: 레이어별이 아닌 기능별 패키지
3. **선택적 의존성**: 필요한 것만 import
4. **독립적 확장**: 패키지 내부만 수정
5. **명확한 Public API**: 배럴 파일 제공

## Package Creation

### core 패키지 (순수 Dart)

```bash
cd packages/core
dart create [package_name]
```

**pubspec.yaml**:

```yaml
resolution: workspace
environment:
  sdk: ^3.10.0
dependencies:
  # 순수 Dart만
```

### app_core 패키지 (Flutter)

```bash
cd packages/app_core
flutter create --template=package [package_name]
```

**pubspec.yaml**:

```yaml
resolution: workspace
environment:
  sdk: ^3.10.0
  flutter: ">=3.38.0"
dependencies:
  flutter:
    sdk: flutter
```

### 필수 파일

- `analysis_options.yaml`: `include: ../../../analysis_options.yaml`
- 배럴 파일: `lib/[package_name].dart`
- README.md: 사용 예시 포함

## Bash Commands

```bash
# 의존성 설치
melos bootstrap

# 분석
melos run analyze

# 테스트
melos run test

# 포맷
melos run format

# 특정 패키지
melos exec --scope="package_name" -- flutter test
```

## Code Style

- 모든 linter 규칙 적용
- Strict mode 활성화
- 타입 명시적 선언
- Import 순서: Dart SDK → Flutter SDK → 외부 → 내부

## Testing

- 단위 테스트: `test/` 디렉토리
- 커버리지: 80% 이상 목표
- Mock 사용 권장

## Workflow

### 패키지 개발 흐름

1. 브랜치 생성: `feat/package-[category]-[name]`
2. 패키지 생성
3. pubspec.yaml, analysis_options.yaml 작성
4. 구현
5. 테스트 작성
6. `flutter analyze` 또는 `dart analyze` 통과
7. 루트 pubspec.yaml에 workspace 추가
8. `melos bootstrap` 실행
9. PR 생성

### 체크리스트

- [ ] analyze 통과
- [ ] 테스트 작성
- [ ] README.md 작성
- [ ] 배럴 파일 작성
- [ ] workspace 등록

## Important Notes

### Phase 2 작업 시 주의사항

1. **패키지 분류**
   - core/app_core 구분 명확히
   - 순환 의존성 절대 금지
   - 인터페이스-구현 분리 (storage 등)

2. **Result 패턴 일관성**
   - 모든 비동기 메서드는 `Result<Failure, T>` 반환
   - Failure는 domain 패키지에서 정의

3. **테스트**
   - 핵심 로직은 반드시 테스트
   - Mock 객체 활용
   - 80% 커버리지 목표

4. **문서화**
   - 각 패키지 README.md 필수
   - 사용 예시 포함
   - Public API 명확히

## Related Documents

- [프로젝트 계획](./plans/project-plan.md)
- [Packages 구현 계획](./plans/packages-implementation-plan.md)
- [README.md](./README.md)

## 관련 프로젝트

- [Tiny Tree Slack Bot](https://github.com/Just-gomin/tiny_tree-slack_bot)
