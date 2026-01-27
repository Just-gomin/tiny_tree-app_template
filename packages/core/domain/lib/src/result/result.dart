import 'package:equatable/equatable.dart';

import '../failure/failure.dart';

/// 성공 또는 실패를 나타내는 타입 안전한 결과 래퍼.
///
/// Result는 sealed 클래스이므로 [Success] 또는 [Error] 중 하나입니다.
/// 예외를 던지는 대신 Result를 반환하여 타입 안전한 에러 핸들링을 구현합니다.
///
/// 예시:
/// ```dart
/// Result<Failure, User> getUser(String id) {
///   if (id.isEmpty) {
///     return Error(ValidationFailure('ID cannot be empty'));
///   }
///   try {
///     final user = database.findUser(id);
///     return Success(user);
///   } catch (e) {
///     return Error(UnknownFailure('Failed to get user', error: e));
///   }
/// }
///
/// // 사용
/// final result = getUser('123');
/// switch (result) {
///   case Success(:final value):
///     print('User: ${value.name}');
///   case Error(:final failure):
///     print('Error: ${failure.message}');
/// }
/// ```
///
/// 타입 파라미터:
/// - [F]: 실패 타입 (일반적으로 [Failure]의 하위 타입)
/// - [S]: 성공 값의 타입
sealed class Result<F extends Failure, S> extends Equatable {
  /// Result를 생성합니다.
  const Result();

  /// Result가 성공인지 확인합니다.
  bool get isSuccess => this is Success<F, S>;

  /// Result가 실패인지 확인합니다.
  bool get isError => this is Error<F, S>;

  /// 성공 값을 가져옵니다. 실패인 경우 null을 반환합니다.
  S? get valueOrNull => switch (this) {
    Success<F, S>(:final S value) => value,
    Error<F, S>() => null,
  };

  /// 실패 값을 가져옵니다. 성공인 경우 null을 반환합니다.
  F? get failureOrNull => switch (this) {
    Success<F, S>() => null,
    Error<F, S>(:final F failure) => failure,
  };

  /// Result를 다른 타입으로 변환합니다.
  ///
  /// 성공인 경우 [onSuccess]를 호출하고, 실패인 경우 [onError]를 호출합니다.
  ///
  /// 예시:
  /// ```dart
  /// final message = result.fold(
  ///   onSuccess: (user) => 'Welcome ${user.name}',
  ///   onError: (failure) => 'Error: ${failure.message}',
  /// );
  /// ```
  R fold<R>({
    required R Function(S value) onSuccess,
    required R Function(F failure) onError,
  }) {
    return switch (this) {
      Success<F, S>(:final S value) => onSuccess(value),
      Error<F, S>(:final F failure) => onError(failure),
    };
  }

  /// 성공 값을 변환합니다. 실패인 경우 그대로 반환합니다.
  ///
  /// 예시:
  /// ```dart
  /// final nameResult = userResult.map((user) => user.name);
  /// ```
  Result<F, R> map<R>(R Function(S value) mapper) {
    return switch (this) {
      Success<F, S>(:final S value) => Success<F, R>(mapper(value)),
      Error<F, S>(:final F failure) => Error<F, R>(failure),
    };
  }

  /// 성공 값을 다른 Result로 변환합니다 (flatMap/bind).
  ///
  /// 예시:
  /// ```dart
  /// final result = getUserResult.flatMap(
  ///   (user) => getAddressResult(user.addressId),
  /// );
  /// ```
  Result<F, R> flatMap<R>(Result<F, R> Function(S value) mapper) {
    return switch (this) {
      Success<F, S>(:final S value) => mapper(value),
      Error<F, S>(:final F failure) => Error<F, R>(failure),
    };
  }

  /// 실패 값을 변환합니다. 성공인 경우 그대로 반환합니다.
  Result<R, S> mapError<R extends Failure>(R Function(F failure) mapper) {
    return switch (this) {
      Success<F, S>(:final S value) => Success<R, S>(value),
      Error<F, S>(:final F failure) => Error<R, S>(mapper(failure)),
    };
  }

  /// 성공 값을 가져오거나, 실패인 경우 기본값을 반환합니다.
  S getOrElse(S defaultValue) {
    return switch (this) {
      Success<F, S>(:final S value) => value,
      Error<F, S>() => defaultValue,
    };
  }

  /// 성공 값을 가져오거나, 실패인 경우 함수를 실행하여 값을 생성합니다.
  S getOrElseLazy(S Function(F failure) onError) {
    return switch (this) {
      Success<F, S>(:final S value) => value,
      Error<F, S>(:final F failure) => onError(failure),
    };
  }

  @override
  bool get stringify => true;
}

/// Result의 성공 케이스.
final class Success<F extends Failure, S> extends Result<F, S> {
  /// Success를 생성합니다.
  const Success(this.value);

  /// 성공 값.
  final S value;

  @override
  List<Object?> get props => <Object?>[value];
}

/// Result의 실패 케이스.
final class Error<F extends Failure, S> extends Result<F, S> {
  /// Error를 생성합니다.
  const Error(this.failure);

  /// 실패 정보.
  final F failure;

  @override
  List<Object?> get props => <Object?>[failure];
}
