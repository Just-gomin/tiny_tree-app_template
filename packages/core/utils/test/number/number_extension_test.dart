import 'package:test/test.dart';
import 'package:utils/utils.dart';

void main() {
  group('NumExtension', () {
    group('roundTo', () {
      test('2자리로 반올림한다', () {
        expect(3.14159.roundTo(2), closeTo(3.14, 0.001));
      });

      test('0자리로 반올림한다', () {
        expect(3.7.roundTo(0), closeTo(4.0, 0.001));
      });

      test('1자리로 반올림한다', () {
        expect(1234.56.roundTo(1), closeTo(1234.6, 0.001));
      });

      test('정수에도 적용된다', () {
        expect(42.roundTo(2), closeTo(42.0, 0.001));
      });

      test('음수 decimals는 ArgumentError를 던진다', () {
        expect(() => 3.14.roundTo(-1), throwsArgumentError);
      });
    });

    group('toPercentage', () {
      test('0.75는 75%를 반환한다', () {
        expect(0.75.toPercentage(), equals('75%'));
      });

      test('1.0은 100%를 반환한다', () {
        expect(1.0.toPercentage(), equals('100%'));
      });

      test('0.0은 0%를 반환한다', () {
        expect(0.0.toPercentage(), equals('0%'));
      });

      test('소수점 포함 퍼센트를 반환한다', () {
        expect(0.1234.toPercentage(decimals: 1), equals('12.3%'));
      });
    });

    group('formatCurrency', () {
      test('기본 한국 통화 형식으로 포맷한다', () {
        expect(1234567.formatCurrency(), equals('₩1,234,567'));
      });

      test('소수점이 없는 정수를 포맷한다', () {
        expect(1000.formatCurrency(), equals('₩1,000'));
      });
    });

    group('withThousandsSeparator', () {
      test('천 단위 구분 기호를 추가한다', () {
        expect(1234567.withThousandsSeparator(), equals('1,234,567'));
      });

      test('1000 미만의 숫자는 구분 기호 없이 반환한다', () {
        expect(999.withThousandsSeparator(), equals('999'));
      });
    });

    group('isBetween', () {
      test('범위 내의 값은 true를 반환한다', () {
        expect(5.isBetween(1, 10), isTrue);
      });

      test('하한 경계값은 true를 반환한다', () {
        expect(1.isBetween(1, 10), isTrue);
      });

      test('상한 경계값은 true를 반환한다', () {
        expect(10.isBetween(1, 10), isTrue);
      });

      test('범위 아래의 값은 false를 반환한다', () {
        expect(0.isBetween(1, 10), isFalse);
      });

      test('범위 위의 값은 false를 반환한다', () {
        expect(11.isBetween(1, 10), isFalse);
      });

      test('double 값에도 적용된다', () {
        expect(5.5.isBetween(1.0, 10.0), isTrue);
      });
    });
  });
}
