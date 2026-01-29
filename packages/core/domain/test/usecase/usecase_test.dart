import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('UseCase', () {
    test('UseCase 인터페이스를 구현할 수 있다', () {
      // Arrange & Act
      final TestUseCase useCase = TestUseCase();

      // Assert
      expect(useCase, isA<UseCase<Failure, String, int>>());
    });

    test('파라미터를 받아 Result를 반환한다', () async {
      // Arrange
      final TestUseCase useCase = TestUseCase();

      // Act
      final Result<Failure, String> result = await useCase.call(10);

      // Assert
      expect(result, isA<Result<Failure, String>>());
    });

    test('성공 시나리오에서 Success를 반환한다', () async {
      // Arrange
      final TestUseCase useCase = TestUseCase();

      // Act
      final Result<Failure, String> result = await useCase.call(42);

      // Assert
      expect(result, isA<Success<Failure, String>>());
      expect(result.valueOrNull, equals('Value: 42'));
    });

    test('실패 시나리오에서 Error를 반환한다', () async {
      // Arrange
      final TestUseCase useCase = TestUseCase();

      // Act
      final Result<Failure, String> result = await useCase.call(-1);

      // Assert
      expect(result, isA<Error<Failure, String>>());
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(result.failureOrNull?.message, contains('negative'));
    });

    test('파라미터 검증 로직이 동작한다', () async {
      // Arrange
      final TestUseCase useCase = TestUseCase();

      // Act
      final Result<Failure, String> zeroResult = await useCase.call(0);
      final Result<Failure, String> positiveResult = await useCase.call(5);

      // Assert
      expect(zeroResult, isA<Error<Failure, String>>());
      expect(positiveResult, isA<Success<Failure, String>>());
    });
  });

  group('NoParamsUseCase', () {
    test('NoParamsUseCase 인터페이스를 구현할 수 있다', () {
      // Arrange & Act
      final TestNoParamsUseCase useCase = TestNoParamsUseCase();

      // Assert
      expect(useCase, isA<NoParamsUseCase<Failure, String>>());
    });

    test('파라미터 없이 Result를 반환한다', () async {
      // Arrange
      final TestNoParamsUseCase useCase = TestNoParamsUseCase();

      // Act
      final Result<Failure, String> result = await useCase.call();

      // Assert
      expect(result, isA<Result<Failure, String>>());
    });

    test('Success를 반환한다', () async {
      // Arrange
      final TestNoParamsUseCase useCase = TestNoParamsUseCase();

      // Act
      final Result<Failure, String> result = await useCase.call();

      // Assert
      expect(result, isA<Success<Failure, String>>());
      expect(result.valueOrNull, equals('No params result'));
    });

    test('실패 시나리오를 처리할 수 있다', () async {
      // Arrange
      final TestNoParamsUseCaseWithError useCase =
          TestNoParamsUseCaseWithError();

      // Act
      final Result<Failure, String> result = await useCase.call();

      // Assert
      expect(result, isA<Error<Failure, String>>());
      expect(result.failureOrNull, isA<UnknownFailure>());
    });

    test('async 동작이 올바르게 처리된다', () async {
      // Arrange
      final TestAsyncNoParamsUseCase useCase = TestAsyncNoParamsUseCase();

      // Act
      final Result<Failure, String> result = await useCase.call();

      // Assert
      expect(result, isA<Success<Failure, String>>());
      expect(result.valueOrNull, contains('Async'));
    });
  });

  group('UseCase 통합 시나리오', () {
    test('여러 UseCase를 체이닝하여 사용할 수 있다', () async {
      // Arrange
      final TestUseCase useCase1 = TestUseCase();

      // Act
      final Result<Failure, String> result1 = await useCase1.call(10);
      final Result<Failure, int> result2 = result1.map(
        (String value) => value.length,
      );

      // Assert
      expect(result2.valueOrNull, equals(9)); // "Value: 10".length = 9
    });

    test('UseCase 결과를 flatMap으로 연결할 수 있다', () async {
      // Arrange
      final TestUseCase useCase = TestUseCase();

      // Act
      final Result<Failure, int> result = (await useCase.call(
        5,
      )).flatMap<int>((String value) => Success<Failure, int>(value.length));

      // Assert
      expect(result, isA<Success<Failure, int>>());
      expect(result.valueOrNull, equals(8)); // "Value: 5".length = 8
    });
  });
}

// Test implementations

/// 테스트용 UseCase 구현체
class TestUseCase implements UseCase<Failure, String, int> {
  @override
  Future<Result<Failure, String>> call(int params) async {
    // 파라미터 검증
    if (params < 0) {
      return const Error<Failure, String>(
        ValidationFailure('Value cannot be negative'),
      );
    }
    if (params == 0) {
      return const Error<Failure, String>(
        ValidationFailure('Value cannot be zero'),
      );
    }

    // 비즈니스 로직 수행
    await Future<void>.delayed(const Duration(milliseconds: 10));
    return Success<Failure, String>('Value: $params');
  }
}

/// 테스트용 NoParamsUseCase 구현체 (성공)
class TestNoParamsUseCase implements NoParamsUseCase<Failure, String> {
  @override
  Future<Result<Failure, String>> call() async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    return const Success<Failure, String>('No params result');
  }
}

/// 테스트용 NoParamsUseCase 구현체 (실패)
class TestNoParamsUseCaseWithError implements NoParamsUseCase<Failure, String> {
  @override
  Future<Result<Failure, String>> call() async {
    return const Error<Failure, String>(UnknownFailure('Something went wrong'));
  }
}

/// 테스트용 비동기 NoParamsUseCase
class TestAsyncNoParamsUseCase implements NoParamsUseCase<Failure, String> {
  @override
  Future<Result<Failure, String>> call() async {
    // 비동기 작업 시뮬레이션
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return const Success<Failure, String>('Async operation completed');
  }
}
