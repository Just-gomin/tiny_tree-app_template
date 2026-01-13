# Flutter Web MVP - 카운터 앱

## 프로젝트 개요
**목표**: 1시간 내 구현 가능한 최소 기능의 카운터 앱
**메인 컬러**: 갈색 (Brown)
**타입**: Flutter Web 단일 페이지 앱

---

## 핵심 기능 (3개)

### 1. 숫자 카운터 표시
- 초기값: 0
- 화면 중앙에 크게 현재 카운트 숫자 표시
- 갈색 테마 적용

### 2. +1 증가 버튼
- 버튼 클릭 시 카운트 1 증가
- 갈색 계열 버튼 디자인

### 3. -1 감소 버튼
- 버튼 클릭 시 카운트 1 감소
- 갈색 계열 버튼 디자인

---

## 기술 스택

### 프레임워크
- **Flutter**: ^3.9.0
- **Dart**: ^3.9.0

### 상태 관리
- **StatefulWidget**: Flutter 기본 상태 관리 (외부 의존성 없음)

### 스타일링
- Material Design 기본 위젯
- 커스텀 갈색 테마 (Brown ColorScheme)

---

## 화면 구성

### 단일 화면 (HomeScreen)
```
┌─────────────────────────────┐
│      Counter App (Brown)    │
├─────────────────────────────┤
│                             │
│                             │
│          [  0  ]            │  ← 현재 카운트 (큰 폰트)
│                             │
│                             │
│    [ -1 ]      [ +1 ]       │  ← 버튼 (갈색)
│                             │
│                             │
└─────────────────────────────┘
```

**레이아웃 구조**:
- AppBar: 타이틀만 표시
- Body: Column 위젯
  - Spacer
  - 카운트 숫자 (Text 위젯, 48px)
  - SizedBox (spacing)
  - Row 위젯 (버튼 2개)
    - -1 버튼 (ElevatedButton)
    - SizedBox (spacing)
    - +1 버튼 (ElevatedButton)
  - Spacer

---

## 파일 구조

```
mvp__1_버튼과__1_버튼이_있어__숫자_1768282772798/
├── lib/
│   ├── main.dart              # 앱 진입점 + 테마 설정
│   └── home_screen.dart       # 카운터 화면 (StatefulWidget)
├── web/
│   ├── index.html             # Flutter Web 엔트리
│   └── manifest.json
├── pubspec.yaml               # 의존성 (flutter SDK만)
├── analysis_options.yaml      # 린트 규칙
└── PLAN.md                    # 이 파일
```

---

## 구현 단계 (추정 시간: 45분)

### 1단계: 프로젝트 생성 (5분)
```bash
flutter create --platforms=web mvp__1_버튼과__1_버튼이_있어__숫자_1768282772798
cd mvp__1_버튼과__1_버튼이_있어__숫자_1768282772798
```

### 2단계: 설정 파일 복사 (5분)
- `analysis_options.yaml` 복사
- `pubspec.yaml` 수정 (name, description)

### 3단계: 갈색 테마 설정 (10분)
- `main.dart`에서 MaterialApp의 theme 설정
- ColorScheme.fromSeed(seedColor: Colors.brown)
- useMaterial3: true

### 4단계: HomeScreen 구현 (20분)
- StatefulWidget 생성
- int _counter = 0 상태 변수
- _incrementCounter() 메서드
- _decrementCounter() 메서드
- UI 레이아웃 구성

### 5단계: 테스트 및 실행 (5분)
```bash
flutter run -d chrome
```

---

## 상태 관리 로직

```dart
class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;  // 로컬 상태

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }
}
```

---

## 색상 팔레트 (갈색 테마)

- **Primary Color**: Brown (Colors.brown)
- **Seed Color**: Brown.shade700
- **Background**: 자동 생성 (밝은 크림색)
- **Button Color**: Primary color 기반 자동 생성
- **Text Color**: 자동 대비 색상

---

## 외부 의존성

**없음** - Flutter SDK 기본 기능만 사용

---

## 제약사항 준수

✅ **핵심 기능 3개 이하**: 카운터 표시, +1, -1
✅ **외부 API 의존성 최소화**: 없음
✅ **단일 화면**: HomeScreen 1개
✅ **로컬 상태만 사용**: StatefulWidget + setState
✅ **1시간 내 구현 가능**: 총 45분 추정

---

## 실행 방법

```bash
# 개발 서버 실행
flutter run -d chrome

# 빌드 (배포용)
flutter build web
```

---

## 향후 확장 가능성 (MVP 이후)

- 리셋 버튼 추가
- 카운트 히스토리 저장 (SharedPreferences)
- 애니메이션 효과
- 다크 모드 지원
- 카운트 범위 제한 (min/max)

---

**작성일**: 2026-01-13
**예상 구현 시간**: 45분
**난이도**: 하 (Beginner)
