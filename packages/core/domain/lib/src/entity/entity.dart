import 'package:equatable/equatable.dart';

/// 도메인 엔티티의 기본 추상 클래스.
///
/// 엔티티는 ID를 통해 식별되는 도메인 객체입니다.
/// 두 엔티티는 속성이 달라도 ID가 같으면 동일한 것으로 간주됩니다.
///
/// 예시:
/// ```dart
/// class User extends Entity<String> {
///   final String name;
///   final String email;
///
///   const User({
///     required String id,
///     required this.name,
///     required this.email,
///   }) : super(id);
///
///   @override
///   List<Object?> get props => [id];
/// }
/// ```
///
/// 타입 파라미터:
/// - [ID]: 엔티티를 식별하는 ID의 타입 (String, int 등)
abstract class Entity<ID extends Object> extends Equatable {
  /// Entity를 생성합니다.
  ///
  /// [id]는 반드시 제공되어야 하며, null이 아니어야 합니다.
  const Entity(this.id);

  /// 엔티티의 고유 식별자.
  final ID id;

  @override
  List<Object?> get props => <Object?>[id];

  @override
  bool get stringify => true;
}
