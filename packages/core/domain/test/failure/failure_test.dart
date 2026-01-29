import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Failure', () {
    group('기본 특성', () {
      test('Failure는 Equatable을 확장한다', () {
        // Arrange
        const NetworkFailure failure = NetworkFailure('Test');

        // Act & Assert
        expect(failure, isA<Equatable>());
      });

      test('같은 메시지를 가진 같은 타입의 Failure는 동등하다', () {
        // Arrange
        const NetworkFailure failure1 = NetworkFailure('Network error');
        const NetworkFailure failure2 = NetworkFailure('Network error');

        // Act & Assert
        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('다른 메시지를 가진 Failure는 동등하지 않다', () {
        // Arrange
        const NetworkFailure failure1 = NetworkFailure('Error 1');
        const NetworkFailure failure2 = NetworkFailure('Error 2');

        // Act & Assert
        expect(failure1, isNot(equals(failure2)));
      });

      test('stringify가 활성화되어 있다', () {
        // Arrange
        const NetworkFailure failure = NetworkFailure('Test error');

        // Act
        final String result = failure.toString();

        // Assert
        expect(result, contains('NetworkFailure'));
        expect(result, contains('Test error'));
      });
    });
  });

  group('NetworkFailure', () {
    test('statusCode 없이 생성할 수 있다', () {
      // Arrange & Act
      const NetworkFailure failure = NetworkFailure('Connection timeout');

      // Assert
      expect(failure.message, equals('Connection timeout'));
      expect(failure.statusCode, isNull);
    });

    test('statusCode와 함께 생성할 수 있다', () {
      // Arrange & Act
      const NetworkFailure failure =
          NetworkFailure('HTTP error', statusCode: 404);

      // Assert
      expect(failure.message, equals('HTTP error'));
      expect(failure.statusCode, equals(404));
    });

    test('statusCode가 다르면 동등하지 않다', () {
      // Arrange
      const NetworkFailure failure1 =
          NetworkFailure('Error', statusCode: 404);
      const NetworkFailure failure2 =
          NetworkFailure('Error', statusCode: 500);

      // Act & Assert
      expect(failure1, isNot(equals(failure2)));
    });

    test('같은 statusCode를 가지면 동등하다', () {
      // Arrange
      const NetworkFailure failure1 =
          NetworkFailure('Error', statusCode: 404);
      const NetworkFailure failure2 =
          NetworkFailure('Error', statusCode: 404);

      // Act & Assert
      expect(failure1, equals(failure2));
    });
  });

  group('ValidationFailure', () {
    test('field 없이 생성할 수 있다', () {
      // Arrange & Act
      const ValidationFailure failure =
          ValidationFailure('Validation failed');

      // Assert
      expect(failure.message, equals('Validation failed'));
      expect(failure.field, isNull);
    });

    test('field와 함께 생성할 수 있다', () {
      // Arrange & Act
      const ValidationFailure failure =
          ValidationFailure('Invalid format', field: 'email');

      // Assert
      expect(failure.message, equals('Invalid format'));
      expect(failure.field, equals('email'));
    });

    test('field가 다르면 동등하지 않다', () {
      // Arrange
      const ValidationFailure failure1 =
          ValidationFailure('Error', field: 'email');
      const ValidationFailure failure2 =
          ValidationFailure('Error', field: 'password');

      // Act & Assert
      expect(failure1, isNot(equals(failure2)));
    });

    test('같은 field를 가지면 동등하다', () {
      // Arrange
      const ValidationFailure failure1 =
          ValidationFailure('Error', field: 'email');
      const ValidationFailure failure2 =
          ValidationFailure('Error', field: 'email');

      // Act & Assert
      expect(failure1, equals(failure2));
    });
  });

  group('NotFoundFailure', () {
    test('resourceId 없이 생성할 수 있다', () {
      // Arrange & Act
      const NotFoundFailure failure = NotFoundFailure('Resource not found');

      // Assert
      expect(failure.message, equals('Resource not found'));
      expect(failure.resourceId, isNull);
    });

    test('resourceId와 함께 생성할 수 있다', () {
      // Arrange & Act
      const NotFoundFailure failure =
          NotFoundFailure('User not found', resourceId: 'user-123');

      // Assert
      expect(failure.message, equals('User not found'));
      expect(failure.resourceId, equals('user-123'));
    });

    test('resourceId가 다르면 동등하지 않다', () {
      // Arrange
      const NotFoundFailure failure1 =
          NotFoundFailure('Error', resourceId: 'id-1');
      const NotFoundFailure failure2 =
          NotFoundFailure('Error', resourceId: 'id-2');

      // Act & Assert
      expect(failure1, isNot(equals(failure2)));
    });

    test('같은 resourceId를 가지면 동등하다', () {
      // Arrange
      const NotFoundFailure failure1 =
          NotFoundFailure('Error', resourceId: 'id-1');
      const NotFoundFailure failure2 =
          NotFoundFailure('Error', resourceId: 'id-1');

      // Act & Assert
      expect(failure1, equals(failure2));
    });
  });

  group('UnauthorizedFailure', () {
    test('메시지로 생성할 수 있다', () {
      // Arrange & Act
      const UnauthorizedFailure failure =
          UnauthorizedFailure('Authentication required');

      // Assert
      expect(failure.message, equals('Authentication required'));
    });

    test('같은 메시지를 가지면 동등하다', () {
      // Arrange
      const UnauthorizedFailure failure1 = UnauthorizedFailure('Unauthorized');
      const UnauthorizedFailure failure2 = UnauthorizedFailure('Unauthorized');

      // Act & Assert
      expect(failure1, equals(failure2));
    });

    test('다른 메시지를 가지면 동등하지 않다', () {
      // Arrange
      const UnauthorizedFailure failure1 =
          UnauthorizedFailure('Token expired');
      const UnauthorizedFailure failure2 =
          UnauthorizedFailure('Invalid token');

      // Act & Assert
      expect(failure1, isNot(equals(failure2)));
    });
  });

  group('ServerFailure', () {
    test('errorCode 없이 생성할 수 있다', () {
      // Arrange & Act
      const ServerFailure failure = ServerFailure('Internal server error');

      // Assert
      expect(failure.message, equals('Internal server error'));
      expect(failure.errorCode, isNull);
    });

    test('errorCode와 함께 생성할 수 있다', () {
      // Arrange & Act
      const ServerFailure failure =
          ServerFailure('Database error', errorCode: 'DB_001');

      // Assert
      expect(failure.message, equals('Database error'));
      expect(failure.errorCode, equals('DB_001'));
    });

    test('errorCode가 다르면 동등하지 않다', () {
      // Arrange
      const ServerFailure failure1 =
          ServerFailure('Error', errorCode: 'ERR_001');
      const ServerFailure failure2 =
          ServerFailure('Error', errorCode: 'ERR_002');

      // Act & Assert
      expect(failure1, isNot(equals(failure2)));
    });

    test('같은 errorCode를 가지면 동등하다', () {
      // Arrange
      const ServerFailure failure1 =
          ServerFailure('Error', errorCode: 'ERR_001');
      const ServerFailure failure2 =
          ServerFailure('Error', errorCode: 'ERR_001');

      // Act & Assert
      expect(failure1, equals(failure2));
    });
  });

  group('UnknownFailure', () {
    test('error와 stackTrace 없이 생성할 수 있다', () {
      // Arrange & Act
      const UnknownFailure failure = UnknownFailure('Unknown error');

      // Assert
      expect(failure.message, equals('Unknown error'));
      expect(failure.error, isNull);
      expect(failure.stackTrace, isNull);
    });

    test('error만 포함하여 생성할 수 있다', () {
      // Arrange
      final Exception originalError = Exception('Original');

      // Act
      final UnknownFailure failure =
          UnknownFailure('Wrapped error', error: originalError);

      // Assert
      expect(failure.message, equals('Wrapped error'));
      expect(failure.error, equals(originalError));
      expect(failure.stackTrace, isNull);
    });

    test('stackTrace만 포함하여 생성할 수 있다', () {
      // Arrange
      final StackTrace trace = StackTrace.current;

      // Act
      final UnknownFailure failure =
          UnknownFailure('Error with trace', stackTrace: trace);

      // Assert
      expect(failure.message, equals('Error with trace'));
      expect(failure.error, isNull);
      expect(failure.stackTrace, equals(trace));
    });

    test('error와 stackTrace 모두 포함하여 생성할 수 있다', () {
      // Arrange
      final Exception originalError = Exception('Original');
      final StackTrace trace = StackTrace.current;

      // Act
      final UnknownFailure failure = UnknownFailure(
        'Complete error',
        error: originalError,
        stackTrace: trace,
      );

      // Assert
      expect(failure.message, equals('Complete error'));
      expect(failure.error, equals(originalError));
      expect(failure.stackTrace, equals(trace));
    });

    test('error가 다르면 동등하지 않다', () {
      // Arrange
      final Exception error1 = Exception('Error 1');
      final Exception error2 = Exception('Error 2');
      final UnknownFailure failure1 =
          UnknownFailure('Error', error: error1);
      final UnknownFailure failure2 =
          UnknownFailure('Error', error: error2);

      // Act & Assert
      expect(failure1, isNot(equals(failure2)));
    });
  });

  group('Sealed class pattern matching', () {
    test('switch 문으로 모든 Failure 타입을 처리할 수 있다', () {
      // Arrange
      const List<Failure> failures = <Failure>[
        NetworkFailure('Network'),
        ValidationFailure('Validation'),
        NotFoundFailure('NotFound'),
        UnauthorizedFailure('Unauthorized'),
        ServerFailure('Server'),
        UnknownFailure('Unknown'),
      ];

      // Act & Assert
      for (final Failure failure in failures) {
        final String result = _handleFailure(failure);
        expect(result, isNotEmpty);
        expect(result, isA<String>());
      }
    });

    test('NetworkFailure를 정확히 식별할 수 있다', () {
      // Arrange
      const NetworkFailure failure =
          NetworkFailure('Network error', statusCode: 404);

      // Act
      final String result = _handleFailure(failure);

      // Assert
      expect(result, equals('network:Network error:404'));
    });

    test('ValidationFailure를 정확히 식별할 수 있다', () {
      // Arrange
      const ValidationFailure failure =
          ValidationFailure('Invalid', field: 'email');

      // Act
      final String result = _handleFailure(failure);

      // Assert
      expect(result, equals('validation:Invalid:email'));
    });

    test('모든 Failure 타입이 exhaustive하게 처리된다', () {
      // Arrange
      const Failure networkFailure = NetworkFailure('Test');
      const Failure validationFailure = ValidationFailure('Test');
      const Failure notFoundFailure = NotFoundFailure('Test');
      const Failure unauthorizedFailure = UnauthorizedFailure('Test');
      const Failure serverFailure = ServerFailure('Test');
      const Failure unknownFailure = UnknownFailure('Test');

      // Act & Assert - 컴파일이 성공하면 exhaustive checking이 동작함
      expect(_handleFailure(networkFailure), contains('network'));
      expect(_handleFailure(validationFailure), contains('validation'));
      expect(_handleFailure(notFoundFailure), contains('notfound'));
      expect(_handleFailure(unauthorizedFailure), contains('unauthorized'));
      expect(_handleFailure(serverFailure), contains('server'));
      expect(_handleFailure(unknownFailure), contains('unknown'));
    });
  });
}

// Helper function for testing sealed class pattern matching
String _handleFailure(Failure failure) {
  return switch (failure) {
    NetworkFailure(:final String message, :final int? statusCode) =>
      'network:$message:$statusCode',
    ValidationFailure(:final String message, :final String? field) =>
      'validation:$message:$field',
    NotFoundFailure(:final String message, :final String? resourceId) =>
      'notfound:$message:$resourceId',
    UnauthorizedFailure(:final String message) => 'unauthorized:$message',
    ServerFailure(:final String message, :final String? errorCode) =>
      'server:$message:$errorCode',
    UnknownFailure(:final String message) => 'unknown:$message',
  };
}
