import 'package:test/test.dart';
import 'package:utils/utils.dart';

void main() {
  group('ValidationUtils', () {
    group('isValidEmail', () {
      test('유효한 이메일은 true를 반환한다', () {
        expect(ValidationUtils.isValidEmail('user@example.com'), isTrue);
        expect(ValidationUtils.isValidEmail('user+tag@sub.domain.com'), isTrue);
        expect(ValidationUtils.isValidEmail('test.email@domain.co.kr'), isTrue);
      });

      test('@ 없는 이메일은 false를 반환한다', () {
        expect(ValidationUtils.isValidEmail('invalid'), isFalse);
      });

      test('도메인이 없는 이메일은 false를 반환한다', () {
        expect(ValidationUtils.isValidEmail('missing@'), isFalse);
      });

      test('TLD가 없는 이메일은 false를 반환한다', () {
        expect(ValidationUtils.isValidEmail('user@domain'), isFalse);
      });

      test('@ 앞이 없는 이메일은 false를 반환한다', () {
        expect(ValidationUtils.isValidEmail('@domain.com'), isFalse);
      });

      test('빈 문자열은 false를 반환한다', () {
        expect(ValidationUtils.isValidEmail(''), isFalse);
      });

      test('앞뒤 공백을 무시하고 검사한다', () {
        expect(ValidationUtils.isValidEmail('  user@example.com  '), isTrue);
      });
    });

    group('isValidPhone', () {
      test('010 번호는 true를 반환한다', () {
        expect(ValidationUtils.isValidPhone('01012345678'), isTrue);
      });

      test('011 번호는 true를 반환한다', () {
        expect(ValidationUtils.isValidPhone('01112345678'), isTrue);
      });

      test('016 번호는 true를 반환한다', () {
        expect(ValidationUtils.isValidPhone('01612345678'), isTrue);
      });

      test('하이픈이 있는 번호는 false를 반환한다', () {
        expect(ValidationUtils.isValidPhone('010-1234-5678'), isFalse);
      });

      test('유선 전화번호는 false를 반환한다', () {
        expect(ValidationUtils.isValidPhone('0212345678'), isFalse);
      });

      test('빈 문자열은 false를 반환한다', () {
        expect(ValidationUtils.isValidPhone(''), isFalse);
      });
    });

    group('isValidPhoneWithHyphen', () {
      test('하이픈이 있는 번호도 true를 반환한다', () {
        expect(
          ValidationUtils.isValidPhoneWithHyphen('010-1234-5678'),
          isTrue,
        );
      });

      test('하이픈 없는 번호도 true를 반환한다', () {
        expect(ValidationUtils.isValidPhoneWithHyphen('01012345678'), isTrue);
      });

      test('빈 문자열은 false를 반환한다', () {
        expect(ValidationUtils.isValidPhoneWithHyphen(''), isFalse);
      });
    });

    group('isValidUrl', () {
      test('https URL은 true를 반환한다', () {
        expect(ValidationUtils.isValidUrl('https://example.com'), isTrue);
      });

      test('http URL은 true를 반환한다', () {
        expect(ValidationUtils.isValidUrl('http://example.com'), isTrue);
      });

      test('경로가 있는 URL은 true를 반환한다', () {
        expect(
          ValidationUtils.isValidUrl('https://example.com/path/to/page'),
          isTrue,
        );
      });

      test('스키마가 없는 URL은 false를 반환한다', () {
        expect(ValidationUtils.isValidUrl('example.com'), isFalse);
      });

      test('ftp 스키마는 false를 반환한다', () {
        expect(ValidationUtils.isValidUrl('ftp://example.com'), isFalse);
      });

      test('빈 문자열은 false를 반환한다', () {
        expect(ValidationUtils.isValidUrl(''), isFalse);
      });
    });

    group('isValidPassword', () {
      test('8자 이상 대소문자와 숫자가 있으면 true를 반환한다', () {
        expect(ValidationUtils.isValidPassword('Password1'), isTrue);
        expect(ValidationUtils.isValidPassword('MyP4ssword'), isTrue);
      });

      test('7자는 false를 반환한다', () {
        expect(ValidationUtils.isValidPassword('Pass1Ab'), isFalse);
      });

      test('대문자가 없으면 false를 반환한다', () {
        expect(ValidationUtils.isValidPassword('password1'), isFalse);
      });

      test('소문자가 없으면 false를 반환한다', () {
        expect(ValidationUtils.isValidPassword('PASSWORD1'), isFalse);
      });

      test('숫자가 없으면 false를 반환한다', () {
        expect(ValidationUtils.isValidPassword('Password'), isFalse);
      });

      test('빈 문자열은 false를 반환한다', () {
        expect(ValidationUtils.isValidPassword(''), isFalse);
      });
    });
  });
}
