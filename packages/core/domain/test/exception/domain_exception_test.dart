import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('DomainException', () {
    group('기본 생성 및 메시지', () {
      test('메시지를 가진 DomainException을 생성할 수 있다', () {
        // Arrange & Act
        const DomainException exception =
            DomainException('Something went wrong');

        // Assert
        expect(exception.message, equals('Something went wrong'));
        expect(exception.cause, isNull);
        expect(exception.stackTrace, isNull);
      });

      test('DomainException은 Exception 인터페이스를 구현한다', () {
        // Arrange
        const DomainException exception = DomainException('Test');

        // Act & Assert
        expect(exception, isA<Exception>());
      });
    });

    group('toString() 포맷', () {
      test('cause가 없는 경우 기본 toString() 포맷을 반환한다', () {
        // Arrange
        const DomainException exception =
            DomainException('Test exception');

        // Act
        final String result = exception.toString();

        // Assert
        expect(result, equals('DomainException: Test exception'));
        expect(result, isNot(contains('Caused by')));
      });

      test('cause가 있는 경우 toString()에 "Caused by:"를 포함한다', () {
        // Arrange
        final Exception originalError = Exception('Original error');
        final DomainException exception = DomainException(
          'Wrapped exception',
          cause: originalError,
        );

        // Act
        final String result = exception.toString();

        // Assert
        expect(result, contains('DomainException: Wrapped exception'));
        expect(result, contains('Caused by:'));
        expect(result, contains('Original error'));
      });

      test('stackTrace가 있는 경우 toString()에 stackTrace를 포함한다', () {
        // Arrange
        final StackTrace trace = StackTrace.current;
        final DomainException exception = DomainException(
          'Exception with trace',
          stackTrace: trace,
        );

        // Act
        final String result = exception.toString();

        // Assert
        expect(result, contains('DomainException: Exception with trace'));
        expect(result, contains(trace.toString()));
      });

      test('cause와 stackTrace가 모두 있는 경우 둘 다 포함한다', () {
        // Arrange
        final Exception originalError = Exception('Root cause');
        final StackTrace trace = StackTrace.current;
        final DomainException exception = DomainException(
          'Complex exception',
          cause: originalError,
          stackTrace: trace,
        );

        // Act
        final String result = exception.toString();

        // Assert
        expect(result, contains('DomainException: Complex exception'));
        expect(result, contains('Caused by:'));
        expect(result, contains('Root cause'));
        expect(result, contains(trace.toString()));
      });
    });
  });

  group('ValidationException', () {
    group('기본 생성 및 필드', () {
      test('메시지만으로 ValidationException을 생성할 수 있다', () {
        // Arrange & Act
        const ValidationException exception =
            ValidationException('Validation failed');

        // Assert
        expect(exception.message, equals('Validation failed'));
        expect(exception.field, isNull);
        expect(exception.cause, isNull);
        expect(exception.stackTrace, isNull);
      });

      test('field 파라미터를 포함하여 생성할 수 있다', () {
        // Arrange & Act
        const ValidationException exception = ValidationException(
          'Invalid email format',
          field: 'email',
        );

        // Assert
        expect(exception.message, equals('Invalid email format'));
        expect(exception.field, equals('email'));
      });

      test('ValidationException은 DomainException을 상속한다', () {
        // Arrange
        const ValidationException exception =
            ValidationException('Test');

        // Act & Assert
        expect(exception, isA<DomainException>());
        expect(exception, isA<Exception>());
      });
    });

    group('toString() 포맷', () {
      test('field가 없는 경우 기본 포맷을 반환한다', () {
        // Arrange
        const ValidationException exception =
            ValidationException('Value is required');

        // Act
        final String result = exception.toString();

        // Assert
        expect(result, equals('ValidationException: Value is required'));
        expect(result, isNot(contains('field:')));
      });

      test('field가 있는 경우 "(field: xxx)" 포맷을 포함한다', () {
        // Arrange
        const ValidationException exception = ValidationException(
          'Must be a valid email',
          field: 'email',
        );

        // Act
        final String result = exception.toString();

        // Assert
        expect(
          result,
          equals('ValidationException (field: email): Must be a valid email'),
        );
      });

      test('cause가 있는 경우 "Caused by:"를 포함한다', () {
        // Arrange
        final Exception originalError = Exception('Parsing error');
        final ValidationException exception = ValidationException(
          'Invalid format',
          field: 'dateOfBirth',
          cause: originalError,
        );

        // Act
        final String result = exception.toString();

        // Assert
        expect(
          result,
          contains('ValidationException (field: dateOfBirth): Invalid format'),
        );
        expect(result, contains('Caused by:'));
        expect(result, contains('Parsing error'));
      });
    });
  });
}
