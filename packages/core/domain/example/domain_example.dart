// ignore_for_file: avoid_print, unreachable_from_main

import 'package:domain/domain.dart';

// Entity 예시
class User extends Entity<String> {
  final String name;
  final String email;

  const User({
    required String id,
    required this.name,
    required this.email,
  }) : super(id);

  @override
  List<Object?> get props => [id];
}

// ValueObject 예시
class Money extends ValueObject {
  final double amount;
  final String currency;

  const Money({
    required this.amount,
    required this.currency,
  });

  @override
  List<Object?> get props => [amount, currency];
}

// Repository 인터페이스 예시
abstract interface class UserRepository {
  Future<Result<Failure, User>> getUserById(String id);
  Future<Result<Failure, List<User>>> getAllUsers();
}

// Repository 구현 예시
class UserRepositoryImpl implements UserRepository {
  @override
  Future<Result<Failure, User>> getUserById(String id) async {
    try {
      if (id.isEmpty) {
        return const Error(ValidationFailure('ID cannot be empty'));
      }

      // API 호출 시뮬레이션
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // 찾을 수 없는 경우
      if (id == 'not-found') {
        return const Error(NotFoundFailure('User not found'));
      }

      final User user = User(
        id: id,
        name: 'User $id',
        email: 'user$id@example.com',
      );
      return Success(user);
    } catch (e, stackTrace) {
      return Error(
        UnknownFailure(
          'Failed to get user',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Result<Failure, List<User>>> getAllUsers() async {
    return const Success(<User>[]);
  }
}

// UseCase 예시
class GetUserByIdUseCase implements UseCase<Failure, User, String> {
  GetUserByIdUseCase(this.repository);
  final UserRepository repository;

  @override
  Future<Result<Failure, User>> call(String userId) async {
    if (userId.isEmpty) {
      return const Error(ValidationFailure('User ID cannot be empty'));
    }

    final Result<Failure, User> result = await repository.getUserById(userId);

    // 추가 비즈니스 로직
    return result.map((User user) {
      // 예: 사용자 데이터 변환
      return user;
    });
  }
}

void main() async {
  print('=== Domain Package Example ===\n');

  // 1. Entity 사용 예시
  print('1. Entity Example:');
  const User user1 = User(id: '1', name: 'Alice', email: 'alice@example.com');
  const User user2 = User(
    id: '1',
    name: 'Alice Updated',
    email: 'new@example.com',
  );
  print('user1 == user2: ${user1 == user2}'); // true (ID만 비교)
  print('');

  // 2. ValueObject 사용 예시
  print('2. ValueObject Example:');
  const Money money1 = Money(amount: 100.0, currency: 'USD');
  const Money money2 = Money(amount: 100.0, currency: 'USD');
  print('money1 == money2: ${money1 == money2}'); // true (모든 props 비교)
  print('');

  // 3. Result와 UseCase 사용 예시
  print('3. Result & UseCase Example:');
  final UserRepository repository = UserRepositoryImpl();
  final GetUserByIdUseCase useCase = GetUserByIdUseCase(repository);

  // 성공 케이스
  final Result<Failure, User> result = await useCase('123');
  switch (result) {
    case Success(:final value):
      print('Success: ${value.name} (${value.email})');
    case Error(:final failure):
      print('Error: ${failure.message}');
  }

  // 실패 케이스
  final Result<Failure, User> notFoundResult = await useCase('not-found');
  switch (notFoundResult) {
    case Success(:final value):
      print('Success: ${value.name}');
    case Error(:final failure):
      switch (failure) {
        case NetworkFailure(:final message):
          print('Network error: $message');
        case ValidationFailure(:final message, :final field):
          print('Validation error on $field: $message');
        case NotFoundFailure():
          print('User not found');
        case UnauthorizedFailure():
          print('Unauthorized');
        case ServerFailure():
          print('Server error');
        case UnknownFailure(:final error):
          print('Unknown error: $error');
      }
  }
  print('');

  // 4. Result 체이닝 예시
  print('4. Result Chaining Example:');
  final Result<Failure, User> chainResult = await useCase('123');
  final Result<Failure, String> nameResult =
      chainResult.map((User user) => user.name);
  print('User name: ${nameResult.valueOrNull}');
  print('');

  // 5. DomainException 예시
  print('5. DomainException Example:');
  try {
    throw const ValidationException(
      'Invalid email format',
      field: 'email',
    );
  } catch (e) {
    print('Caught exception: $e');
  }

  print('\n=== Example Complete ===');
}
