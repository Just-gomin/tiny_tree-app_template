# 초록색 카운터 앱 MVP 구현 계획

## 프로젝트 정보

- **프로젝트명**: tinytree1768793169442
- **타입**: Flutter Web MVP
- **목표 구현 시간**: 1시간 이내
- **메인 색상**: 초록색 (Green)

## 핵심 기능 (3개)

1. **카운터 증가/감소**: 버튼을 눌러 숫자를 증가/감소시키는 기능
2. **카운터 초기화**: 카운터를 0으로 리셋하는 기능
3. **로컬 저장소 연동**: 앱을 닫아도 카운터 값이 유지되도록 SharedPreferences에 저장

## 화면 구성

### 단일 화면 (HomeScreen)

- **앱바**: 앱 제목 표시
- **카운터 표시 영역**: 현재 카운터 값을 큰 글씨로 표시
- **액션 버튼**:
  - 증가 버튼 (+)
  - 감소 버튼 (-)
  - 초기화 버튼 (Reset)

## 기술 스택

### 사용할 패키지

#### Core 패키지
- `storage`: 카운터 값을 로컬에 저장/불러오기 위해 사용

#### Flutter SDK
- `material.dart`: Material3 디자인 시스템
- `shared_preferences` (storage 패키지 내부에서 사용)

### 상태 관리
- **StatefulWidget**: 단순한 앱이므로 기본 상태 관리 사용
- 로컬 상태만 사용 (Provider, Riverpod 등 불필요)

## 디자인 시스템

### 색상 팔레트 (초록색 테마)

```dart
ColorScheme.fromSeed(
  seedColor: Colors.green,
  brightness: Brightness.light,
)
```

### Material3 컴포넌트
- `AppBar`: 앱 제목
- `FloatingActionButton`: 증가/감소 버튼
- `FilledButton`: 초기화 버튼
- `Card`: 카운터 값 표시 영역

## 프로젝트 구조

```
apps/tinytree1768793169442/
├── lib/
│   ├── main.dart                    # 앱 진입점
│   ├── app.dart                     # MaterialApp 설정
│   └── features/
│       └── counter/
│           ├── counter_screen.dart  # 카운터 화면
│           └── widgets/
│               ├── counter_display.dart  # 카운터 표시 위젯
│               └── counter_actions.dart  # 액션 버튼 위젯
├── web/
│   └── index.html                   # Web 진입점
├── pubspec.yaml                     # 의존성 설정
└── PLAN.md                          # 이 파일
```

## 구현 단계

### 1단계: Flutter 프로젝트 생성 및 설정
- Flutter 프로젝트 생성
- `pubspec.yaml`에 `storage` 패키지 의존성 추가
- `melos bootstrap` 실행하여 의존성 연결

### 2단계: 앱 기본 구조 작성
- `main.dart`: 앱 진입점 작성
- `app.dart`: Material3 테마 설정 (초록색 색상 스킴)

### 3단계: 카운터 화면 구현
- `counter_screen.dart`: StatefulWidget으로 카운터 화면 작성
- 카운터 상태 관리 (int 타입)
- 로컬 저장소 연동 (storage 패키지 사용)

### 4단계: UI 위젯 구현
- `counter_display.dart`: 카운터 값 표시 위젯
- `counter_actions.dart`: 증가/감소/초기화 버튼 위젯

### 5단계: 로컬 저장소 연동
- 앱 시작 시 저장된 카운터 값 불러오기
- 카운터 값 변경 시 자동 저장

### 6단계: 테스트 및 검증
- `flutter analyze` 실행하여 분석 오류 없음 확인
- Web에서 실행하여 동작 확인
- 로컬 저장소 기능 테스트 (새로고침 후 값 유지 확인)

## 기술적 결정 사항

### SharedPreferences 키 값
- 키: `counter_value`
- 타입: `int`
- 기본값: `0`

### 상태 관리 전략
- `initState()`에서 저장된 값 불러오기
- 카운터 값 변경 시마다 `setState()` 호출 및 저장

### 반응형 레이아웃
- 모바일/데스크톱 모두 대응
- `MediaQuery`를 활용한 반응형 텍스트 크기

## 제약 사항

### 포함하지 않는 기능
- 사용자 인증 (auth 패키지 불필요)
- 서버 연동 (로컬만 사용)
- 복잡한 애니메이션
- 다국어 지원
- 다크 모드 (라이트 모드만)

### 준수 사항
- Material3 디자인 가이드라인 준수
- `flutter analyze` 통과 필수
- 코드 스타일: CLAUDE.md의 코드 스타일 준수
- Import 순서: Dart SDK → Flutter SDK → 외부 패키지 → 내부 패키지 → 상대 경로

## 예상 산출물

### 필수 파일
1. `main.dart`: 앱 진입점
2. `app.dart`: MaterialApp 설정
3. `counter_screen.dart`: 카운터 화면
4. `counter_display.dart`: 카운터 표시 위젯
5. `counter_actions.dart`: 액션 버튼 위젯
6. `pubspec.yaml`: 의존성 설정

### 문서
- `PLAN.md`: 이 구현 계획서

## 성공 기준

1. ✅ Flutter Web에서 정상 실행
2. ✅ 카운터 증가/감소/초기화 동작
3. ✅ 새로고침 후에도 카운터 값 유지
4. ✅ 초록색 테마 적용
5. ✅ `flutter analyze` 통과
6. ✅ Material3 디자인 적용

## 예상 소요 시간

| 단계 | 예상 시간 |
|------|----------|
| 1단계: 프로젝트 생성 및 설정 | 10분 |
| 2단계: 앱 기본 구조 | 5분 |
| 3단계: 카운터 화면 구현 | 15분 |
| 4단계: UI 위젯 구현 | 15분 |
| 5단계: 로컬 저장소 연동 | 10분 |
| 6단계: 테스트 및 검증 | 5분 |
| **총계** | **60분** |

## UI 스케치

```
┌─────────────────────────────────┐
│  초록색 카운터 앱          [AppBar]│
├─────────────────────────────────┤
│                                 │
│         ┌─────────────┐         │
│         │             │         │
│         │     42      │  [Card] │
│         │             │         │
│         └─────────────┘         │
│                                 │
│      [+]    [-]    [Reset]      │
│                                 │
│                                 │
└─────────────────────────────────┘
```

## 참고 사항

- `storage` 패키지의 API를 확인하여 SharedPreferences 사용법 파악 필요
- Material3의 FilledButton, FloatingActionButton 스타일 활용
- 반응형을 위해 `LayoutBuilder` 또는 `MediaQuery` 활용
