import 'package:equatable/equatable.dart';

/// 값 객체(Value Object)의 기본 추상 클래스.
///
/// 값 객체는 ID가 없으며, 모든 속성 값으로 동등성을 판단합니다.
/// 불변(immutable)이어야 하며, 모든 필드는 final이어야 합니다.
///
/// 예시:
/// ```dart
/// class Money extends ValueObject {
///   final double amount;
///   final String currency;
///
///   const Money({
///     required this.amount,
///     required this.currency,
///   });
///
///   @override
///   List<Object?> get props => [amount, currency];
/// }
/// ```
abstract class ValueObject extends Equatable {
  /// ValueObject를 생성합니다.
  const ValueObject();

  @override
  bool get stringify => true;
}
