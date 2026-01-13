# Flutter Web MVP - 포모도로 타이머

## 프로젝트 정보
- **프로젝트명**: mvp__1768288011746
- **타입**: Flutter Web Application
- **목표**: 1시간 내 구현 가능한 최소 기능
- **개발 시간**: ~60분

## 아이디어 개요
**포모도로 타이머 (Pomodoro Timer)**
- 25분 작업 → 5분 휴식 사이클을 관리하는 심플한 타이머
- 생산성 향상을 위한 시간 관리 도구
- 외부 API 없이 로컬 상태로만 동작

## 핵심 기능 (3개)

### 1. 타이머 제어
- 25분 작업 타이머 시작/일시정지/재설정
- 실시간 카운트다운 표시 (MM:SS 형식)
- 상태: 작업 중 / 휴식 중 / 정지

### 2. 자동 전환
- 작업 타이머 완료 시 자동으로 5분 휴식 타이머 시작
- 휴식 완료 시 사운드 알림 (브라우저 기본 알림)
- 시각적 피드백 (작업/휴식 상태 색상 변경)

### 3. 세션 카운터
- 완료한 포모도로 세션 개수 표시
- 오늘 달성한 세션 수 추적
- 리셋 버튼으로 카운터 초기화

## 화면 구성 (단일 화면)

```
┌─────────────────────────────────┐
│     Pomodoro Timer 🍅          │
│                                 │
│        ┌─────────────┐         │
│        │   25:00     │         │
│        │  (Timer)    │         │
│        └─────────────┘         │
│                                 │
│    [Start] [Pause] [Reset]    │
│                                 │
│    Status: Work / Break        │
│    Sessions Today: 3 🔥        │
│                                 │
│    [Reset Sessions]            │
└─────────────────────────────────┘
```

## 기술 스택

### Flutter 패키지
- **flutter**: 기본 SDK
- **material design**: UI 컴포넌트

### 외부 의존성
- ❌ 없음 (완전히 독립적)

### 상태 관리
- **로컬 상태**: `StatefulWidget` 사용
- **데이터 저장**: 메모리 내 변수로만 관리 (영구 저장 없음)

## 파일 구조

```
mvp__1768288011746/
├── lib/
│   ├── main.dart              # 앱 진입점
│   ├── screens/
│   │   └── timer_screen.dart  # 타이머 메인 화면
│   ├── widgets/
│   │   ├── timer_display.dart # 타이머 디스플레이 위젯
│   │   ├── control_buttons.dart # 제어 버튼들
│   │   └── session_counter.dart # 세션 카운터
│   └── models/
│       └── timer_state.dart   # 타이머 상태 모델
├── web/
│   ├── index.html
│   └── manifest.json
├── pubspec.yaml
├── analysis_options.yaml
└── PLAN.md
```

## 구현 단계 (60분 예상)

### Phase 1: 프로젝트 설정 (10분)
1. Flutter 프로젝트 생성
2. pubspec.yaml 설정
3. 기본 파일 구조 생성

### Phase 2: 타이머 로직 구현 (20분)
4. TimerState 모델 작성
5. 카운트다운 로직 구현 (Timer 클래스 사용)
6. 작업/휴식 전환 로직

### Phase 3: UI 구현 (20분)
7. TimerDisplay 위젯 (원형 또는 카드 형태)
8. ControlButtons 위젯 (Start/Pause/Reset)
9. SessionCounter 위젯

### Phase 4: 통합 및 테스트 (10분)
10. 화면 통합 및 레이아웃 조정
11. 색상 및 스타일링 (작업=파랑, 휴식=초록)
12. 브라우저 테스트

## 구현 세부사항

### 타이머 설정값
```dart
const int WORK_DURATION = 25 * 60; // 25분 = 1500초
const int BREAK_DURATION = 5 * 60; // 5분 = 300초
```

### 색상 테마
- **작업 모드**: Blue (Primary), 집중력
- **휴식 모드**: Green (Success), 휴식
- **정지 상태**: Grey (Neutral)

### 알림
- 타이머 완료 시: 브라우저 기본 알림음 (AudioElement)
- 시각적 효과: 깜빡임 효과 또는 애니메이션

## 제약사항 준수

✅ **외부 API 의존성 최소화**: 완전히 독립적, 외부 API 사용 안 함
✅ **단일 화면**: 1개의 메인 화면만 사용
✅ **로컬 상태만 사용**: StatefulWidget으로 상태 관리
✅ **핵심 기능 3개 이하**: 타이머 제어, 자동 전환, 세션 카운터
✅ **1시간 내 구현**: 단순한 구조로 빠른 구현 가능

## 추가 개선 가능 항목 (v2.0)
- Local Storage를 이용한 세션 데이터 영구 저장
- 커스텀 타이머 시간 설정
- 통계 화면 (주간/월간 세션 수)
- 다크 모드 지원
- PWA 기능 (오프라인 지원)

## 실행 방법

```bash
# 프로젝트 디렉토리로 이동
cd apps/mvp__1768288011746

# 의존성 설치
flutter pub get

# 웹 개발 서버 실행
flutter run -d chrome

# 빌드 (배포용)
flutter build web
```

## 성공 기준
- ✅ 타이머가 정확하게 25분/5분 카운트다운
- ✅ Start/Pause/Reset 버튼이 정상 작동
- ✅ 작업 완료 후 자동으로 휴식 타이머 시작
- ✅ 세션 카운터가 정확하게 증가
- ✅ 반응형 UI (모바일/데스크톱 대응)
- ✅ 브라우저에서 정상 실행

---

**예상 완료 시간**: 60분
**난이도**: 초급~중급
**학습 포인트**: Flutter 기본, Timer 클래스, StatefulWidget, Material Design
