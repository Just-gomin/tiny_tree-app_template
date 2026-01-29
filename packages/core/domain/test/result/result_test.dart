import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Result', () {
    group('Success', () {
      test('isSuccess는 true를 반환한다', () {
        const Result<Failure, int> result = Success<Failure, int>(42);

        expect(result.isSuccess, isTrue);
        expect(result.isError, isFalse);
      });

      test('valueOrNull은 값을 반환한다', () {
        const Result<Failure, int> result = Success<Failure, int>(42);

        expect(result.valueOrNull, equals(42));
      });

      test('map은 값을 변환한다', () {
        const Result<Failure, int> result = Success<Failure, int>(42);
        final Result<Failure, String> mapped = result.map(
          (int value) => value.toString(),
        );

        expect(mapped, isA<Success<Failure, String>>());
        expect(mapped.valueOrNull, equals('42'));
      });

      test('fold는 onSuccess를 호출한다', () {
        const Result<Failure, int> result = Success<Failure, int>(42);
        final String folded = result.fold(
          onSuccess: (int value) => 'Success: $value',
          onError: (Failure failure) => 'Error: ${failure.message}',
        );

        expect(folded, equals('Success: 42'));
      });
    });

    group('Error', () {
      test('isError는 true를 반환한다', () {
        const Result<Failure, int> result = Error<Failure, int>(
          UnknownFailure('test error'),
        );

        expect(result.isError, isTrue);
        expect(result.isSuccess, isFalse);
      });

      test('failureOrNull은 실패를 반환한다', () {
        const Failure failure = UnknownFailure('test error');
        const Result<Failure, int> result = Error<Failure, int>(failure);

        expect(result.failureOrNull, equals(failure));
      });

      test('map은 에러를 그대로 반환한다', () {
        const Result<Failure, int> result = Error<Failure, int>(
          UnknownFailure('test error'),
        );
        final Result<Failure, String> mapped = result.map(
          (int value) => value.toString(),
        );

        expect(mapped, isA<Error<Failure, String>>());
      });

      test('getOrElse는 기본값을 반환한다', () {
        const Result<Failure, int> result = Error<Failure, int>(
          UnknownFailure('test error'),
        );
        final int value = result.getOrElse(0);

        expect(value, equals(0));
      });
    });

    group('Pattern Matching', () {
      test('switch로 exhaustive checking이 가능하다', () {
        Result<Failure, int> getResult({required bool success}) {
          if (success) {
            return const Success<Failure, int>(42);
          } else {
            return const Error<Failure, int>(UnknownFailure('error'));
          }
        }

        final Result<Failure, int> successResult = getResult(success: true);
        final String successMessage = switch (successResult) {
          Success<Failure, int>(:final int value) => 'Got: $value',
          Error<Failure, int>(:final Failure failure) =>
            'Failed: ${failure.message}',
        };
        expect(successMessage, equals('Got: 42'));

        final Result<Failure, int> errorResult = getResult(success: false);
        final String errorMessage = switch (errorResult) {
          Success<Failure, int>(:final int value) => 'Got: $value',
          Error<Failure, int>(:final Failure failure) =>
            'Failed: ${failure.message}',
        };
        expect(errorMessage, equals('Failed: error'));
      });
    });

    group('flatMap (Monad)', () {
      test('Success를 다른 Success로 체이닝할 수 있다', () {
        // Arrange
        const Result<Failure, int> initial = Success<Failure, int>(10);

        // Act
        final Result<Failure, String> result = initial.flatMap<String>(
          (int value) => Success<Failure, String>('Value: $value'),
        );

        // Assert
        expect(result, isA<Success<Failure, String>>());
        expect(result.valueOrNull, equals('Value: 10'));
      });

      test('Success를 Error로 체이닝할 수 있다', () {
        // Arrange
        const Result<Failure, int> initial = Success<Failure, int>(10);

        // Act
        final Result<Failure, String> result = initial.flatMap<String>(
          (int value) => const Error<Failure, String>(
            ValidationFailure('Value too large'),
          ),
        );

        // Assert
        expect(result, isA<Error<Failure, String>>());
        expect(result.failureOrNull, isA<ValidationFailure>());
      });

      test('Error를 flatMap하면 Error가 전파된다', () {
        // Arrange
        const Result<Failure, int> initial = Error<Failure, int>(
          NetworkFailure('Connection lost'),
        );

        // Act
        final Result<Failure, String> result = initial.flatMap<String>(
          (int value) => Success<Failure, String>('Value: $value'),
        );

        // Assert
        expect(result, isA<Error<Failure, String>>());
        expect(result.failureOrNull, isA<NetworkFailure>());
      });

      test('여러 번 체이닝할 수 있다', () {
        // Arrange
        const Result<Failure, int> initial = Success<Failure, int>(5);

        // Act
        final Result<Failure, String> result = initial
            .flatMap<int>((int value) => Success<Failure, int>(value * 2))
            .flatMap<int>((int value) => Success<Failure, int>(value + 3))
            .flatMap<String>(
              (int value) => Success<Failure, String>('Result: $value'),
            );

        // Assert
        expect(result.valueOrNull, equals('Result: 13'));
      });
    });

    group('mapError', () {
      test('Error의 실패 타입을 변환할 수 있다', () {
        // Arrange
        const Result<NetworkFailure, int> initial = Error<NetworkFailure, int>(
          NetworkFailure('Connection timeout'),
        );

        // Act
        final Result<UnknownFailure, int> result = initial
            .mapError<UnknownFailure>(
              (NetworkFailure failure) =>
                  UnknownFailure('Wrapped: ${failure.message}'),
            );

        // Assert
        expect(result, isA<Error<UnknownFailure, int>>());
        expect(result.failureOrNull?.message, contains('Wrapped'));
      });

      test('Success를 mapError하면 그대로 반환된다', () {
        // Arrange
        const Result<NetworkFailure, int> initial =
            Success<NetworkFailure, int>(42);

        // Act
        final Result<UnknownFailure, int> result = initial
            .mapError<UnknownFailure>(
              (NetworkFailure failure) =>
                  UnknownFailure('Wrapped: ${failure.message}'),
            );

        // Assert
        expect(result, isA<Success<UnknownFailure, int>>());
        expect(result.valueOrNull, equals(42));
      });
    });

    group('getOrElseLazy', () {
      test('Success일 때는 값을 반환하고 함수를 호출하지 않는다', () {
        // Arrange
        const Result<Failure, int> result = Success<Failure, int>(42);
        bool called = false;

        // Act
        final int value = result.getOrElseLazy((Failure failure) {
          called = true;
          return 0;
        });

        // Assert
        expect(value, equals(42));
        expect(called, isFalse);
      });

      test('Error일 때는 함수를 호출하여 값을 생성한다', () {
        // Arrange
        const Result<Failure, int> result = Error<Failure, int>(
          ValidationFailure('Invalid input'),
        );
        bool called = false;

        // Act
        final int value = result.getOrElseLazy((Failure failure) {
          called = true;
          return -1;
        });

        // Assert
        expect(value, equals(-1));
        expect(called, isTrue);
      });

      test('Error일 때 failure 정보를 사용하여 값을 생성할 수 있다', () {
        // Arrange
        const Result<Failure, String> result = Error<Failure, String>(
          NotFoundFailure('Resource not found', resourceId: 'user-123'),
        );

        // Act
        final String value = result.getOrElseLazy(
          (Failure failure) => 'Default for: ${failure.message}',
        );

        // Assert
        expect(value, equals('Default for: Resource not found'));
      });
    });

    group('Equatable 동등성', () {
      test('같은 값을 가진 Success는 동등하다', () {
        // Arrange
        const Result<Failure, int> result1 = Success<Failure, int>(42);
        const Result<Failure, int> result2 = Success<Failure, int>(42);

        // Act & Assert
        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });

      test('다른 값을 가진 Success는 동등하지 않다', () {
        // Arrange
        const Result<Failure, int> result1 = Success<Failure, int>(42);
        const Result<Failure, int> result2 = Success<Failure, int>(43);

        // Act & Assert
        expect(result1, isNot(equals(result2)));
      });

      test('같은 실패를 가진 Error는 동등하다', () {
        // Arrange
        const Result<Failure, int> result1 = Error<Failure, int>(
          NetworkFailure('Connection failed'),
        );
        const Result<Failure, int> result2 = Error<Failure, int>(
          NetworkFailure('Connection failed'),
        );

        // Act & Assert
        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });

      test('다른 실패를 가진 Error는 동등하지 않다', () {
        // Arrange
        const Result<Failure, int> result1 = Error<Failure, int>(
          NetworkFailure('Connection failed'),
        );
        const Result<Failure, int> result2 = Error<Failure, int>(
          ValidationFailure('Invalid input'),
        );

        // Act & Assert
        expect(result1, isNot(equals(result2)));
      });
    });

    group('map과 flatMap 조합', () {
      test('map과 flatMap을 함께 사용할 수 있다', () {
        // Arrange
        const Result<Failure, int> initial = Success<Failure, int>(10);

        // Act
        final Result<Failure, String> result = initial
            .map<int>((int value) => value * 2) // Success(20)
            .flatMap<int>(
              (int value) => Success<Failure, int>(value + 5),
            ) // Success(25)
            .map<String>(
              (int value) => 'Final: $value',
            ); // Success('Final: 25')

        // Assert
        expect(result.valueOrNull, equals('Final: 25'));
      });

      test('중간에 Error가 발생하면 나머지는 실행되지 않는다', () {
        // Arrange
        const Result<Failure, int> initial = Success<Failure, int>(10);

        // Act
        final Result<Failure, String> result = initial
            .map<int>((int value) => value * 2) // Success(20)
            .flatMap<int>(
              (int value) =>
                  const Error<Failure, int>(ValidationFailure('Too large')),
            ) // Error
            .map<String>((int value) => 'Final: $value'); // Error 전파

        // Assert
        expect(result, isA<Error<Failure, String>>());
        expect(result.failureOrNull, isA<ValidationFailure>());
      });
    });
  });
}
