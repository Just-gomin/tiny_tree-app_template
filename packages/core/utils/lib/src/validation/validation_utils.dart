/// validation_utils.dart - 입력값 유효성 검사 유틸리티
library;

/// 입력값 유효성 검사를 위한 정적 메서드 모음.
///
/// 모든 메서드는 순수 함수(pure function)입니다.
final class ValidationUtils {
  /// 인스턴스 생성을 방지합니다.
  const ValidationUtils._();

  /// 대문자 정규식
  static final RegExp _uppercaseRegex = RegExp('[A-Z]');

  /// 소문자 정규식
  static final RegExp _lowercaseRegex = RegExp('[a-z]');

  /// 숫자 정규식
  static final RegExp _digitRegex = RegExp('[0-9]');

  // 이메일 주소 정규식 (RFC 5322 간략화 버전)
  // raw string 사용: \. 이 regex에서 리터럴 점을 의미
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // 한국 휴대폰 번호 (010/011/016/017/018/019 + 7~8자리)
  // 백슬래시 없음 → 일반 string
  static final RegExp _phoneRegex = RegExp(r'^01[016789][0-9]{7,8}$');

  // URL 정규식 (http/https 스키마 포함)
  // 백슬래시 있는 부분만 raw string 사용
  static final RegExp _urlRegex = RegExp(
    '^https?://'
    r'(([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})'
    '(:[0-9]{1,5})?'
    r'(/[^\s]*)?$',
  );

  /// 이메일 주소 형식이 유효한지 확인합니다.
  ///
  /// 앞뒤 공백은 무시합니다.
  ///
  /// 예시:
  /// ```dart
  /// ValidationUtils.isValidEmail('user@example.com');  // true
  /// ValidationUtils.isValidEmail('invalid-email');     // false
  /// ValidationUtils.isValidEmail('');                  // false
  /// ```
  static bool isValidEmail(String email) {
    if (email.isEmpty) {
      return false;
    }
    return _emailRegex.hasMatch(email.trim());
  }

  /// 한국 휴대폰 번호 형식이 유효한지 확인합니다.
  ///
  /// 하이픈(-) 없는 형식만 지원합니다.
  ///
  /// 예시:
  /// ```dart
  /// ValidationUtils.isValidPhone('01012345678');   // true
  /// ValidationUtils.isValidPhone('010-1234-5678'); // false (하이픈 미지원)
  /// ValidationUtils.isValidPhone('0212345678');    // false (유선 전화)
  /// ```
  static bool isValidPhone(String phone) {
    if (phone.isEmpty) {
      return false;
    }
    return _phoneRegex.hasMatch(phone.trim());
  }

  /// 한국 휴대폰 번호 형식이 유효한지 확인합니다. (하이픈 포함 가능)
  ///
  /// 예시:
  /// ```dart
  /// ValidationUtils.isValidPhoneWithHyphen('010-1234-5678'); // true
  /// ValidationUtils.isValidPhoneWithHyphen('01012345678');   // true
  /// ```
  static bool isValidPhoneWithHyphen(String phone) {
    if (phone.isEmpty) {
      return false;
    }
    return isValidPhone(phone.replaceAll('-', ''));
  }

  /// URL 형식이 유효한지 확인합니다.
  ///
  /// http 또는 https 스키마가 필요합니다.
  ///
  /// 예시:
  /// ```dart
  /// ValidationUtils.isValidUrl('https://example.com');         // true
  /// ValidationUtils.isValidUrl('http://sub.example.com/path'); // true
  /// ValidationUtils.isValidUrl('ftp://example.com');           // false
  /// ValidationUtils.isValidUrl('example.com');                 // false
  /// ```
  static bool isValidUrl(String url) {
    if (url.isEmpty) {
      return false;
    }
    return _urlRegex.hasMatch(url.trim());
  }

  /// 비밀번호가 기본 요구사항을 충족하는지 확인합니다.
  ///
  /// 요구사항: 최소 8자, 대문자 1개 이상, 소문자 1개 이상, 숫자 1개 이상
  ///
  /// 예시:
  /// ```dart
  /// ValidationUtils.isValidPassword('Password1');  // true
  /// ValidationUtils.isValidPassword('password');   // false (대문자, 숫자 없음)
  /// ValidationUtils.isValidPassword('12345678');   // false (문자 없음)
  /// ```
  static bool isValidPassword(String password) {
    if (password.length < 8) {
      return false;
    }
    final bool hasUppercase = password.contains(_uppercaseRegex);
    final bool hasLowercase = password.contains(_lowercaseRegex);
    final bool hasDigit = password.contains(_digitRegex);
    return hasUppercase && hasLowercase && hasDigit;
  }
}
