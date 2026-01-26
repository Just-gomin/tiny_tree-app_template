import '../failure/failure.dart';
import '../result/result.dart';

/// 유스케이스(Use Case)의 기본 인터페이스.
///
/// 각 유스케이스는 하나의 비즈니스 작업을 수행합니다.
/// Clean Architecture의 Use Case 레이어를 나타냅니다.
///
/// 예시:
/// ```dart
/// class GetUserByIdUseCase implements UseCase<Failure, User, String> {
///   final UserRepository repository;
///
///   GetUserByIdUseCase(this.repository);
///
///   @override
///   Future<Result<Failure, User>> call(String userId) async {
///     if (userId.isEmpty) {
///       return Error(ValidationFailure('User ID cannot be empty'));
///     }
///     return repository.getUserById(userId);
///   }
/// }
///
/// // 사용
/// final result = await getUserByIdUseCase('123');
/// ```
///
/// 타입 파라미터:
/// - [F]: 실패 타입 (일반적으로 [Failure]의 하위 타입)
/// - [S]: 성공 값의 타입
/// - [P]: 파라미터 타입
abstract interface class UseCase<F extends Failure, S, P> {
  /// 유스케이스를 실행합니다.
  ///
  /// [params]를 받아 비즈니스 로직을 수행하고 [Result]를 반환합니다.
  Future<Result<F, S>> call(P params);
}

/// 파라미터가 없는 유스케이스.
///
/// 예시:
/// ```dart
/// class GetCurrentUserUseCase implements NoParamsUseCase<Failure, User> {
///   final UserRepository repository;
///
///   GetCurrentUserUseCase(this.repository);
///
///   @override
///   Future<Result<Failure, User>> call() async {
///     return repository.getCurrentUser();
///   }
/// }
/// ```
///
/// 타입 파라미터:
/// - [F]: 실패 타입 (일반적으로 [Failure]의 하위 타입)
/// - [S]: 성공 값의 타입
abstract interface class NoParamsUseCase<F extends Failure, S> {
  /// 유스케이스를 실행합니다.
  Future<Result<F, S>> call();
}
