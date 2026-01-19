# Water Fill Animation

물 차오르기 애니메이션을 시각화하는 Flutter Web 앱입니다.

## 주요 기능

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

## 실행 방법

```bash
# 의존성 설치
flutter pub get

# 웹에서 실행
flutter run -d chrome

# 웹 빌드
flutter build web --release
```

## 기술 스택

- Flutter 3.29.0+
- Dart 3.9.0+
- Material Design 3

## 프로젝트 구조

```
lib/
├── main.dart                    # 진입점
├── app.dart                     # MaterialApp 설정
└── features/
    └── water_animation/
        ├── water_animation_screen.dart     # 메인 화면
        ├── widgets/
        │   ├── water_wave_painter.dart     # CustomPainter 구현
        │   ├── control_panel.dart          # 제어 버튼들
        │   └── color_picker.dart           # 색상 선택 버튼
        └── models/
            └── water_config.dart           # 물 설정 모델
```

## 라이센스

이 프로젝트는 Tiny Tree App Template의 일부입니다.
