# 초록색 시계 앱 MVP 구현 계획

## 프로젝트 개요

**앱 이름**: Green Clock (tinytree1768793894725)
**메인 컬러**: 초록색 (#4CAF50 계열)
**목표 구현 시간**: 1시간 이내
**타겟 플랫폼**: Flutter Web (Desktop/Mobile 반응형)

## 핵심 기능 (3개)

### 1. 실시간 디지털 시계 표시
- 현재 시간을 크게 표시 (HH:mm:ss 형식)
- 날짜 표시 (yyyy년 MM월 dd일 E요일)
- 1초마다 자동 업데이트
- 초록색 계열 그라데이션 배경

### 2. 타임존 선택
- 드롭다운으로 주요 도시 타임존 선택 (5개 정도)
  - 서울 (Asia/Seoul)
  - 도쿄 (Asia/Tokyo)
  - 뉴욕 (America/New_York)
  - 런던 (Europe/London)
  - 시드니 (Australia/Sydney)
- 선택된 타임존의 시간 표시
- SharedPreferences로 마지막 선택 타임존 저장

### 3. 12시간/24시간 형식 토글
- 스위치로 시간 형식 변경
- AM/PM 표시 (12시간 형식 선택 시)
- 설정값 로컬 저장 (SharedPreferences)

## 화면 구성

### 단일 화면 (Home Screen)
```
┌─────────────────────────────────────┐
│          Green Clock App            │ <- AppBar (초록색)
├─────────────────────────────────────┤
│                                     │
│         Seoul Time                  │ <- 선택된 타임존
│                                     │
│         15:30:45                    │ <- 큰 시계
│                                     │
│    2026년 01월 19일 일요일          │ <- 날짜
│                                     │
│  ┌─────────────────────────────┐   │
│  │ Timezone: [Seoul ▼]         │   │ <- 타임존 선택
│  └─────────────────────────────┘   │
│                                     │
│  [ ] 12시간 형식  [ ]             │ <- 토글 스위치
│                                     │
└─────────────────────────────────────┘
```

## 기술 스택

### Flutter 패키지
- **Flutter SDK**: 3.29.0+
- **Dart SDK**: 3.9.0+

### 내부 패키지 의존성
- `storage` (packages/core/storage): 설정 저장용

### 외부 패키지
- `intl: ^0.20.1`: 날짜/시간 포맷팅, 요일 한국어 표시
- `shared_preferences: ^2.5.4`: 로컬 설정 저장 (이미 melos.yaml에 있음)

### 상태 관리
- StatefulWidget + setState (단순한 로컬 상태)

## 디렉토리 구조

```
apps/tinytree1768793894725/
├── lib/
│   ├── main.dart                    # 앱 진입점
│   ├── app.dart                     # MaterialApp 설정
│   ├── theme/
│   │   └── app_theme.dart           # 초록색 테마 정의
│   └── features/
│       └── clock/
│           ├── clock_screen.dart    # 메인 시계 화면
│           ├── widgets/
│           │   ├── digital_clock.dart    # 시계 위젯
│           │   ├── date_display.dart     # 날짜 표시 위젯
│           │   ├── timezone_selector.dart # 타임존 선택 위젯
│           │   └── time_format_toggle.dart # 형식 토글 위젯
│           └── services/
│               └── clock_service.dart     # 시간 관련 로직
├── web/
│   └── index.html                   # Web 진입점
├── pubspec.yaml
├── PLAN.md                          # 본 파일
└── README.md
```

## 구현 단계

### Phase 1: 프로젝트 초기화 (5분)
- [ ] Flutter 프로젝트 생성
- [ ] pubspec.yaml 의존성 설정
- [ ] 기본 테마 설정 (초록색)
- [ ] melos bootstrap 실행

### Phase 2: UI 레이아웃 (15분)
- [ ] AppBar 및 기본 화면 구조
- [ ] 시계 표시 위젯 (큰 텍스트)
- [ ] 날짜 표시 위젯
- [ ] 타임존 드롭다운
- [ ] 형식 토글 스위치
- [ ] 반응형 레이아웃 적용

### Phase 3: 기능 구현 (30분)
- [ ] 실시간 시계 업데이트 (Stream/Timer)
- [ ] 타임존 변경 로직
- [ ] 12/24시간 형식 변환
- [ ] 날짜 포맷팅 (한국어)
- [ ] SharedPreferences 연동

### Phase 4: 테스트 및 마무리 (10분)
- [ ] flutter analyze 통과
- [ ] 브라우저에서 동작 확인
- [ ] 설정 저장/로드 테스트
- [ ] README.md 작성

## 색상 팔레트 (초록색 계열)

```dart
// Primary: Material Green
primaryColor: Color(0xFF4CAF50)
primaryLight: Color(0xFF81C784)
primaryDark: Color(0xFF388E3C)

// Background Gradient
gradientStart: Color(0xFF66BB6A)
gradientEnd: Color(0xFF2E7D32)

// Text
textPrimary: Colors.white
textSecondary: Color(0xFFE0E0E0)
```

## 데이터 모델

### ClockSettings (로컬 저장)
```dart
class ClockSettings {
  final String timezone;       // 'Asia/Seoul'
  final bool is24HourFormat;   // true/false
}
```

## 주요 기술 고려사항

### 1. 실시간 업데이트
```dart
// Timer.periodic으로 1초마다 setState 호출
Timer.periodic(Duration(seconds: 1), (timer) {
  setState(() {
    _currentTime = DateTime.now();
  });
});
```

### 2. 타임존 처리
```dart
// DateTime의 timeZoneName과 UTC offset 활용
final koreaTime = DateTime.now().toUtc().add(Duration(hours: 9));
```

### 3. 설정 저장
```dart
// storage 패키지 활용
await storage.saveString('timezone', 'Asia/Seoul');
await storage.saveBool('is24Hour', true);
```

## 제약사항 및 가정

### 제약사항
- 외부 API 미사용 (타임존 데이터는 하드코딩)
- 알람/타이머 기능 제외 (MVP 범위 초과)
- 백엔드 서버 불필요
- 복잡한 애니메이션 제외

### 가정
- 사용자는 브라우저 시간이 정확하다고 가정
- 주요 5개 도시 타임존만 제공
- 인터넷 연결 불필요 (모든 데이터 로컬)

## 성공 기준

1. ✅ 시계가 1초마다 정확히 업데이트됨
2. ✅ 타임존 변경 시 즉시 반영됨
3. ✅ 12/24시간 형식 토글 동작
4. ✅ 설정이 새로고침 후에도 유지됨
5. ✅ 반응형 레이아웃 (모바일/데스크톱)
6. ✅ flutter analyze 경고 없음
7. ✅ 초록색 테마 일관성 유지

## 다음 단계 (MVP 이후)

- [ ] 세계 시계 (여러 타임존 동시 표시)
- [ ] 스톱워치 기능
- [ ] 타이머 기능
- [ ] 알람 설정
- [ ] 커스텀 색상 테마
- [ ] 다크 모드
- [ ] 배경 이미지 커스터마이징

## 예상 파일 크기

- 총 Dart 코드: ~500-800 라인
- 파일 개수: ~10개
- 빌드 크기: ~2MB (Web)

## 참고사항

- Material 3 디자인 시스템 활용
- 접근성 고려 (큰 폰트, 명확한 대비)
- 성능 최적화 (불필요한 rebuild 방지)
- 깔끔하고 미니멀한 UI
