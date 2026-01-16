import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User 엔티티의 Data 계층 모델
///
/// JSON 직렬화/역직렬화를 포함합니다.
@freezed
abstract class UserModel with _$UserModel {
  /// UserModel 생성자
  const factory UserModel({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    required DateTime createdAt,
    DateTime? lastSignInAt,
  }) = _UserModel;

  const UserModel._();

  /// JSON에서 UserModel 생성
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Entity로 변환
  User toEntity() => User(
    id: id,
    email: email,
    displayName: displayName,
    photoUrl: photoUrl,
    createdAt: createdAt,
    lastSignInAt: lastSignInAt,
  );

  /// Entity에서 Model 생성
  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    displayName: user.displayName,
    photoUrl: user.photoUrl,
    createdAt: user.createdAt,
    lastSignInAt: user.lastSignInAt,
  );
}
