# Tiny Tree App Template

AI 기반 소프트웨어 개발 자동화 시스템 **Tiny Tree**의 Flutter 앱 템플릿 프로젝트입니다.

## 비전

**AI를 활용하여 아이디어부터 프로덕션까지, 소프트웨어 개발의 전 과정을 자동화한다.**

- **초기 목표**: 1시간 내 MVP 생성 및 배포
- **중장기 목표**: 대규모 프로젝트의 지속 가능한 개발 지원

## 기술 스택

| 구분 | 기술 | 용도 |
| :------: | :------: | :------: |
| Language | Dart | 코어 패키지 제작 |
| Framework | Flutter | 앱 및 UI 패키지 제작 |
| Package Manager | Melos | 모노레포 관리 |
| Backend | Firebase / Supabase | 서버리스 운영 |

## 프로젝트 구조

```text
tiny_tree-app_template/
├── apps/                    # 생성된 앱들
│   └── [generated_app]/
├── packages/                # 재사용 가능한 패키지
│   ├── core/                # 필수 기반
│   ├── features/            # 비즈니스 기능
│   ├── integrations/        # 서드파티 연동
│   └── testing/             # 테스트 유틸리티
└── melos.yaml
```

### `apps/`

`packages/`에 정의된 패키지를 조합하여 생성되는 앱들이 위치합니다. Claude Code가 사용자 요구사항에 맞게 앱을 생성합니다.

### `packages/`

재사용 가능한 기능 패키지들이 위치합니다. 기능별로 분리되어 있어 필요한 패키지만 선택적으로 사용할 수 있습니다.

## 패키지 구조

### 설계 원칙

| 원칙 | 설명 |
| :------: | :------: |
| **기능별 분리** | 레이어별이 아닌 기능별로 패키지 분리 |
| **선택적 의존성** | 필요한 기능만 import하여 사용 |
| **독립적 확장** | 각 패키지 내부만 수정하여 기능 고도화 |
| **명확한 Public API** | 배럴 파일을 통한 인터페이스 제공 |

### 패키지 분류

```text
packages/
├── core/                    # 필수 기반 (모든 앱 공통)
│   ├── theme/               # 테마, 색상, 타이포그래피
│   ├── ui_kit/              # 공용 위젯
│   ├── utils/               # 유틸리티 함수
│   ├── storage/             # 로컬 저장소 추상화
│   └── network/             # HTTP 클라이언트, 에러 핸들링
│
├── features/                # 비즈니스 기능 (선택적)
│   ├── auth/                # 인증
│   ├── payment/             # 결제
│   ├── analytics/           # 분석
│   ├── notification/        # 알림
│   ├── onboarding/          # 온보딩
│   ├── settings/            # 설정
│   └── feedback/            # 사용자 피드백
│
├── integrations/            # 서드파티 래퍼 (교체 가능)
│   ├── firebase/
│   ├── supabase/
│   └── revenue_cat/
│
└── testing/                 # 테스트 유틸리티
    ├── mocks/
    └── fixtures/
```

### 기능 패키지 내부 구조

각 기능 패키지 내부에서는 레이어를 유지하되 단순화합니다:

```text
packages/features/auth/
├── lib/
│   ├── auth.dart            # 배럴 파일 (public API)
│   └── src/
│       ├── domain/          # 엔티티, 유스케이스
│       ├── data/            # 레포지토리 구현
│       └── presentation/    # 위젯, 화면
└── pubspec.yaml
```

## MVP 제작 과정

```text
1. 아이디어 입력
   └─▶ Slack: /mvp 또는 기획서 업로드

2. 계획 설계
   └─▶ Claude: 1시간 내 구현 가능한 범위로 축소
   └─▶ 산출물: PLAN.md, SPEC.md

3. 기능 개발
   └─▶ Claude: 패키지 조합 + 커스텀 코드 생성
   └─▶ 산출물: Flutter 앱

4. 배포
   └─▶ Firebase Hosting (웹)
   └─▶ Firebase App Distribution (모바일)

5. 피드백 및 수정
   └─▶ Slack 스레드로 수정 요청
   └─▶ 2단계로 돌아가 반복
```

## 로드맵

### Phase 1: MVP 자동화 (현재)

- 1시간 내 MVP 생성 및 배포
- 단순한 단일/소수 화면 앱
- 로컬 상태 관리, 기본 UI

### Phase 2: 피드백 기반 반복 개선

- Slack 스레드 기반 피드백 수집
- 증분 업데이트 (변경 부분만 수정)
- 버전 히스토리 관리

### Phase 3: 상업용 앱 수준 기능 지원

- 인증 시스템 (소셜 로그인, 권한 체계)
- 결제 연동 (인앱결제, 구독 관리)
- 분석 및 모니터링 통합

### Phase 4: 대규모 프로젝트 지속 개발

- Task 기반 개발 (할 일 DB 관리)
- 모듈 단위 독립 개발/배포
- 자동 테스트, CI/CD

## 관련 프로젝트

| 프로젝트 | 설명 |
| :---------: | ":------: |
| [tiny_tree-slack_bot](https://github.com/Just-gomin/tiny_tree-slack_bot) | Slack Bot - 사용자 인터페이스, 파이프라인 오케스트레이션 |

## 라이선스

MIT License
