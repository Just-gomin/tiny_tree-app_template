# PLAN.md - Hello World Multilingual MVP

## 프로젝트 개요

### 아이디어
애플 기기들의 시작 화면처럼 "안녕하세요(Hello)"를 다양한 나라의 언어로 일정 시간마다 변경하며 보여주는 Flutter Web 앱

### 목표
- 1시간 내 구현 가능한 MVP
- 단일 화면, 최소한의 기능
- 외부 API 의존성 없음

## 핵심 기능 (3개)

### 1. 다국어 인사말 데이터 관리
- **설명**: 20개 이상의 언어로 "안녕하세요" 인사말 데이터 제공
- **구현 방식**:
  - `lib/data/greetings_data.dart` 파일에 하드코딩된 리스트
  - 각 인사말은 언어 이름, 원어 표기, 영어 표기 포함
- **예시 데이터**:
  ```dart
  {
    'language': 'Korean',
    'greeting': '안녕하세요',
    'transliteration': 'Annyeonghaseyo'
  }
  ```

### 2. 자동 순환 표시
- **설명**: 설정된 시간 간격마다 다음 언어로 자동 전환
- **구현 방식**:
  - `Timer.periodic` 사용하여 3초마다 자동 전환
  - 애니메이션 효과 (Fade In/Out)로 부드러운 전환
- **기술 스택**:
  - `dart:async` Timer
  - Flutter `AnimatedSwitcher` 위젯

### 3. 간단한 인터랙션
- **설명**: 사용자가 수동으로 언어 변경 가능
- **구현 방식**:
  - 화면 탭하면 다음 언어로 즉시 전환
  - 일시정지/재생 버튼으로 자동 순환 제어
  - 언어 표시기 (현재 언어 번호 / 전체 언어 수)

## 화면 구성 (단일 화면)

### Home Screen
```
┌─────────────────────────────────┐
│                                 │
│          [일시정지/재생]          │
│                                 │
│                                 │
│         안녕하세요              │
│        (Annyeonghaseyo)         │
│           Korean                │
│                                 │
│          [5 / 20]               │
│                                 │
│    (화면 클릭 시 다음 언어)      │
│                                 │
└─────────────────────────────────┘
```

**UI 요소**:
- 상단: 일시정지/재생 버튼 (IconButton)
- 중앙:
  - 큰 텍스트로 인사말 표시
  - 작은 텍스트로 영어 표기
  - 언어 이름
- 하단: 진행 상태 표시 (현재/전체)
- 배경: 애플 스타일 그라디언트

## 기술 스택

### Flutter 패키지
```yaml
dependencies:
  flutter:
    sdk: flutter
  # Core packages (필수)
  theme:
    path: ../../packages/core/theme
  ui_kit:
    path: ../../packages/core/ui_kit
```

### 사용 기술
- **상태 관리**: StatefulWidget (단순 로컬 상태)
- **타이머**: `dart:async` Timer
- **애니메이션**: AnimatedSwitcher, Fade 전환
- **UI**: Material3 디자인
- **저장소**: 불필요 (모든 데이터 하드코딩)

## 디렉토리 구조

```
apps/tinytree1768788015408/
├── lib/
│   ├── main.dart                    # 앱 진입점
│   ├── app.dart                     # MaterialApp 설정
│   ├── data/
│   │   └── greetings_data.dart      # 인사말 데이터
│   ├── models/
│   │   └── greeting.dart            # Greeting 모델 클래스
│   └── screens/
│       └── home/
│           ├── home_screen.dart     # 메인 화면
│           └── widgets/
│               ├── greeting_display.dart  # 인사말 표시 위젯
│               └── control_button.dart    # 제어 버튼
├── web/
│   ├── index.html                   # 웹 엔트리
│   └── favicon.png
├── pubspec.yaml
├── PLAN.md                          # 이 파일
└── README.md
```

## 구현 단계 (순서)

### 1단계: 프로젝트 설정 (5분)
- [ ] Flutter 프로젝트 생성
- [ ] `pubspec.yaml` 설정 (core packages 추가)
- [ ] 디렉토리 구조 생성

### 2단계: 데이터 모델 및 데이터 준비 (10분)
- [ ] `Greeting` 모델 클래스 작성
- [ ] `greetings_data.dart`에 20개 언어 데이터 입력

### 3단계: 홈 화면 구현 (30분)
- [ ] `home_screen.dart` 기본 레이아웃 작성
- [ ] 상태 관리 로직 구현 (현재 인덱스, 타이머)
- [ ] `greeting_display.dart` 위젯 작성 (애니메이션 포함)
- [ ] `control_button.dart` 위젯 작성
- [ ] 탭 제스처 핸들링

### 4단계: UI 스타일링 (10분)
- [ ] 애플 스타일 그라디언트 배경
- [ ] 타이포그래피 설정 (큰 인사말, 작은 설명)
- [ ] 반응형 레이아웃 (모바일/데스크톱)

### 5단계: 테스트 및 빌드 (5분)
- [ ] `flutter analyze` 통과 확인
- [ ] 웹 브라우저에서 동작 테스트
- [ ] README.md 작성

## 데이터 샘플 (20개 언어)

| 번호 | 언어 | 인사말 | 영어 표기 |
|:---:|:---:|:---:|:---:|
| 1 | Korean | 안녕하세요 | Annyeonghaseyo |
| 2 | English | Hello | Hello |
| 3 | Spanish | Hola | Hola |
| 4 | French | Bonjour | Bonjour |
| 5 | German | Hallo | Hallo |
| 6 | Italian | Ciao | Ciao |
| 7 | Portuguese | Olá | Olá |
| 8 | Russian | Привет | Privet |
| 9 | Japanese | こんにちは | Konnichiwa |
| 10 | Chinese | 你好 | Nǐ hǎo |
| 11 | Arabic | مرحبا | Marhaban |
| 12 | Hindi | नमस्ते | Namaste |
| 13 | Turkish | Merhaba | Merhaba |
| 14 | Polish | Cześć | Cześć |
| 15 | Dutch | Hallo | Hallo |
| 16 | Swedish | Hej | Hej |
| 17 | Greek | Γεια σου | Yassou |
| 18 | Hebrew | שלום | Shalom |
| 19 | Thai | สวัสดี | Sawatdee |
| 20 | Vietnamese | Xin chào | Xin chào |

## UI/UX 디자인 가이드

### 색상 팔레트
- **배경 그라디언트**:
  - Top: `Color(0xFF1A1A2E)` (다크 블루)
  - Bottom: `Color(0xFF16213E)` (미드나잇 블루)
- **텍스트**:
  - 인사말: `Colors.white` (크기: 48-64)
  - 영어 표기: `Colors.white70` (크기: 20-24)
  - 언어 이름: `Colors.white60` (크기: 16-18)
- **액센트**: `Color(0xFF0F4C75)` (블루 액센트)

### 애니메이션
- **전환 효과**: FadeTransition (300ms duration)
- **커브**: `Curves.easeInOut`

### 반응형 설정
- **모바일** (< 600px):
  - 인사말 크기: 48
  - 패딩: 24
- **데스크톱** (>= 600px):
  - 인사말 크기: 64
  - 패딩: 48

## 제외 사항 (MVP에서 구현하지 않음)

- ❌ 사용자 설정 저장 (SharedPreferences)
- ❌ 언어 선택 드롭다운
- ❌ 시간 간격 커스터마이징
- ❌ 다크/라이트 모드 전환
- ❌ 소리 효과
- ❌ 애니메이션 종류 선택
- ❌ 즐겨찾기 언어

## 성공 기준

### 필수 (Must Have)
- ✅ 20개 언어 인사말이 3초마다 자동 전환됨
- ✅ 애니메이션이 부드럽게 작동함
- ✅ 화면 탭 시 즉시 다음 언어로 전환됨
- ✅ 일시정지/재생 기능이 정상 작동함
- ✅ `flutter analyze` 통과
- ✅ 웹 브라우저에서 정상 실행

### 선택 (Nice to Have)
- 모바일 반응형 지원
- 애플 스타일 디자인 완성도
- 부드러운 애니메이션 효과

## 예상 소요 시간

| 단계 | 예상 시간 |
|:---:|:---:|
| 프로젝트 설정 | 5분 |
| 데이터 모델 및 데이터 준비 | 10분 |
| 홈 화면 구현 | 30분 |
| UI 스타일링 | 10분 |
| 테스트 및 빌드 | 5분 |
| **총계** | **60분** |

## 참고사항

- Material3 디자인 시스템 사용
- 웹 우선 개발 (모바일은 추가 테스트 필요)
- 모든 문자열은 하드코딩 (i18n 불필요)
- 상태 관리는 StatefulWidget으로 충분
- Timer는 위젯 dispose 시 반드시 취소 필요

## 다음 단계 (MVP 이후 개선 아이디어)

1. **설정 기능 추가**: 시간 간격, 언어 선택
2. **더 많은 언어**: 100개 이상의 언어 지원
3. **테마 변경**: 다크/라이트 모드, 커스텀 색상
4. **애니메이션 다양화**: Slide, Scale, Rotate 등
5. **소셜 공유**: 현재 인사말 이미지 공유
6. **학습 모드**: 인사말 발음 듣기, 퀴즈

---

**작성일**: 2026-01-19
**예상 완료**: 1시간 이내
**타겟 플랫폼**: Flutter Web (Chrome, Safari, Firefox)
