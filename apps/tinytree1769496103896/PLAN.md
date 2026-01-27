# AI Host Copilot - Flutter Web MVP 구현 계획

## 프로젝트 개요

**목표**: 1시간 내 구현 가능한 외국인 고객 응대 자동화 AI 데모 앱
**타겟 플랫폼**: Flutter Web (Desktop 반응형 지원)
**구현 범위**: 호스트(Guru)가 AI가 생성한 응답을 검토하고 승인하는 핵심 플로우

---

## 핵심 기능 (3개)

### 1. 고객 문의 대시보드
- **목적**: 대기 중인 고객 문의 목록 표시
- **구성**:
  - 문의 카드 리스트 (고객명, 문의 내용 요약, 시간, 상태)
  - 필터: 전체/대기중/완료
  - 카운터: 대기 중인 문의 개수 배지

### 2. AI 응답 검토 화면
- **목적**: AI가 생성한 응답을 호스트가 확인하고 수정/승인
- **구성**:
  - 원본 문의 전문 표시
  - AI 생성 응답 (수정 가능한 텍스트 필드)
  - 액션 버튼: "승인 후 전송", "수정 후 전송", "거절"
  - 적용된 정책 표시 (예: 취소 규정, 일정 변경 규정)

### 3. 응답 히스토리
- **목적**: 처리 완료된 문의 내역 확인
- **구성**:
  - 처리 완료된 문의 리스트
  - 원본 문의 + 전송된 응답 표시
  - 처리 시간 기록

---

## 화면 구조 (3개 화면)

```
┌─────────────────────────────────────────┐
│  1. 대시보드 (Dashboard)                 │
│  - 대기 중인 문의 카드 리스트             │
│  - 하단 네비게이션: 대시보드/히스토리     │
└─────────────────────────────────────────┘
           │ 카드 클릭
           ▼
┌─────────────────────────────────────────┐
│  2. AI 응답 검토 (Review)                │
│  - 문의 상세 + AI 응답                   │
│  - 수정/승인 액션                        │
└─────────────────────────────────────────┘
           │ 승인 후
           ▼
┌─────────────────────────────────────────┐
│  3. 응답 히스토리 (History)              │
│  - 완료된 문의 리스트                    │
│  - 확장 가능한 아코디언 UI               │
└─────────────────────────────────────────┘
```

---

## 데이터 구조

### InquiryModel (문의)
```dart
class Inquiry {
  final String id;
  final String customerName;
  final String customerLanguage; // en, ja, zh, etc.
  final String subject;
  final String content;
  final DateTime receivedAt;
  final InquiryStatus status; // pending, reviewed, sent
  final String? aiResponse;
  final String? appliedPolicy;
  final DateTime? respondedAt;
}

enum InquiryStatus { pending, reviewed, sent }
```

### 목 데이터 (Mock Data)
- 5개의 샘플 문의 (영어, 일본어, 중국어)
- 예약 변경, 취소 요청, 시설 문의 등 다양한 케이스
- AI 응답은 사전 정의된 템플릿 사용

---

## 디자인 시스템

### 컬러 팔레트
```dart
// Primary Colors
primaryDark: Color(0xFF1A237E),      // 다크 블루 (CTA, 중요 텍스트)
primaryRed: Color(0xFFE53935),       // 레드 (홈 CTA)

// Support Colors
accentOrange: Color(0xFFFF9800),     // 오렌지 (시간 아이콘)
accentYellow: Color(0xFFFFF3E0),     // 옐로우 배경 (대기 상태)

// Neutral
backgroundWhite: Color(0xFFFFFFFF),
backgroundGray: Color(0xFFF5F5F5),
textDark: Color(0xFF212121),
textGray: Color(0xFF757575),
```

### 타이포그래피
```dart
// Headline (카드 제목, 화면 타이틀)
fontSize: 20, fontWeight: FontWeight.w600

// Body (문의 내용, AI 응답)
fontSize: 16, fontWeight: FontWeight.w400

// Caption (메타 정보, 시간)
fontSize: 14, fontWeight: FontWeight.w400, color: textGray
```

### 컴포넌트 스타일
- **카드**: borderRadius 12, elevation 2
- **버튼**: borderRadius 8, height 48
- **배지**: borderRadius 16, padding 6x12
- **간격**: 16px (기본), 24px (섹션 간)

---

## 상태 관리

### 방식: StatefulWidget + Local State
- 서버 통신 없음
- SharedPreferences 불필요 (세션 유지 불필요)
- 목 데이터를 초기 상태로 사용

### 상태 흐름
```
[초기 상태]
- 5개의 pending 문의

[사용자 액션: 승인]
1. 문의 상태를 'sent'로 변경
2. respondedAt 타임스탬프 기록
3. 대시보드로 돌아감
4. 히스토리 탭에서 확인 가능

[사용자 액션: 수정]
1. AI 응답 텍스트 수정
2. 승인 버튼 클릭 시 수정본으로 전송
```

---

## 파일 구조

```
apps/tinytree1769496103896/
├── lib/
│   ├── main.dart                      # 앱 진입점
│   ├── app.dart                       # MaterialApp 설정
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_colors.dart        # 컬러 상수
│   │   │   ├── app_text_styles.dart   # 텍스트 스타일
│   │   │   └── app_theme.dart         # ThemeData
│   │   └── constants/
│   │       └── mock_data.dart         # 목 데이터
│   ├── models/
│   │   └── inquiry_model.dart         # 문의 데이터 모델
│   └── screens/
│       ├── dashboard/
│       │   ├── dashboard_screen.dart  # 대시보드 화면
│       │   └── widgets/
│       │       └── inquiry_card.dart  # 문의 카드 위젯
│       ├── review/
│       │   ├── review_screen.dart     # AI 응답 검토 화면
│       │   └── widgets/
│       │       ├── inquiry_detail.dart
│       │       └── ai_response_editor.dart
│       └── history/
│           └── history_screen.dart    # 히스토리 화면
├── web/
│   └── index.html                     # 웹 설정
├── pubspec.yaml
└── PLAN.md (이 파일)
```

---

## 의존성

### pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter

  # UI
  google_fonts: ^7.1.0              # 웹폰트
  intl: ^0.20.2                     # 날짜 포맷팅

  # packages/core/domain (프로젝트 내부 패키지)
  # domain:
  #   path: ../../packages/core/domain
  # → MVP에서는 사용하지 않음 (시간 절약)

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^7.0.0
```

---

## 구현 단계 (1시간 타임라인)

### Phase 1: 프로젝트 설정 (5분)
- [ ] Flutter 프로젝트 생성
- [ ] pubspec.yaml 설정
- [ ] 폴더 구조 생성

### Phase 2: 디자인 시스템 (10분)
- [ ] app_colors.dart
- [ ] app_text_styles.dart
- [ ] app_theme.dart

### Phase 3: 데이터 레이어 (10분)
- [ ] inquiry_model.dart 작성
- [ ] mock_data.dart 작성 (5개 샘플)

### Phase 4: 화면 구현 (30분)
- [ ] main.dart + app.dart (5분)
- [ ] dashboard_screen.dart + inquiry_card.dart (10분)
- [ ] review_screen.dart + 위젯들 (10분)
- [ ] history_screen.dart (5분)

### Phase 5: 동작 연결 & 테스트 (5분)
- [ ] 네비게이션 연결
- [ ] 상태 업데이트 로직 검증
- [ ] 반응형 레이아웃 확인

---

## 핵심 UX 플로우

### 시나리오: 일본인 고객의 일정 변경 요청 처리

1. **대시보드 진입**
   - 호스트가 앱을 열면 5개의 대기 중인 문의 표시
   - "Yuki Tanaka (일본어)" 카드에 노란색 배지 "대기중"

2. **문의 확인**
   - 카드 클릭 → 검토 화면 이동
   - 원문(일본어): "予約を3月15日から3月20日に変更できますか？"
   - AI 번역 + 요약: "3월 15일 예약을 3월 20일로 변경 요청"

3. **AI 응답 검토**
   - AI 생성 응답(일본어):
     ```
     田中様、お問い合わせありがとうございます。
     3月20日への変更が可能です。変更手数料は無料です。
     ご希望の時間帯を教えていただけますか？
     ```
   - 적용된 정책: "7일 전 일정 변경 무료"

4. **승인 및 전송**
   - 호스트가 "승인 후 전송" 버튼 클릭
   - 문의가 히스토리로 이동
   - 대시보드 카운터 4개로 감소

---

## 반응형 디자인

### Desktop (>= 600px)
- 카드 그리드: 2열
- 최대 너비: 1200px (중앙 정렬)
- 사이드 여백: 24px

### Mobile (< 600px)
- 카드 리스트: 1열
- 전체 너비 사용
- 사이드 여백: 16px

---

## 제외 사항 (시간 절약)

- ❌ 실제 AI 모델 연동 (OpenAI API 등)
- ❌ 다국어 번역 API
- ❌ 푸시 알림
- ❌ 실시간 채팅
- ❌ 사용자 인증
- ❌ 데이터 영속성 (SharedPreferences, DB)
- ❌ 단위 테스트 (시간 제약)
- ❌ 애니메이션 (기본 페이지 전환만)

---

## 성공 기준

### 기능 요구사항
- [x] 3개 화면 간 네비게이션 동작
- [x] 문의 상태 변경 (pending → sent)
- [x] AI 응답 수정 가능
- [x] 히스토리 필터링 동작

### 디자인 요구사항
- [x] 따뜻하고 친근한 UI
- [x] 컬러 시스템 일관성
- [x] 라운드 처리된 카드/버튼
- [x] 데스크톱 반응형 레이아웃

### 기술 요구사항
- [x] flutter analyze 통과
- [x] 웹 빌드 성공
- [x] 로컬에서 정상 실행

---

## 확장 가능성 (Post-MVP)

### 단기 (1-2주)
- 실제 AI API 연동 (OpenAI, Claude)
- 다국어 번역 서비스 (Google Translate API)
- 응답 템플릿 관리 기능

### 중기 (1-3개월)
- Firebase 백엔드 연동
- 실시간 알림 (FCM)
- 응답 성능 분석 대시보드

### 장기 (3-6개월)
- 다중 호스트 관리
- AI 학습 데이터 피드백 루프
- 예약 시스템 통합 (OTA API)

---

## 참고 자료

- Flutter Material 3 Design: https://m3.material.io/
- Google Fonts: https://fonts.google.com/
- Intl 패키지: https://pub.dev/packages/intl

---

## 개발자 노트

### 주의사항
1. **컬러 하드코딩 금지**: 모든 색상은 `AppColors` 클래스 사용
2. **매직 넘버 제거**: 간격/사이즈는 상수로 정의
3. **위젯 분리**: 100줄 이상 위젯은 별도 파일로 분리
4. **일관된 네이밍**: 화면은 `*Screen`, 위젯은 `*Widget` 또는 구체적 이름

### 디버깅 팁
- 상태 변경 시 `print()` 로그 추가
- 카드 탭 이벤트가 동작하지 않으면 `InkWell`의 `onTap` 확인
- 반응형 레이아웃은 `LayoutBuilder` 사용

---

**작성일**: 2026-01-27
**예상 구현 시간**: 60분
**난이도**: ⭐⭐☆☆☆ (중하)
