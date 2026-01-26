/// 도메인 레이어에서 발생하는 예외의 기본 클래스.
///
/// 일반적으로 Failure를 사용하는 것을 권장하지만,
/// 즉시 중단해야 하는 치명적인 상황에서 예외를 사용할 수 있습니다.
///
/// 예시:
/// ```dart
/// class InvalidStateException extends DomainException {
///   InvalidStateException(String message) : super(message);
/// }
///
/// void processOrder(Order order) {
///   if (order.items.isEmpty) {
///     throw InvalidStateException('Order must have at least one item');
///   }
///   // ...
/// }
/// ```
class DomainException implements Exception {
  /// 예외 메시지.
  final String message;

  /// 원인이 된 에러 (선택적).
  final Object? cause;

  /// 스택 트레이스 (선택적).
  final StackTrace? stackTrace;

  /// DomainException을 생성합니다.
  const DomainException(
    this.message, {
    this.cause,
    this.stackTrace,
  });

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer('DomainException: $message');
    if (cause != null) {
      buffer.write('\nCaused by: $cause');
    }
    if (stackTrace != null) {
      buffer.write('\n$stackTrace');
    }
    return buffer.toString();
  }
}

/// 검증 예외.
///
/// 비즈니스 규칙 위반 시 발생합니다.
class ValidationException extends DomainException {
  /// 검증에 실패한 필드명 (선택적).
  final String? field;

  /// ValidationException을 생성합니다.
  const ValidationException(
    super.message, {
    this.field,
    super.cause,
    super.stackTrace,
  });

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer('ValidationException');
    if (field != null) {
      buffer.write(' (field: $field)');
    }
    buffer.write(': $message');
    if (cause != null) {
      buffer.write('\nCaused by: $cause');
    }
    return buffer.toString();
  }
}
