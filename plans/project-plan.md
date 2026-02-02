# Tiny Tree App Template - 프로젝트 계획

## 프로젝트 개요

Tiny Tree 시스템에서 실제 Flutter 앱을 생성하는 템플릿 프로젝트입니다.  
재사용 가능한 패키지들을 모노레포로 관리하며, Claude Code가 이 패키지들을 조합하여 MVP를 생성합니다.

**핵심 역할**:

- 재사용 가능한 Flutter 패키지 제공
- Melos 기반 모노레포 관리
- light/full 모드에 따른 패키지 조합
- MVP 빠른 생성과 대규모 프로젝트 확장 모두 지원

## 현재 상태 (Phase 1 완료)

### ✅ 구현 완료

- Melos 기반 모노레포 구조
- `packages/core/domain` 패키지 완성
  - Result, Failure, Entity, UseCase, ValueObject

### 📦 기술 스택

| 구분 | 기술 | 버전 |
| :------: | :------: | :------: |
| Language | Dart | 3.10+ |
| Framework | Flutter | 3.38+ |
| Package Manager | Melos | 7.0+ |
| Backend | Firebase / Supabase | 최신 |

## Phase 2: 핵심 패키지 개발 (진행중)

### 목표

light/full 모드에서 사용할 필수 패키지 구축

### 패키지 개발 우선순위

강민님의 결정에 따라 다음 순서로 개발:

1. **`packages/core/`** - 순수 Dart 패키지
   - ✅ `domain` (완료)
   - 📅 `network`
   - 📅 `storage_interface`
   - 📅 `utils`

2. **`packages/app_core/auth`** - 인증 기능
   - 📅 Firebase Auth 통합
   - 📅 소셜 로그인 (Google, Apple)
   - 📅 세션 관리

3. **`packages/app_core/theme`** - Material3 테마
   - 📅 Color schemes (light/dark)
   - 📅 Typography system
   - 📅 ThemeData builder

4. **`packages/app_core/ui_kit`** - 공통 위젯
   - 📅 Buttons (Primary, Secondary)
   - 📅 Cards
   - 📅 Inputs
   - 📅 Loading indicators

### light vs full 모드 전략

| 측면 | light 모드 | full 모드 |
| :------: | :-----------: | :----------: |
| 패키지 사용 | ❌ 없음 | ✅ app_core 패키지 활용 |
| 구조 | 단일 앱, lib/ 직접 작성 | packages/ 기반 모듈화 |
| 외부 패키지 | http, shared_preferences만 | 필요한 모든 패키지 |
| 상태 관리 | setState만 | Provider, Riverpod 등 |
| 화면 수 | 최대 3개 | 제한 없음 |
| 데이터 | 로컬 mock | API 연동, 로컬 DB |

### 패키지 구조 설계

```text
packages/
├── core/                    # 순수 Dart (Flutter 의존성 없음)
│   ├── domain/              ✅ 완료
│   ├── network/             📅 계획
│   ├── storage_interface/   📅 계획
│   └── utils/               📅 계획
│
├── app_core/                # Flutter 의존
│   ├── auth/                📅 계획 (우선순위 1)
│   ├── theme/               📅 계획 (우선순위 2)
│   ├── ui_kit/              📅 계획 (우선순위 3)
│   ├── storage_impl/        📅 계획
│   └── utils/               📅 계획
│
├── features/                # 비즈니스 기능 (Phase 3+)
│   ├── payment/
│   ├── analytics/
│   ├── notification/
│   ├── onboarding/
│   ├── settings/
│   └── feedback/
│
├── integrations/            # 서드파티 래퍼 (Phase 3+)
│   ├── firebase/
│   ├── supabase/
│   └── revenue_cat/
│
└── testing/                 # 테스트 유틸리티 (Phase 3+)
    ├── mocks/
    └── fixtures/
```

## 구현 계획

자세한 구현 계획은 별도 문서 참조:

- [packages-implementation-plan.md](./packages-implementation-plan.md)

### Phase 0: Failure 타입 사전 정의 (완료 예정)

- StorageFailure 추가

### Phase 1: core/network (예정)

- ApiClient (Dio 래핑)
- Result 패턴 통합
- 예상 시간: 2시간

### Phase 2: core/storage_interface + utils (예정)

- IStorage, ISecureStorage 인터페이스
- 순수 Dart 유틸리티
- 예상 시간: 2시간

### Phase 3: app_core/theme (예정)

- Material3 테마
- Light/Dark 모드
- 예상 시간: 2시간

### Phase 4: app_core/ui_kit (예정)

- 공통 위젯 라이브러리
- 예상 시간: 2시간

### Phase 5: app_core/storage_impl + utils (예정)

- SharedPreferences, SecureStorage 구현
- Flutter 유틸리티
- 예상 시간: 2시간

### Phase 6: testing (예정)

- Mock 객체
- Fixture 데이터
- 예상 시간: 1.5시간

### Phase 7: Workspace 통합 (예정)

- Melos 스크립트 완성
- 전체 검증
- 예상 시간: 1시간

### Phase 8: 샘플 앱 (예정)

- apps/example 생성
- 패키지 사용 예시
- 예상 시간: 2시간

**총 예상 시간**: 15시간

## Phase 3: 고급 기능 패키지 (미정)

### 계획

- `features/` 패키지 개발
- `integrations/` 패키지 개발
- full 모드 고도화

## 아키텍처 원칙

### 1. 의존성 명확성

- `core/`: Flutter 의존성 없음 (순수 Dart)
- `app_core/`: Flutter 의존성 있음
- 크로스 플랫폼 재사용 고려

### 2. 기능별 분리

- 레이어별이 아닌 기능별로 패키지 분리
- 각 기능 패키지 내부에서만 레이어 유지

### 3. 선택적 의존성

- 필요한 패키지만 import
- 불필요한 의존성 최소화

### 4. 독립적 확장

- 각 패키지는 독립적으로 고도화 가능
- 패키지 간 순환 의존성 금지

### 5. 명확한 Public API

- 배럴 파일을 통한 인터페이스 제공
- 내부 구현은 src/ 하위에 은닉

## 개발 환경

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

### 패키지 생성

**core 패키지 (순수 Dart)**:

```bash
cd packages/core
dart create [package_name]
```

**app_core 패키지 (Flutter)**:

```bash
cd packages/app_core
flutter create --template=package [package_name]
```

## 품질 기준

### 모든 패키지 필수

- [ ] `flutter analyze` 또는 `dart analyze` 통과
- [ ] 테스트 커버리지 80% 이상
- [ ] README.md 작성 (사용 예시 포함)
- [ ] 배럴 파일 작성
- [ ] `analysis_options.yaml` 포함

### 코드 스타일

- 모든 linter 규칙 적용
- Strict mode 활성화
- 타입 명시적 선언 권장

## 문서 링크

- [Packages 구현 계획](./packages-implementation-plan.md)
- [README.md](../README.md)
- [CLAUDE.md](../CLAUDE.md)

## 관련 프로젝트

- [Tiny Tree Slack Bot](https://github.com/Just-gomin/tiny_tree-slack_bot)

## 변경 이력

| 날짜 | 버전 | 변경 내용 |
| :------: | :------: | :---------- |
| 2025-02-02 | 1.0 | 프로젝트 계획서 작성, 패키지 개발 우선순위 반영 |
