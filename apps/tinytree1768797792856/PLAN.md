# UTC 시계 앱 MVP 구현 계획

## 프로젝트 개요

**앱 이름**: UTC Clock
**목표**: 1시간 내 구현 가능한 최소 기능의 UTC 시계 앱
**배포 대상**: Flutter Web

## 핵심 기능 (3개)

1. **실시간 UTC 시간 표시**
   - 초 단위로 업데이트되는 현재 UTC 시간 표시
   - 대형 타이포그래피로 가독성 확보

2. **날짜 정보 표시**
   - 현재 UTC 날짜 (년-월-일, 요일) 표시
   - ISO 8601 형식 지원

3. **타임존 오프셋 표시**
   - 로컬 시간과 UTC의 시차 표시
   - 예: "UTC+09:00" (한국 기준)

## 화면 구성

### 단일 화면 (Home Screen)

```
┌─────────────────────────────────┐
│         UTC CLOCK               │
│                                 │
│      14:23:45                   │
│      (대형 시간 표시)             │
│                                 │
│   2026년 1월 19일 일요일         │
│                                 │
│   Local: UTC+09:00              │
│   Local Time: 23:23:45          │
└─────────────────────────────────┐
```

## 기술 스택

### Flutter & Dart
- Dart SDK: 3.9+
- Flutter: 3.29+
- 플랫폼: Web

### 패키지 의존성

#### Core 패키지
- **불필요** (시간 관련 기능은 Dart 기본 제공)

#### 외부 패키지
- **intl**: 날짜/시간 포맷팅 (선택적)
- **기본 Dart DateTime 사용** 권장

### 사용 기술
- **상태 관리**: StatefulWidget + Timer
- **스타일링**: Material 3
- **반응형**: MediaQuery 활용

## 프로젝트 구조

```
apps/tinytree1768797792856/
├── lib/
│   ├── main.dart              # 앱 진입점
│   ├── app.dart               # MaterialApp 설정
│   └── features/
│       └── clock/
│           ├── clock_screen.dart      # 메인 화면
│           └── widgets/
│               ├── utc_time_display.dart    # UTC 시간 위젯
│               ├── date_display.dart        # 날짜 위젯
│               └── timezone_info.dart       # 타임존 정보 위젯
├── web/
│   └── index.html
├── pubspec.yaml
├── PLAN.md                    # 본 문서
└── README.md
```

## 구현 세부사항

### 1. main.dart

```dart
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const UTCClockApp());
}
```

### 2. app.dart

```dart
import 'package:flutter/material.dart';
import 'features/clock/clock_screen.dart';

class UTCClockApp extends StatelessWidget {
  const UTCClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTC Clock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const ClockScreen(),
    );
  }
}
```

### 3. clock_screen.dart

**핵심 로직**:
- `Timer.periodic`으로 1초마다 상태 업데이트
- `DateTime.now().toUtc()`로 UTC 시간 획득
- `DateTime.now()`로 로컬 시간 획득
- 타임존 오프셋 계산: `localTime.timeZoneOffset`

**상태 관리**:
```dart
class _ClockScreenState extends State<ClockScreen> {
  late Timer _timer;
  late DateTime _currentUtcTime;
  late DateTime _currentLocalTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentUtcTime = DateTime.now().toUtc();
      _currentLocalTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
```

### 4. 위젯 구성

#### utc_time_display.dart
- 시:분:초 대형 표시
- `TextStyle(fontSize: 72, fontWeight: FontWeight.bold)`
- 모노스페이스 폰트 사용 권장

#### date_display.dart
- 날짜 포맷: "2026년 1월 19일 일요일"
- ISO 8601 옵션: "2026-01-19"

#### timezone_info.dart
- 타임존 오프셋 표시
- 로컬 시간 표시 (참고용)

## pubspec.yaml 설정

```yaml
name: utc_clock
description: Simple UTC clock web app
version: 1.0.0
publish_to: none

environment:
  sdk: ^3.9.0
  flutter: ">=3.29.0"

dependencies:
  flutter:
    sdk: flutter
  intl: ^0.20.2  # 날짜 포맷팅용 (선택적)

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0

flutter:
  uses-material-design: true
```

## 구현 순서

1. **프로젝트 초기화** (5분)
   - pubspec.yaml 수정
   - 기본 구조 생성

2. **앱 기본 설정** (5분)
   - main.dart, app.dart 작성
   - Material 3 테마 설정

3. **ClockScreen 구현** (20분)
   - Timer 기반 상태 관리
   - 레이아웃 구성

4. **위젯 구현** (20분)
   - UTC 시간 표시 위젯
   - 날짜 표시 위젯
   - 타임존 정보 위젯

5. **스타일링 및 반응형** (10분)
   - 타이포그래피 조정
   - 모바일/데스크톱 대응

## 디자인 가이드

### 컬러 스킴
- Primary: Blue (시간 관련 → 신뢰감)
- Background: System (다크모드 대응)
- Text: High contrast

### 타이포그래피
- 시간: 72pt, Bold, Monospace
- 날짜: 24pt, Medium
- 타임존: 18pt, Regular

### 레이아웃
- Center alignment
- Vertical spacing: 24px
- Padding: 48px

## 테스트 체크리스트

### 기능 테스트
- [ ] UTC 시간이 1초마다 정확히 업데이트되는가?
- [ ] 날짜가 올바르게 표시되는가?
- [ ] 타임존 오프셋이 정확한가?
- [ ] 로컬 시간이 정확한가?

### UI/UX 테스트
- [ ] 모바일에서 읽기 쉬운가?
- [ ] 데스크톱에서 레이아웃이 적절한가?
- [ ] 다크모드가 정상 작동하는가?
- [ ] 타이머가 화면을 벗어나도 계속 작동하는가?

### 성능 테스트
- [ ] 메모리 누수가 없는가? (dispose 확인)
- [ ] 1초 간격이 정확한가?
- [ ] 브라우저 탭 전환 시 정상 동작하는가?

## 빌드 및 실행

### 로컬 개발
```bash
cd apps/tinytree1768797792856
flutter run -d chrome
```

### 프로덕션 빌드
```bash
flutter build web --release
```

### 빌드 결과물
- `build/web/` 디렉토리에 정적 파일 생성
- Firebase Hosting, Netlify, Vercel 등에 배포 가능

## 향후 확장 가능성 (MVP 이후)

1. **다중 타임존 지원**
   - 주요 도시별 시계 추가
   - 사용자 정의 타임존 선택

2. **알람 기능**
   - 특정 UTC 시간에 알람
   - 브라우저 Notification API 활용

3. **타이머/스톱워치**
   - 간단한 시간 측정 도구

4. **설정 기능**
   - 12/24시간 형식 선택
   - 날짜 형식 선택 (ISO 8601, 로케일별)

5. **로컬 저장소**
   - 사용자 설정 저장 (SharedPreferences)

## 예상 소요 시간

| 단계 | 시간 |
|------|------|
| 프로젝트 초기화 | 5분 |
| 앱 기본 설정 | 5분 |
| ClockScreen 구현 | 20분 |
| 위젯 구현 | 20분 |
| 스타일링 | 10분 |
| **총 예상 시간** | **60분** |

## 주의사항

1. **Timer 정리**: dispose에서 반드시 타이머 취소
2. **타임존 계산**: `DateTime.timeZoneOffset`은 Duration 타입
3. **포맷팅**: intl 없이 구현 시 수동 포맷팅 필요
4. **성능**: setState 호출이 1초마다 발생하므로 위젯 최적화 필요

## 성공 기준

- [x] 프로젝트 생성 완료
- [ ] 1시간 내 구현 완료
- [ ] `flutter analyze` 통과
- [ ] Flutter Web에서 정상 실행
- [ ] 핵심 기능 3개 모두 동작
- [ ] Material 3 디자인 적용
- [ ] 반응형 레이아웃 지원
