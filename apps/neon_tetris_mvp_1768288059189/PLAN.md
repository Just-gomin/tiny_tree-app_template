# Flutter Web MVP - 네온 테트리스

## 프로젝트 정보
- **프로젝트명**: mvp_기똥찬_테트리스_게임__메인_테마는__1768288059189
- **타입**: Flutter Web Application
- **목표**: 1시간 내 구현 가능한 최소 기능
- **개발 시간**: ~60분

## 아이디어 개요
**네온 사이버펑크 테트리스 (Neon Cyberpunk Tetris)**
- 고전 테트리스 게임을 현대적인 네온 사이버펑크 스타일로 재해석
- 눈부신 네온 색상과 글로우 효과로 시각적 임팩트 극대화
- 외부 API 없이 로컬에서 완전히 동작하는 순수 게임

## 핵심 기능 (3개)

### 1. 클래식 테트리스 게임플레이
- 7가지 테트로미노 블록 (I, O, T, S, Z, J, L)
- 화살표 키로 이동/회전 제어
- 자동 낙하 + 중력 가속
- 줄 완성 시 제거 및 점수 획득

### 2. 네온 비주얼 시스템
- 각 블록마다 고유한 네온 컬러 (사이버펑크 팔레트)
- 블록 테두리 글로우 효과
- 배경 그리드 네온 라인
- 게임 오버 시 네온 플래시 애니메이션

### 3. 실시간 스코어 시스템
- 라인 클리어 점수 계산
- 현재 점수 / 최고 점수 표시
- 레벨 시스템 (점수에 따라 속도 증가)
- 다음 블록 미리보기

## 화면 구성 (단일 화면)

```
┌─────────────────────────────────────────┐
│  ⚡ NEON TETRIS ⚡         [PAUSE]      │
├─────────────────────────────────────────┤
│                                         │
│   ┌─────────┐   ┌──────────────┐      │
│   │  NEXT   │   │              │      │
│   │  ████   │   │   10x20      │      │
│   │    ██   │   │  GAME GRID   │      │
│   └─────────┘   │              │      │
│                 │  ████████    │      │
│   SCORE         │  ██  ████    │      │
│   12,800        │  ████ ██     │      │
│                 └──────────────┘      │
│   LEVEL                               │
│   5                                   │
│                                       │
│   HI-SCORE      LINES                │
│   25,600        42                   │
│                                       │
│   [NEW GAME]                         │
└─────────────────────────────────────────┘

Controls: ← → 이동 / ↑ 회전 / ↓ 빠른 낙하
```

## 기술 스택

### Flutter 패키지
- **flutter**: 기본 SDK
- **material design**: UI 컴포넌트

### 외부 의존성
- ❌ 없음 (완전히 독립적)

### 상태 관리
- **로컬 상태**: `StatefulWidget` 사용
- **게임 루프**: `Timer.periodic` 사용
- **데이터 저장**: 메모리 내 변수로만 관리 (최고 점수는 메모리에만)

## 파일 구조

```
mvp_기똥찬_테트리스_게임__메인_테마는__1768288059189/
├── lib/
│   ├── main.dart                    # 앱 진입점
│   ├── screens/
│   │   └── game_screen.dart         # 게임 메인 화면
│   ├── models/
│   │   ├── tetromino.dart           # 테트로미노 블록 모델
│   │   ├── game_board.dart          # 게임 보드 상태
│   │   └── game_state.dart          # 게임 상태 (점수, 레벨 등)
│   ├── widgets/
│   │   ├── game_grid.dart           # 게임 그리드 위젯
│   │   ├── block_widget.dart        # 개별 블록 위젯 (네온 효과)
│   │   ├── score_panel.dart         # 점수판 위젯
│   │   └── next_block_preview.dart  # 다음 블록 미리보기
│   ├── game/
│   │   ├── game_controller.dart     # 게임 로직 컨트롤러
│   │   └── collision_detector.dart  # 충돌 감지
│   └── constants/
│       └── colors.dart              # 네온 컬러 팔레트
├── web/
│   ├── index.html
│   └── manifest.json
├── pubspec.yaml
├── analysis_options.yaml
└── PLAN.md
```

## 구현 단계 (60분 예상)

### Phase 1: 프로젝트 설정 (5분)
1. Flutter 프로젝트 생성
2. pubspec.yaml 설정
3. 기본 파일 구조 생성

### Phase 2: 게임 모델 및 로직 (25분)
4. Tetromino 클래스 (7가지 블록 형태 정의)
5. GameBoard 클래스 (10x20 그리드)
6. CollisionDetector (충돌 감지 로직)
7. GameController (이동, 회전, 라인 클리어)

### Phase 3: UI 구현 (20분)
8. BlockWidget (네온 글로우 효과)
9. GameGrid (그리드 렌더링)
10. ScorePanel (점수/레벨 표시)
11. NextBlockPreview (다음 블록)

### Phase 4: 통합 및 테스트 (10분)
12. 키보드 입력 연결
13. 게임 루프 통합
14. 네온 컬러 및 스타일링 적용
15. 브라우저 테스트

## 구현 세부사항

### 테트로미노 형태 정의
```dart
enum TetrominoType { I, O, T, S, Z, J, L }

// I 블록 예시
const I_SHAPE = [
  [0, 0, 0, 0],
  [1, 1, 1, 1],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
];
```

### 네온 컬러 팔레트 (사이버펑크)
```dart
// 각 블록 타입별 네온 컬러
const NEON_COLORS = {
  TetrominoType.I: Color(0xFF00F0FF), // 사이언 (밝은 청록)
  TetrominoType.O: Color(0xFFFFFF00), // 일렉트릭 옐로우
  TetrominoType.T: Color(0xFFFF00FF), // 네온 마젠타
  TetrominoType.S: Color(0xFF00FF00), // 라임 그린
  TetrominoType.Z: Color(0xFFFF0040), // 네온 레드
  TetrominoType.J: Color(0xFF0080FF), // 일렉트릭 블루
  TetrominoType.L: Color(0xFFFF8000), // 네온 오렌지
};

// 글로우 효과를 위한 BoxShadow
BoxShadow neonGlow(Color color) => BoxShadow(
  color: color,
  blurRadius: 20,
  spreadRadius: 5,
);
```

### 게임 설정값
```dart
const int GRID_WIDTH = 10;
const int GRID_HEIGHT = 20;
const int INITIAL_DROP_SPEED = 800; // 800ms
const int LEVEL_SPEED_DECREASE = 50; // 레벨당 50ms 감소
const int POINTS_PER_LINE = 100;
const int LINES_PER_LEVEL = 10;
```

### 점수 계산 로직
```dart
// 한 번에 여러 줄 클리어 시 보너스
int calculateScore(int linesCleared) {
  switch (linesCleared) {
    case 1: return 100;
    case 2: return 300;   // 보너스
    case 3: return 500;   // 더 큰 보너스
    case 4: return 800;   // 테트리스 보너스!
    default: return 0;
  }
}
```

### 키보드 입력 매핑
```dart
// RawKeyboardListener 사용
onKey(RawKeyEvent event) {
  if (event is RawKeyDownEvent) {
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        moveLeft();
        break;
      case LogicalKeyboardKey.arrowRight:
        moveRight();
        break;
      case LogicalKeyboardKey.arrowUp:
        rotate();
        break;
      case LogicalKeyboardKey.arrowDown:
        dropFaster();
        break;
      case LogicalKeyboardKey.space:
        hardDrop(); // 즉시 낙하
        break;
    }
  }
}
```

## 비주얼 디자인 가이드

### 배경
- **어두운 배경**: `Color(0xFF0A0E27)` (다크 네이비)
- **그리드 라인**: 희미한 네온 블루 `Color(0x33007FFF)`

### 블록 렌더링
```dart
Container(
  decoration: BoxDecoration(
    color: blockColor.withOpacity(0.8),
    borderRadius: BorderRadius.circular(4),
    border: Border.all(color: blockColor, width: 2),
    boxShadow: [
      BoxShadow(
        color: blockColor,
        blurRadius: 12,
        spreadRadius: 2,
      ),
    ],
  ),
)
```

### 애니메이션 효과
- **라인 클리어**: 줄이 사라질 때 네온 플래시 (200ms)
- **게임 오버**: 전체 화면 레드 글로우 펄스
- **레벨 업**: 화면 테두리 골드 글로우 (1초)

## 제약사항 준수

✅ **외부 API 의존성 최소화**: 완전히 독립적, 외부 API 사용 안 함
✅ **단일 화면**: 1개의 메인 게임 화면만 사용
✅ **로컬 상태만 사용**: StatefulWidget으로 상태 관리
✅ **핵심 기능 3개 이하**: 게임플레이, 네온 비주얼, 스코어 시스템
✅ **1시간 내 구현**: 단순한 테트리스 로직으로 빠른 구현 가능

## 추가 개선 가능 항목 (v2.0)
- Local Storage를 이용한 최고 점수 영구 저장
- 배경 음악 및 효과음 추가
- 모바일 터치 컨트롤 (스와이프/탭)
- 리더보드 화면
- 다양한 테마 (레트로, 매트릭스, 홀로그램)
- Ghost piece (블록이 떨어질 위치 미리보기)

## 실행 방법

```bash
# 프로젝트 디렉토리로 이동
cd apps/mvp_기똥찬_테트리스_게임__메인_테마는__1768288059189

# 의존성 설치
flutter pub get

# 웹 개발 서버 실행
flutter run -d chrome

# 빌드 (배포용)
flutter build web
```

## 성공 기준
- ✅ 7가지 테트로미노가 올바르게 생성되고 회전
- ✅ 블록이 자동으로 낙하하고 쌓임
- ✅ 줄 완성 시 제거 및 점수 증가
- ✅ 키보드 조작이 즉각적으로 반응
- ✅ 네온 글로우 효과가 적용된 블록
- ✅ 게임 오버 감지 및 재시작 가능
- ✅ 점수, 레벨, 다음 블록이 정확히 표시
- ✅ 반응형 UI (다양한 화면 크기 대응)

## 난이도 조정
- **기본 속도**: 800ms (초급)
- **레벨 10**: 300ms (중급)
- **레벨 20**: 50ms (고급, 거의 불가능)

## 학습 포인트
- Flutter의 CustomPaint를 사용한 커스텀 렌더링
- Timer.periodic을 이용한 게임 루프 구현
- RawKeyboardListener를 통한 키보드 입력 처리
- BoxShadow를 활용한 네온 글로우 효과
- 2D 배열을 사용한 게임 보드 상태 관리
- 충돌 감지 알고리즘 구현

---

**예상 완료 시간**: 60분
**난이도**: 중급
**재미 지수**: ⚡⚡⚡⚡⚡ (5/5 기똥찬!)
**네온 레벨**: 🌈 MAXIMUM CYBERPUNK 🌈
