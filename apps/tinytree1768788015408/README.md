# Hello World Multilingual

다국어 인사말을 자동으로 순환하며 표시하는 Flutter Web 앱입니다.

## 기능

- 20개 언어로 "안녕하세요" 인사말 자동 순환 표시 (3초 간격)
- 화면 클릭 시 다음 언어로 즉시 전환
- 일시정지/재생 버튼으로 자동 순환 제어
- 부드러운 페이드 애니메이션 효과
- 반응형 디자인 (모바일/데스크톱)

## 실행 방법

```bash
# 의존성 설치
flutter pub get

# 웹 실행
flutter run -d chrome

# 웹 빌드
flutter build web --release
```

## 기술 스택

- Flutter 3.29+
- Dart 3.9+
- Material3 디자인

## 프로젝트 구조

```
lib/
├── main.dart                    # 앱 진입점
├── app.dart                     # MaterialApp 설정
├── data/
│   └── greetings_data.dart      # 20개 언어 인사말 데이터
├── models/
│   └── greeting.dart            # Greeting 모델
└── screens/
    └── home/
        ├── home_screen.dart     # 메인 화면
        └── widgets/
            ├── greeting_display.dart  # 인사말 표시 위젯
            └── control_button.dart    # 제어 버튼
```

## 지원 언어

Korean, English, Spanish, French, German, Italian, Portuguese, Russian, Japanese, Chinese, Arabic, Hindi, Turkish, Polish, Dutch, Swedish, Greek, Hebrew, Thai, Vietnamese
