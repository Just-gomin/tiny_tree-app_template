import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Result', () {
    group('Success', () {
      test('isSuccess는 true를 반환한다', () {
        const Result<Failure, int> result = Success(42);

        expect(result.isSuccess, isTrue);
        expect(result.isError, isFalse);
      });

      test('valueOrNull은 값을 반환한다', () {
        const Result<Failure, int> result = Success(42);

        expect(result.valueOrNull, equals(42));
      });

      test('map은 값을 변환한다', () {
        const Result<Failure, int> result = Success(42);
        final Result<Failure, String> mapped = result.map((int value) => value.toString());

        expect(mapped, isA<Success<Failure, String>>());
        expect(mapped.valueOrNull, equals('42'));
      });

      test('fold는 onSuccess를 호출한다', () {
        const Result<Failure, int> result = Success(42);
        final String folded = result.fold(
          onSuccess: (int value) => 'Success: $value',
          onError: (Failure failure) => 'Error: ${failure.message}',
        );

        expect(folded, equals('Success: 42'));
      });
    });

    group('Error', () {
      test('isError는 true를 반환한다', () {
        const Result<Failure, int> result = Error(UnknownFailure('test error'));

        expect(result.isError, isTrue);
        expect(result.isSuccess, isFalse);
      });

      test('failureOrNull은 실패를 반환한다', () {
        const Failure failure = UnknownFailure('test error');
        const Result<Failure, int> result = Error(failure);

        expect(result.failureOrNull, equals(failure));
      });

      test('map은 에러를 그대로 반환한다', () {
        const Result<Failure, int> result = Error(UnknownFailure('test error'));
        final Result<Failure, String> mapped = result.map((int value) => value.toString());

        expect(mapped, isA<Error<Failure, String>>());
      });

      test('getOrElse는 기본값을 반환한다', () {
        const Result<Failure, int> result = Error(UnknownFailure('test error'));
        final int value = result.getOrElse(0);

        expect(value, equals(0));
      });
    });

    group('Pattern Matching', () {
      test('switch로 exhaustive checking이 가능하다', () {
        Result<Failure, int> getResult(bool success) {
          if (success) {
            return const Success(42);
          } else {
            return const Error(UnknownFailure('error'));
          }
        }

        final Result<Failure, int> successResult = getResult(true);
        final String successMessage = switch (successResult) {
          Success(:final value) => 'Got: $value',
          Error(:final failure) => 'Failed: ${failure.message}',
        };
        expect(successMessage, equals('Got: 42'));

        final Result<Failure, int> errorResult = getResult(false);
        final String errorMessage = switch (errorResult) {
          Success(:final value) => 'Got: $value',
          Error(:final failure) => 'Failed: ${failure.message}',
        };
        expect(errorMessage, equals('Failed: error'));
      });
    });
  });
}
