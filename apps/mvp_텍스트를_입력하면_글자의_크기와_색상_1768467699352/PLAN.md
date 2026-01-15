# Flutter Web MVP - 텍스트 스타일러

## 프로젝트 정보
- **프로젝트명**: mvp_텍스트를_입력하면_글자의_크기와_색상_1768467699352
- **패키지명**: text_styler_mvp
- **타입**: Flutter Web Application
- **목표**: 1시간 내 구현 가능한 최소 기능
- **개발 시간**: ~60분

## 아이디어 개요
**실시간 텍스트 스타일러 (Text Styler)**
- 텍스트를 입력하면 즉시 글자의 크기와 색상을 변경할 수 있는 인터랙티브 도구
- 디자인 프리뷰 또는 타이포그래피 실험용 도구
- 외부 API 없이 로컬 상태로만 동작

## 핵심 기능 (3개)

### 1. 텍스트 입력
- 실시간 텍스트 입력 필드
- 입력한 텍스트를 즉시 프리뷰 영역에 반영
- 기본 텍스트: "Hello, World!" 또는 사용자 정의 텍스트

### 2. 글자 크기 조절
- 슬라이더를 통한 폰트 크기 변경 (12px ~ 120px)
- 현재 크기 숫자 표시
- 실시간 적용

### 3. 색상 변경
- 색상 팔레트 또는 컬러 피커
- 미리 정의된 8가지 색상 옵션
- 선택한 색상이 즉시 텍스트에 적용

## 화면 구성 (단일 화면)

```
┌─────────────────────────────────────────┐
│         Text Styler ✨                  │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ Enter your text...              │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │                                 │   │
│  │     Your Styled Text!           │   │
│  │    (크기와 색상 적용됨)           │   │
│  │                                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Font Size: 48                          │
│  ━━━●━━━━━━━━━━━━━━━━  (12-120)       │
│                                         │
│  Text Color:                            │
│  [●][●][●][●][●][●][●][●]              │
│   빨강 주황 노랑 초록 파랑 남색 보라 검정  │
│                                         │
│  [Reset Styles]                         │
└─────────────────────────────────────────┘
```

## 기술 스택

### Flutter 패키지
- **flutter**: 기본 SDK
- **material design**: UI 컴포넌트

### 외부 의존성
- ❌ 없음 (완전히 독립적)

### 상태 관리
- **로컬 상태**: `StatefulWidget` 사용
- **데이터 저장**: 메모리 내 변수로만 관리 (영구 저장 없음)

## 파일 구조

```
mvp_텍스트를_입력하면_글자의_크기와_색상_1768467699352/
├── lib/
│   ├── main.dart                 # 앱 진입점
│   ├── screens/
│   │   └── styler_screen.dart    # 스타일러 메인 화면
│   ├── widgets/
│   │   ├── text_input_field.dart # 텍스트 입력 위젯
│   │   ├── text_preview.dart     # 스타일 적용 프리뷰
│   │   ├── font_size_slider.dart # 폰트 크기 슬라이더
│   │   └── color_picker.dart     # 색상 선택 위젯
│   └── models/
│       └── text_style_state.dart # 텍스트 스타일 상태 모델
├── web/
│   ├── index.html
│   └── manifest.json
├── pubspec.yaml
├── analysis_options.yaml
└── PLAN.md
```

## 구현 단계 (60분 예상)

### Phase 1: 프로젝트 설정 (10분)
1. ✅ Flutter 프로젝트 생성
2. pubspec.yaml 설정 (의존성 최소화)
3. 기본 파일 구조 생성

### Phase 2: 상태 및 모델 구현 (15분)
4. TextStyleState 모델 작성
   - `String text`
   - `double fontSize`
   - `Color textColor`
5. StylerScreen StatefulWidget 작성

### Phase 3: UI 위젯 구현 (25분)
6. TextInputField 위젯
   - TextField로 텍스트 입력
   - onChange로 상태 업데이트
7. TextPreview 위젯
   - 스타일 적용된 텍스트 표시
   - Card 또는 Container로 디자인
8. FontSizeSlider 위젯
   - Slider 컴포넌트 (12.0 ~ 120.0)
   - 현재 크기 표시
9. ColorPicker 위젯
   - 8개 색상 버튼 그리드
   - 선택된 색상 강조 표시

### Phase 4: 통합 및 테스트 (10분)
10. 화면 통합 및 레이아웃 조정
11. 반응형 디자인 (모바일/데스크톱)
12. 브라우저 테스트

## 구현 세부사항

### 기본 설정값
```dart
const String DEFAULT_TEXT = "Hello, World!";
const double DEFAULT_FONT_SIZE = 48.0;
const double MIN_FONT_SIZE = 12.0;
const double MAX_FONT_SIZE = 120.0;
const Color DEFAULT_COLOR = Colors.black;
```

### 색상 팔레트 (8가지)
```dart
final List<Color> colorPalette = [
  Colors.red,       // 빨강
  Colors.orange,    // 주황
  Colors.yellow,    // 노랑
  Colors.green,     // 초록
  Colors.blue,      // 파랑
  Colors.indigo,    // 남색
  Colors.purple,    // 보라
  Colors.black,     // 검정
];
```

### 레이아웃
- **메인 컨테이너**: 최대 너비 800px, 중앙 정렬
- **텍스트 입력**: Material TextField
- **프리뷰 영역**: 최소 높이 200px, 중앙 정렬
- **슬라이더**: 전체 너비
- **색상 버튼**: 40x40 원형 버튼, 간격 8px

## 제약사항 준수

✅ **외부 API 의존성 최소화**: 완전히 독립적, 외부 API 사용 안 함
✅ **단일 화면**: 1개의 메인 화면만 사용
✅ **로컬 상태만 사용**: StatefulWidget으로 상태 관리
✅ **핵심 기능 3개 이하**: 텍스트 입력, 크기 조절, 색상 변경
✅ **1시간 내 구현**: 단순한 구조로 빠른 구현 가능

## 추가 개선 가능 항목 (v2.0)
- 폰트 패밀리 선택 기능
- 텍스트 정렬 옵션 (왼쪽, 가운데, 오른쪽)
- 배경색 변경 기능
- 굵기(Bold), 이탤릭(Italic) 옵션
- 텍스트 스타일 프리셋 저장/불러오기
- 스타일 결과물 이미지로 내보내기
- 다크 모드 지원

## 실행 방법

```bash
# 프로젝트 디렉토리로 이동
cd "apps/mvp_텍스트를_입력하면_글자의_크기와_색상_1768467699352"

# 의존성 설치
flutter pub get

# 웹 개발 서버 실행
flutter run -d chrome

# 빌드 (배포용)
flutter build web
```

## 성공 기준
- ✅ 텍스트 입력 시 즉시 프리뷰 업데이트
- ✅ 슬라이더로 폰트 크기 실시간 변경 (12~120px)
- ✅ 색상 버튼 클릭 시 텍스트 색상 즉시 변경
- ✅ Reset 버튼으로 기본 스타일 복원
- ✅ 반응형 UI (모바일/데스크톱 대응)
- ✅ 브라우저에서 정상 실행

## 사용 시나리오

### 시나리오 1: 타이포그래피 실험
1. 사용자가 "Typography Test" 입력
2. 슬라이더로 크기를 72px로 조정
3. 보라색 선택
4. 다양한 크기와 색상 조합 테스트

### 시나리오 2: 로고 텍스트 디자인
1. 브랜드명 입력
2. 큰 크기(100px)와 파랑색 선택
3. 시각적 효과 확인

### 시나리오 3: 교육용 도구
1. 학생들이 텍스트 입력
2. 색상과 크기 변경으로 디자인 기본 학습
3. 다양한 조합 실험

---

**예상 완료 시간**: 60분
**난이도**: 초급
**학습 포인트**: Flutter 기본, StatefulWidget, Slider, Material Design, 실시간 상태 업데이트
