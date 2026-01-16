# 랜덤 농담 앱 MVP 구현 계획

## 프로젝트 정보

- **앱 이름**: Random Joke App
- **디렉토리**: `apps/mvp_https_official_joke_1768533558682`
- **목표 구현 시간**: 1시간
- **API**: https://official-joke-api.appspot.com/random_joke

## 핵심 기능 (3개)

1. **랜덤 농담 불러오기**: API 호출하여 랜덤 농담 표시
2. **새로운 농담 보기**: 버튼 클릭으로 새 농담 로드
3. **로딩 상태 표시**: API 호출 중 로딩 인디케이터

## 화면 구성 (단일 화면)

### Home Screen
- **상단**: 앱 타이틀 ("Random Joke")
- **중앙**: 농담 표시 영역
  - Setup (질문/상황)
  - Punchline (답변/펀치라인)
- **하단**: "Get New Joke" 버튼
- **로딩**: CircularProgressIndicator

## 기술 스택

### 필수 패키지
- `http: ^1.2.0` - API 호출용
- Flutter SDK (Material3)

### 불필요한 패키지
- ❌ 상태 관리 라이브러리 (StatefulWidget으로 충분)
- ❌ DI/서비스 로케이터
- ❌ 로컬 저장소 (캐싱 불필요)

## 프로젝트 구조

```
apps/mvp_https_official_joke_1768533558682/
├── lib/
│   ├── main.dart                  # 앱 진입점
│   ├── app.dart                   # MaterialApp 설정
│   └── features/
│       └── joke/
│           ├── models/
│           │   └── joke_model.dart       # Joke 데이터 모델
│           ├── services/
│           │   └── joke_service.dart     # API 호출 서비스
│           └── screens/
│               └── home_screen.dart      # 메인 화면
├── web/
│   └── index.html                 # Flutter Web 진입점
├── pubspec.yaml
├── analysis_options.yaml
├── PLAN.md                        # 이 파일
└── README.md
```

## API 스펙

### Endpoint
```
GET https://official-joke-api.appspot.com/random_joke
```

### Response 예시
```json
{
  "type": "general",
  "setup": "What do you call a bear with no teeth?",
  "punchline": "A gummy bear!",
  "id": 123
}
```

### 필요 필드
- `setup`: String (질문/상황)
- `punchline`: String (답변/펀치라인)
- `type`: String (농담 유형) - 선택적 표시
- `id`: int - UI에서 미사용

## 디자인 시스템

### 색상 팔레트
- **Primary**: Deep Purple (Material3 기본)
- **Surface**: White / Dark (다크모드 자동 지원)
- **Text**: High Contrast

### 타이포그래피
- **Setup**: `headlineMedium` (질문 강조)
- **Punchline**: `headlineSmall` (답변)
- **타입 배지**: `labelSmall`

### 레이아웃
```
┌─────────────────────────────┐
│      Random Joke 🎭          │  <- AppBar
├─────────────────────────────┤
│                             │
│   ┌───────────────────┐     │
│   │   [Type Badge]    │     │
│   └───────────────────┘     │
│                             │
│   "What do you call a       │  <- Setup
│    bear with no teeth?"     │
│                             │
│   ─────────────────         │  <- Divider
│                             │
│   "A gummy bear!"           │  <- Punchline
│                             │
│                             │
│   [  Get New Joke  ]        │  <- Button
│                             │
└─────────────────────────────┘
```

### 반응형 디자인
- **모바일**: 패딩 24px, 최대 너비 제한 없음
- **데스크톱**: 중앙 정렬, 최대 너비 600px

## 구현 단계

### 1단계: 프로젝트 생성 (5분)
```bash
cd apps
flutter create mvp_https_official_joke_1768533558682
cd mvp_https_official_joke_1768533558682
```

### 2단계: 의존성 추가 (2분)
`pubspec.yaml` 수정:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
```

### 3단계: 데이터 모델 생성 (5분)
`lib/features/joke/models/joke_model.dart`:
- `Joke` 클래스 정의
- `fromJson` 팩토리 생성자
- 불변 객체로 설계

### 4단계: API 서비스 구현 (10분)
`lib/features/joke/services/joke_service.dart`:
- `fetchRandomJoke()` 메서드
- HTTP GET 요청
- JSON 파싱
- 에러 핸들링 (try-catch)

### 5단계: UI 구현 (30분)
`lib/features/joke/screens/home_screen.dart`:
- StatefulWidget
- 상태: `Joke?`, `isLoading`, `error`
- `initState`에서 첫 농담 로드
- 로딩/성공/에러 상태별 UI
- 새 농담 버튼

`lib/app.dart`:
- MaterialApp 설정
- Material3 활성화
- 다크모드 지원

`lib/main.dart`:
- 앱 진입점

### 6단계: 테스트 및 검증 (8분)
```bash
flutter analyze
flutter run -d chrome
```

## 상태 관리

### 로컬 상태 (StatefulWidget)
```dart
class _HomeScreenState extends State<HomeScreen> {
  Joke? _currentJoke;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _loadJoke() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final joke = await JokeService.fetchRandomJoke();
      setState(() {
        _currentJoke = joke;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load joke';
        _isLoading = false;
      });
    }
  }
}
```

## 에러 핸들링

### 네트워크 에러
- 인터넷 연결 오류
- API 서버 장애
- 타임아웃

### UI 피드백
- 에러 메시지 표시
- "Retry" 버튼 제공
- 로딩 중 버튼 비활성화

## Material3 디자인 적용

### 컴포넌트
- `Card` - 농담 표시 영역
- `FilledButton` - 새 농담 버튼
- `CircularProgressIndicator` - 로딩
- `Chip` - 타입 배지

### 애니메이션
- 농담 변경 시 페이드 전환 (선택적)

## 웹 최적화

### index.html 수정
```html
<title>Random Joke App</title>
<meta name="description" content="Get random jokes instantly!">
```

### 빌드
```bash
flutter build web --release
```

## 품질 기준

### 필수 체크리스트
- [ ] `flutter analyze` 통과
- [ ] Material3 디자인 적용
- [ ] 반응형 레이아웃 (모바일/데스크톱)
- [ ] 로딩 상태 표시
- [ ] 에러 핸들링
- [ ] 다크모드 지원

### 선택 사항
- [ ] 애니메이션 효과
- [ ] 접근성 (Semantics)
- [ ] 단위 테스트

## 범위 제외

다음 기능은 MVP에서 제외:
- ❌ 농담 저장/즐겨찾기
- ❌ 농담 공유 기능
- ❌ 농담 카테고리 필터링
- ❌ 농담 히스토리
- ❌ 다국어 지원
- ❌ 복잡한 상태 관리
- ❌ 오프라인 모드

## 예상 결과물

1. **동작하는 Flutter Web 앱**
   - 브라우저에서 즉시 실행 가능
   - API 호출하여 랜덤 농담 표시
   - 깔끔하고 읽기 쉬운 디자인

2. **깔끔한 코드**
   - Linter 규칙 준수
   - 명확한 파일 구조
   - 주석 최소화 (자명한 코드)

3. **문서**
   - PLAN.md (이 파일)
   - README.md (사용법 안내)

## 시간 분배 (총 60분)

| 단계 | 소요 시간 | 누적 시간 |
|------|-----------|-----------|
| 프로젝트 생성 | 5분 | 5분 |
| 의존성 추가 | 2분 | 7분 |
| 데이터 모델 | 5분 | 12분 |
| API 서비스 | 10분 | 22분 |
| UI 구현 | 30분 | 52분 |
| 테스트 및 검증 | 8분 | 60분 |

## 완료 조건

MVP는 다음 조건을 모두 만족해야 합니다:

1. ✅ 브라우저에서 앱 실행
2. ✅ "Get New Joke" 버튼 클릭 시 새 농담 로드
3. ✅ Setup과 Punchline이 명확히 구분되어 표시
4. ✅ 로딩 중 인디케이터 표시
5. ✅ 에러 발생 시 메시지 표시
6. ✅ `flutter analyze` 오류 없음
7. ✅ 모바일/데스크톱 반응형 동작

## 다음 단계 (MVP 이후)

MVP 완료 후 고려할 개선사항:
1. 농담 카테고리별 필터링
2. 즐겨찾기 기능 (로컬 저장소)
3. 공유하기 버튼
4. 애니메이션 강화
5. 접근성 개선
6. 단위/위젯 테스트 추가
