import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('ValueObject', () {
    group('Equatable 동등성', () {
      test('같은 값을 가진 ValueObject는 동등하다', () {
        // Arrange
        const TestMoney money1 =
            TestMoney(amount: 100, currency: 'USD');
        const TestMoney money2 =
            TestMoney(amount: 100, currency: 'USD');

        // Act & Assert
        expect(money1, equals(money2));
        expect(money1 == money2, isTrue);
      });

      test('다른 값을 가진 ValueObject는 동등하지 않다', () {
        // Arrange
        const TestMoney money1 =
            TestMoney(amount: 100, currency: 'USD');
        const TestMoney money2 =
            TestMoney(amount: 200, currency: 'USD');

        // Act & Assert
        expect(money1, isNot(equals(money2)));
        expect(money1 == money2, isFalse);
      });

      test('하나의 필드라도 다르면 동등하지 않다', () {
        // Arrange
        const TestMoney money1 =
            TestMoney(amount: 100, currency: 'USD');
        const TestMoney money2 =
            TestMoney(amount: 100, currency: 'EUR');

        // Act & Assert
        expect(money1, isNot(equals(money2)));
        expect(money1 == money2, isFalse);
      });
    });

    group('hashCode 일관성', () {
      test('같은 값을 가진 ValueObject는 같은 hashCode를 반환한다', () {
        // Arrange
        const TestMoney money1 =
            TestMoney(amount: 100, currency: 'USD');
        const TestMoney money2 =
            TestMoney(amount: 100, currency: 'USD');

        // Act & Assert
        expect(money1.hashCode, equals(money2.hashCode));
      });

      test('다른 값을 가진 ValueObject는 다른 hashCode를 반환한다', () {
        // Arrange
        const TestMoney money1 =
            TestMoney(amount: 100, currency: 'USD');
        const TestMoney money2 =
            TestMoney(amount: 200, currency: 'USD');

        // Act & Assert
        expect(money1.hashCode, isNot(equals(money2.hashCode)));
      });
    });

    group('stringify 기능', () {
      test('toString()은 타입명과 필드 정보를 포함한다', () {
        // Arrange
        const TestMoney money = TestMoney(amount: 100, currency: 'USD');

        // Act
        final String result = money.toString();

        // Assert
        expect(result, contains('TestMoney'));
        expect(result, contains('100.0'));
        expect(result, contains('USD'));
      });
    });

    group('다양한 필드 조합', () {
      test('여러 필드를 가진 ValueObject도 올바르게 동작한다', () {
        // Arrange
        const TestEmail email1 = TestEmail(
          localPart: 'user',
          domain: 'example.com',
          isVerified: true,
        );
        const TestEmail email2 = TestEmail(
          localPart: 'user',
          domain: 'example.com',
          isVerified: true,
        );
        const TestEmail email3 = TestEmail(
          localPart: 'user',
          domain: 'example.com',
          isVerified: false,
        );

        // Act & Assert
        expect(email1, equals(email2));
        expect(email1, isNot(equals(email3)));
      });
    });
  });
}

// Test implementations

/// 테스트용 Money ValueObject
class TestMoney extends ValueObject {
  /// TestMoney 생성자
  const TestMoney({
    required this.amount,
    required this.currency,
  });

  /// 금액
  final double amount;

  /// 통화 코드
  final String currency;

  @override
  List<Object?> get props => <Object?>[amount, currency];
}

/// 테스트용 Email ValueObject
class TestEmail extends ValueObject {
  /// TestEmail 생성자
  const TestEmail({
    required this.localPart,
    required this.domain,
    required this.isVerified,
  });

  /// 이메일 로컬 파트 (@ 앞부분)
  final String localPart;

  /// 이메일 도메인 (@ 뒷부분)
  final String domain;

  /// 이메일 인증 여부
  final bool isVerified;

  @override
  List<Object?> get props => <Object?>[localPart, domain, isVerified];
}
