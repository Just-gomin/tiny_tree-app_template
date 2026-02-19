# TinyTree core/utils

Flutter 의존성 없는 순수 Dart 유틸리티 패키지입니다.

## 설치

```yaml
dependencies:
  utils:
    path: ../core/utils
```

## 모듈

### StringExtension / NullableStringExtension

```dart
import 'package:utils/utils.dart';

// null/빈 문자열 체크
String? name = null;
name.isNullOrEmpty;    // true
''.isNullOrEmpty;      // true
'hello'.isNullOrEmpty; // false

// 공백 체크
'   '.isBlank;         // true
' a '.isBlank;         // false

// 문자열 조작
'hello'.capitalize();              // 'Hello'
'Hello, World!'.truncate(5);       // 'Hello...'
'Hello, World!'.truncate(5, ellipsis: '→'); // 'Hello→'
'hello world'.removeSpaces();      // 'helloworld'
'helloWorld'.toSnakeCase();        // 'hello_world'
```

### DateTimeExtension

```dart
import 'package:utils/utils.dart';

// 날짜 포맷
DateTime(2024, 3, 15).formatDate();                          // '2024-03-15'
DateTime(2024, 3, 15).formatDate(pattern: 'yyyy년 MM월 dd일'); // '2024년 03월 15일'
DateTime(2024, 3, 15, 14, 30).formatDate(pattern: 'HH:mm'); // '14:30'

// 상대 시간
someDate.timeAgo();  // '방금 전', '5분 전', '2시간 전', '3일 전', '2달 전', '1년 전'

// ISO 8601 파싱
parseIso8601('2024-03-15T10:30:00Z'); // DateTime 반환
parseIso8601('invalid');               // null 반환

// 날짜 계산
DateTime(2024, 1, 1).daysBetween(DateTime(2024, 1, 10)); // 9

// 날짜 비교
DateTime.now().isToday;     // true
someDate.isYesterday;       // ...
someDate.isTomorrow;        // ...

// 시간 제거
DateTime(2024, 3, 15, 14, 30, 45).dateOnly; // DateTime(2024, 3, 15)
```

### NumExtension

```dart
import 'package:utils/utils.dart';

// 반올림
3.14159.roundTo(2);  // 3.14
3.14159.roundTo(0);  // 3.0

// 퍼센트
0.75.toPercentage();              // '75%'
0.1234.toPercentage(decimals: 1); // '12.3%'

// 통화 포맷
1234567.formatCurrency();                                       // '₩1,234,567'
1234.5.formatCurrency(locale: 'en', symbol: r'$', decimalDigits: 2); // '$1,234.50'

// 천 단위 구분
1234567.withThousandsSeparator();  // '1,234,567'

// 범위 체크
5.isBetween(1, 10);   // true
0.isBetween(1, 10);   // false
10.isBetween(1, 10);  // true (경계값 포함)
```

### ValidationUtils

```dart
import 'package:utils/utils.dart';

// 이메일 검증
ValidationUtils.isValidEmail('user@example.com');  // true
ValidationUtils.isValidEmail('invalid');           // false

// 전화번호 검증 (한국 휴대폰)
ValidationUtils.isValidPhone('01012345678');        // true (하이픈 없음)
ValidationUtils.isValidPhoneWithHyphen('010-1234-5678'); // true (하이픈 포함)

// URL 검증 (http/https)
ValidationUtils.isValidUrl('https://example.com'); // true
ValidationUtils.isValidUrl('example.com');          // false (스키마 필요)

// 비밀번호 검증 (8자+대소문자+숫자)
ValidationUtils.isValidPassword('Password1');  // true
ValidationUtils.isValidPassword('password');   // false
```

## 주의사항

- `toSnakeCase()`는 연속 대문자(`myAPIClient` → `my_a_p_i_client`)를 개별 단어로 처리합니다
- `timeAgo()`에서 미래 날짜는 빈 문자열(`''`)을 반환합니다
- `formatCurrency()`는 `intl` 패키지를 사용합니다
