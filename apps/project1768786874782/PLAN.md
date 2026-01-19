# 물 차오르기 애니메이션 앱 - MVP 구현 계획

## 프로젝트 개요

**앱 이름**: Water Fill Animation
**타입**: Flutter Web Single Page Application
**목표 구현 시간**: 1시간
**난이도**: 초급

## 핵심 기능 (3개)

1. **물 차오르기 애니메이션**
   - 화면 하단부터 상단까지 물이 차오르는 애니메이션
   - 부드러운 파도 효과 (Sine Wave)
   - 반복 재생

2. **애니메이션 제어**
   - 재생/일시정지 버튼
   - 리셋 버튼
   - 속도 조절 슬라이더 (0.5x ~ 2.0x)

3. **커스터마이징**
   - 물 색상 선택 (파란색, 초록색, 보라색)
   - 배경 색상 자동 조정 (물 색상과 대비)

## 기술 스택

### 의존성
- **Flutter SDK**: 3.29.0+
- **Dart SDK**: 3.9.0+
- **Core Packages**:
  - `theme` (색상, 타이포그래피)
  - `ui_kit` (공용 버튼, 슬라이더)

### 사용할 Flutter 위젯
- `AnimatedBuilder` - 애니메이션 상태 관리
- `CustomPaint` - 파도 그리기
- `AnimationController` - 애니메이션 제어
- `Slider` - 속도 조절
- `IconButton` - 재생/일시정지/리셋

## 화면 구조

### 단일 화면 레이아웃

```
┌─────────────────────────────┐
│         App Bar             │ <- 제목만 표시
├─────────────────────────────┤
│                             │
│                             │
│      물 애니메이션 영역        │ <- CustomPaint로 구현
│      (Wave Animation)       │
│                             │
│                             │
├─────────────────────────────┤
│   [Play/Pause] [Reset]      │ <- 제어 버튼
│   ──────●──────────          │ <- 속도 슬라이더
│   [🔵] [🟢] [🟣]            │ <- 색상 선택
└─────────────────────────────┘
```

## 파일 구조

```
apps/project1768786874782/
├── lib/
│   ├── main.dart                    # 진입점
│   ├── app.dart                     # MaterialApp 설정
│   └── features/
│       └── water_animation/
│           ├── water_animation_screen.dart     # 메인 화면
│           ├── widgets/
│           │   ├── water_wave_painter.dart     # CustomPainter 구현
│           │   ├── control_panel.dart          # 제어 버튼들
│           │   └── color_picker.dart           # 색상 선택 버튼
│           └── models/
│               └── water_config.dart           # 물 설정 모델
├── web/
│   ├── index.html
│   └── favicon.png
├── pubspec.yaml
├── PLAN.md
└── README.md
```

## 구현 상세

### 1. 물 차오르기 애니메이션 (20분)

**WaterWavePainter (CustomPainter)**

```dart
class WaterWavePainter extends CustomPainter {
  final double animationValue;  // 0.0 ~ 1.0 (차오른 정도)
  final Color waterColor;
  final double waveHeight;      // 파도 높이
  final double waveFrequency;   // 파도 빈도

  // Sine wave 수식으로 파도 효과 구현
  // y = sin(x * frequency + phase) * amplitude
}
```

**애니메이션 설정**
- Duration: 5초 (기본값)
- Repeat: 무한 반복
- Curve: linear

### 2. 애니메이션 제어 (15분)

**AnimationController 관리**
- `play()`: controller.repeat()
- `pause()`: controller.stop()
- `reset()`: controller.reset() + controller.repeat()
- `setSpeed(double speed)`: controller.duration 변경

**ControlPanel Widget**
- Play/Pause 아이콘 토글
- Reset 버튼
- 속도 슬라이더 (0.5x ~ 2.0x, 0.1 간격)

### 3. 커스터마이징 (15분)

**색상 프리셋**
```dart
enum WaterColorPreset {
  blue(Color(0xFF2196F3), Color(0xFFE3F2FD)),    // 물 색상, 배경 색상
  green(Color(0xFF4CAF50), Color(0xFFE8F5E9)),
  purple(Color(0xFF9C27B0), Color(0xFFF3E5F5)),
}
```

**ColorPicker Widget**
- 3개의 원형 버튼
- 선택된 색상은 테두리 표시
- 탭하면 색상 변경

### 4. 상태 관리 (10분)

**StatefulWidget으로 충분**
```dart
class WaterAnimationScreen extends StatefulWidget {
  State:
  - AnimationController controller
  - bool isPlaying
  - double speed (1.0 기본값)
  - WaterColorPreset selectedColor
}
```

## 반응형 디자인

### 모바일 (< 600px)
- 애니메이션 영역: 전체 화면의 70%
- 제어 패널: 세로 정렬
- 버튼 크기: 48x48

### 데스크톱 (>= 600px)
- 애니메이션 영역: 전체 화면의 75%
- 제어 패널: 가로 정렬
- 버튼 크기: 56x56
- 최대 너비: 800px (중앙 정렬)

## 구현 순서

### Phase 1: 프로젝트 설정 (5분)
1. Flutter 프로젝트 생성
2. pubspec.yaml 의존성 추가 (theme, ui_kit)
3. main.dart, app.dart 기본 구조

### Phase 2: 애니메이션 구현 (25분)
4. WaterWavePainter 구현
5. WaterAnimationScreen 기본 구조
6. AnimationController 설정
7. 애니메이션 테스트

### Phase 3: 제어 기능 (20분)
8. ControlPanel 위젯 구현
9. Play/Pause/Reset 로직
10. 속도 조절 슬라이더

### Phase 4: 커스터마이징 (10분)
11. ColorPicker 위젯 구현
12. 색상 프리셋 적용
13. 배경 색상 연동

## 테스트 체크리스트

- [ ] 애니메이션이 부드럽게 반복되는가?
- [ ] Play/Pause 버튼이 정상 작동하는가?
- [ ] Reset 버튼이 애니메이션을 처음부터 다시 시작하는가?
- [ ] 속도 슬라이더가 애니메이션 속도를 변경하는가?
- [ ] 색상 선택 시 물과 배경 색상이 변경되는가?
- [ ] 모바일/데스크톱에서 레이아웃이 적절한가?
- [ ] `flutter analyze` 통과하는가?

## 산출물

1. **PLAN.md** (현재 파일)
2. **Flutter 앱 코드** (apps/project1768786874782/)
3. **README.md** (앱 사용 방법)

## 제약사항 및 범위 제외

### 포함하지 않음
- 사용자 인증
- 데이터 저장 (SharedPreferences)
- 애니메이션 녹화/공유 기능
- 고급 파도 효과 (멀티 레이어, 거품 등)
- 사운드 이펙트
- 다크 모드

### 향후 확장 가능성
- 다양한 애니메이션 프리셋 (분수, 비 등)
- 애니메이션 설정 저장
- SNS 공유 기능
- 물 높이 직접 조절 (드래그)

## 예상 결과

- **구현 시간**: 60분
- **코드 라인 수**: ~400줄
- **파일 개수**: 8개
- **앱 크기**: ~2MB (Web)

## 참고사항

- Material3 디자인 시스템 적용
- 접근성: 버튼에 Semantic Label 추가
- 성능: CustomPainter shouldRepaint 최적화
- Web 배포: `flutter build web --release`
