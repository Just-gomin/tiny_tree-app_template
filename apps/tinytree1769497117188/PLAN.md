# AI Growth Coach - Flutter Web MVP 구현 계획

## 프로젝트 개요

**목표**: 1시간 내 구현 가능한 콘텐츠 성과 개선 코칭 AI 데모 앱
**타겟 플랫폼**: Flutter Web (Desktop 반응형 지원)
**구현 범위**: 콘텐츠 공급자가 데이터를 확인하고 AI 코치로부터 구체적인 개선 제안을 받는 핵심 플로우

---

## 핵심 기능 (3개)

### 1. 성과 대시보드
- **목적**: 콘텐츠 성과 지표를 한눈에 파악
- **구성**:
  - 핵심 지표 카드 (노출수, 클릭률, 예약률, 취소율)
  - 시각적 인디케이터 (Good/Warning/Critical 상태 표시)
  - 주간 트렌드 아이콘 (↑ 상승, → 유지, ↓ 하락)
  - 문제 있는 지표는 경고 색상 강조

### 2. AI 코칭 피드백
- **목적**: 성과 저하 원인 진단 및 개선 행동 제안
- **구성**:
  - 진단 섹션: 성과 문제의 핵심 원인 분석
  - 액션 아이템: 즉시 실행 가능한 개선 행동 리스트 (체크박스)
  - 우선순위 표시 (High/Medium/Low 배지)
  - 예상 효과 설명 (예: "클릭률 15% 개선 예상")

### 3. 비교 분석
- **목적**: 유사 콘텐츠와의 성과 비교
- **구성**:
  - 내 콘텐츠 vs 카테고리 평균 비교 차트
  - 강점/약점 요약
  - 벤치마크 데이터 (상위 10% 성과 지표 표시)

---

## 화면 구조 (3개 화면)

```
┌─────────────────────────────────────────┐
│  1. 성과 대시보드 (Dashboard)             │
│  - 핵심 지표 카드                        │
│  - "AI 코칭 받기" 버튼                   │
│  - 하단 네비게이션: 대시보드/비교/히스토리 │
└─────────────────────────────────────────┘
           │ "AI 코칭 받기" 클릭
           ▼
┌─────────────────────────────────────────┐
│  2. AI 코칭 (Coaching)                   │
│  - 문제 진단 요약                        │
│  - 액션 아이템 리스트 (체크 가능)         │
│  - "액션 플랜 저장" 버튼                 │
└─────────────────────────────────────────┘
           │ 네비게이션 전환
           ▼
┌─────────────────────────────────────────┐
│  3. 비교 분석 (Comparison)               │
│  - 성과 비교 차트                        │
│  - 카테고리 벤치마크                     │
└─────────────────────────────────────────┘
```

---

## 데이터 구조

### PerformanceMetrics (성과 지표)
```dart
class PerformanceMetrics {
  final int views;              // 노출수
  final double clickRate;       // 클릭률 (%)
  final double bookingRate;     // 예약률 (%)
  final double cancellationRate; // 취소율 (%)
  final PerformanceTrend trend; // 주간 트렌드
  final HealthStatus status;    // 전체 건강 상태
}

enum PerformanceTrend { up, stable, down }
enum HealthStatus { good, warning, critical }
```

### CoachingFeedback (코칭 피드백)
```dart
class CoachingFeedback {
  final String diagnosis;       // 문제 진단 요약
  final List<ActionItem> actions; // 개선 액션 리스트
  final String expectedImpact;  // 예상 효과
}

class ActionItem {
  final String title;
  final String description;
  final Priority priority;      // High, Medium, Low
  final ActionCategory category; // price, photos, schedule, description
  bool isCompleted;
}

enum Priority { high, medium, low }
enum ActionCategory { price, photos, schedule, description, operation }
```

### BenchmarkData (벤치마크 데이터)
```dart
class BenchmarkData {
  final String contentTitle;
  final double myClickRate;
  final double avgClickRate;
  final double top10ClickRate;
  final double myBookingRate;
  final double avgBookingRate;
  final double top10BookingRate;
}
```

### 목 데이터 (Mock Data)
- 1개의 샘플 콘텐츠 성과 데이터
- 클릭률 저조, 예약률 낮음 시나리오
- 5개의 개선 액션 아이템 (가격, 사진, 설명, 운영시간, 취소정책)
- 카테고리 평균 및 상위 10% 벤치마크 데이터

---

## 디자인 시스템

### 컬러 팔레트
```dart
// Primary Colors
primaryDark: Color(0xFF1A237E),      // 다크 블루 (CTA, 중요 텍스트)
primaryBlue: Color(0xFF1976D2),      // 블루 (링크, 액센트)
primaryRed: Color(0xFFE53935),       // 레드 (경고, 취소율)

// Status Colors
statusGood: Color(0xFF43A047),       // 그린 (좋은 성과)
statusWarning: Color(0xFFFB8C00),    // 오렌지 (주의)
statusCritical: Color(0xFFE53935),   // 레드 (위험)

// Support Colors
accentYellow: Color(0xFFFFF3E0),     // 옐로우 배경 (경고 박스)
accentOrange: Color(0xFFFF9800),     // 오렌지 (우선순위 High)

// Neutral
backgroundWhite: Color(0xFFFFFFFF),
backgroundGray: Color(0xFFF5F5F5),
textDark: Color(0xFF212121),
textGray: Color(0xFF757575),
borderGray: Color(0xFFE0E0E0),
```

### 타이포그래피
```dart
// Headline (화면 타이틀, 큰 숫자)
fontSize: 24, fontWeight: FontWeight.w700

// Title (카드 제목, 섹션 헤더)
fontSize: 18, fontWeight: FontWeight.w600

// Body (본문, 액션 아이템)
fontSize: 16, fontWeight: FontWeight.w400

// Caption (메타 정보, 보조 텍스트)
fontSize: 14, fontWeight: FontWeight.w400, color: textGray

// Metric (지표 숫자)
fontSize: 32, fontWeight: FontWeight.w700
```

### 컴포넌트 스타일
- **카드**: borderRadius 12, elevation 2, padding 16
- **버튼**: borderRadius 8, height 48, padding 16x24
- **배지**: borderRadius 16, padding 4x8, fontSize 12
- **체크박스**: size 24, borderRadius 4
- **간격**: 16px (기본), 24px (섹션 간), 8px (밀집 요소)

---

## 상태 관리

### 방식: StatefulWidget + Local State
- 서버 통신 없음
- SharedPreferences 불필요 (세션 유지 불필요)
- 목 데이터를 초기 상태로 사용

### 상태 흐름
```
[초기 상태]
- 성과 지표 표시 (클릭률 저조, 예약률 낮음)
- AI 코칭 버튼 활성화

[사용자 액션: AI 코칭 받기]
1. 성과 데이터 분석 (시뮬레이션)
2. 코칭 화면으로 이동
3. 진단 + 액션 아이템 표시

[사용자 액션: 액션 아이템 체크]
1. 체크박스 토글
2. 로컬 상태 업데이트
3. 완료된 항목 스타일 변경 (취소선, 회색)

[사용자 액션: 비교 분석 보기]
1. 비교 화면으로 이동
2. 내 성과 vs 평균/상위 10% 시각화
```

---

## 파일 구조

```
apps/tinytree1769497117188/
├── lib/
│   ├── main.dart                      # 앱 진입점
│   ├── app.dart                       # MaterialApp 설정
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_colors.dart        # 컬러 상수
│   │   │   ├── app_text_styles.dart   # 텍스트 스타일
│   │   │   └── app_theme.dart         # ThemeData
│   │   └── constants/
│   │       └── mock_data.dart         # 목 데이터
│   ├── models/
│   │   ├── performance_metrics.dart   # 성과 지표 모델
│   │   ├── coaching_feedback.dart     # 코칭 피드백 모델
│   │   └── benchmark_data.dart        # 벤치마크 데이터 모델
│   └── screens/
│       ├── dashboard/
│       │   ├── dashboard_screen.dart  # 대시보드 화면
│       │   └── widgets/
│       │       ├── metric_card.dart   # 지표 카드 위젯
│       │       └── trend_indicator.dart # 트렌드 아이콘 위젯
│       ├── coaching/
│       │   ├── coaching_screen.dart   # AI 코칭 화면
│       │   └── widgets/
│       │       ├── diagnosis_section.dart
│       │       └── action_item_tile.dart
│       └── comparison/
│           ├── comparison_screen.dart # 비교 분석 화면
│           └── widgets/
│               └── comparison_chart.dart
├── web/
│   └── index.html                     # 웹 설정
├── pubspec.yaml
└── PLAN.md (이 파일)
```

---

## 의존성

### pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter

  # UI
  google_fonts: ^7.1.0              # 웹폰트 (Noto Sans)
  intl: ^0.20.2                     # 숫자/퍼센트 포맷팅

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0
```

---

## 구현 단계 (1시간 타임라인)

### Phase 1: 프로젝트 설정 (5분)
- [ ] Flutter 프로젝트 생성
- [ ] pubspec.yaml 설정
- [ ] 폴더 구조 생성

### Phase 2: 디자인 시스템 (10분)
- [ ] app_colors.dart (컬러 상수)
- [ ] app_text_styles.dart (텍스트 스타일)
- [ ] app_theme.dart (ThemeData)

### Phase 3: 데이터 레이어 (10분)
- [ ] performance_metrics.dart 작성
- [ ] coaching_feedback.dart 작성
- [ ] benchmark_data.dart 작성
- [ ] mock_data.dart 작성 (샘플 데이터)

### Phase 4: 화면 구현 (30분)
- [ ] main.dart + app.dart (5분)
- [ ] dashboard_screen.dart + metric_card.dart (10분)
- [ ] coaching_screen.dart + action_item_tile.dart (10분)
- [ ] comparison_screen.dart + comparison_chart.dart (5분)

### Phase 5: 동작 연결 & 테스트 (5분)
- [ ] 네비게이션 연결
- [ ] 액션 아이템 체크 로직 검증
- [ ] 반응형 레이아웃 확인

---

## 핵심 UX 플로우

### 시나리오: 클릭률 저조 문제 진단 및 개선

1. **대시보드 진입**
   - 호스트가 앱을 열면 성과 지표 카드 4개 표시
   - 클릭률 1.2% (카테고리 평균 3.5%) → 빨간색 경고
   - 예약률 0.8% (카테고리 평균 2.1%) → 주황색 주의
   - 큰 "AI 코칭 받기" 버튼 표시

2. **AI 코칭 요청**
   - 버튼 클릭 → 코칭 화면 이동
   - 진단 요약:
     ```
     주요 문제: 클릭률이 카테고리 평균 대비 66% 낮습니다.

     원인 분석:
     - 메인 사진의 매력도가 낮아 시선을 끌지 못함
     - 가격이 경쟁 콘텐츠 대비 15% 높음
     - 제목이 구체적이지 않아 차별점이 보이지 않음
     ```

3. **개선 액션 확인**
   - 5개의 액션 아이템 표시:
     1. [High] 메인 사진 교체 → "밝고 활동적인 장면으로 변경" (클릭률 +25% 예상)
     2. [High] 가격 재설정 → "₩45,000에서 ₩38,000으로 조정" (클릭률 +15% 예상)
     3. [Medium] 제목 개선 → "특별한 체험" → "제주 올레길 선셋 투어 & 전통 음식 체험"
     4. [Medium] 운영 시간 확대 → "주말 오후 시간대 추가"
     5. [Low] 취소 정책 완화 → "24시간 전 → 48시간 전 무료 취소"

4. **액션 실행 추적**
   - 호스트가 메인 사진 교체 완료 → 체크박스 클릭
   - 가격 조정 완료 → 체크박스 클릭
   - 완료된 항목은 취소선 + 회색 처리
   - 미완료 항목은 볼드 강조

5. **비교 분석 확인**
   - 네비게이션에서 "비교" 탭 클릭
   - 내 클릭률 vs 평균 vs 상위 10% 막대 그래프
   - 강점: 취소율 낮음 (0.5% vs 평균 2.3%)
   - 약점: 클릭률 매우 낮음 (1.2% vs 평균 3.5%)

---

## 반응형 디자인

### Desktop (>= 600px)
- 지표 카드 그리드: 2x2 배치
- 최대 너비: 1000px (중앙 정렬)
- 사이드 여백: 32px
- 액션 아이템: 2열 그리드

### Mobile (< 600px)
- 지표 카드: 1열 세로 스택
- 전체 너비 사용
- 사이드 여백: 16px
- 액션 아이템: 1열 리스트

---

## 제외 사항 (시간 절약)

- ❌ 실제 AI 모델 연동 (GPT, Claude 등)
- ❌ 실시간 데이터 연동 (분석 API)
- ❌ 차트 라이브러리 (fl_chart 등) → 간단한 막대 그래프는 Container로 구현
- ❌ 푸시 알림
- ❌ 사용자 인증
- ❌ 데이터 영속성 (SharedPreferences, DB)
- ❌ 단위 테스트 (시간 제약)
- ❌ 복잡한 애니메이션 (기본 페이지 전환만)

---

## 성공 기준

### 기능 요구사항
- [x] 3개 화면 간 네비게이션 동작
- [x] 성과 지표 시각적 표시 (색상 + 트렌드)
- [x] AI 코칭 피드백 표시
- [x] 액션 아이템 체크/언체크 동작
- [x] 비교 분석 차트 표시

### 디자인 요구사항
- [x] 따뜻하고 친근한 UI
- [x] 컬러 시스템 일관성 (블루/레드/오렌지)
- [x] 라운드 처리된 카드/버튼
- [x] 상태별 색상 구분 (Good/Warning/Critical)
- [x] 데스크톱 반응형 레이아웃

### 기술 요구사항
- [x] flutter analyze 통과
- [x] 웹 빌드 성공
- [x] 로컬에서 정상 실행

---

## 확장 가능성 (Post-MVP)

### 단기 (1-2주)
- 실제 AI API 연동 (OpenAI GPT-4, Claude)
- 실시간 성과 데이터 연동 (Analytics API)
- 액션 아이템 자동 우선순위 재정렬
- 차트 라이브러리 도입 (fl_chart)

### 중기 (1-3개월)
- Firebase 백엔드 연동
- 주간/월간 성과 리포트 이메일 발송
- A/B 테스트 제안 기능
- 경쟁 콘텐츠 자동 모니터링

### 장기 (3-6개월)
- 다중 콘텐츠 관리
- AI 학습 피드백 루프 (개선 효과 추적)
- 예약 시스템 직접 통합 (가격/일정 자동 조정)
- 챗봇 형태의 대화형 코칭

---

## 참고 자료

- Flutter Material 3 Design: https://m3.material.io/
- Google Fonts: https://fonts.google.com/
- Intl 패키지: https://pub.dev/packages/intl
- Flutter Layout Cheat Sheet: https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e

---

## 개발자 노트

### 주의사항
1. **컬러 하드코딩 금지**: 모든 색상은 `AppColors` 클래스 사용
2. **매직 넘버 제거**: 간격/사이즈는 상수로 정의 (예: `AppSpacing.medium = 16`)
3. **위젯 분리**: 100줄 이상 위젯은 별도 파일로 분리
4. **일관된 네이밍**: 화면은 `*Screen`, 위젯은 `*Widget` 또는 구체적 이름
5. **접근성 고려**: 색상만으로 정보 전달 금지 (아이콘/텍스트 병행)

### 디버깅 팁
- 상태 변경 시 `debugPrint()` 로그 추가
- 액션 아이템 체크가 동작하지 않으면 `setState()` 호출 확인
- 반응형 레이아웃은 `MediaQuery.of(context).size.width` 활용
- 차트 렌더링 문제 시 `CustomPaint` 대신 `Container` 높이로 간단히 구현

### 목 데이터 시나리오
```dart
// 클릭률 저조 시나리오
views: 1500,
clickRate: 1.2,  // 매우 낮음 (평균 3.5%)
bookingRate: 0.8, // 낮음 (평균 2.1%)
cancellationRate: 0.5, // 좋음 (평균 2.3%)
trend: PerformanceTrend.down,
status: HealthStatus.critical,

// AI 진단 결과
diagnosis: "클릭률이 카테고리 평균 대비 66% 낮습니다. 메인 사진과 가격이 주요 원인입니다.",
actions: [
  ActionItem(
    title: "메인 사진 교체",
    description: "밝고 활동적인 장면으로 변경하세요",
    priority: Priority.high,
    category: ActionCategory.photos,
  ),
  // ... 4개 더
]
```

---

**작성일**: 2026-01-27
**예상 구현 시간**: 60분
**난이도**: ⭐⭐☆☆☆ (중하)
