import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_token.dart';

part 'auth_token_model.freezed.dart';
part 'auth_token_model.g.dart';

/// AuthToken 엔티티의 Data 계층 모델
///
/// JSON 직렬화/역직렬화를 포함합니다.
@freezed
abstract class AuthTokenModel with _$AuthTokenModel {
  /// AuthTokenModel 생성자
  const factory AuthTokenModel({
    required String accessToken,
    String? refreshToken,
    required DateTime expiresAt,
  }) = _AuthTokenModel;

  const AuthTokenModel._();

  /// JSON에서 AuthTokenModel 생성
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenModelFromJson(json);

  /// Entity로 변환
  AuthToken toEntity() => AuthToken(
    accessToken: accessToken,
    refreshToken: refreshToken,
    expiresAt: expiresAt,
  );

  /// Entity에서 Model 생성
  factory AuthTokenModel.fromEntity(AuthToken token) => AuthTokenModel(
    accessToken: token.accessToken,
    refreshToken: token.refreshToken,
    expiresAt: token.expiresAt,
  );
}
