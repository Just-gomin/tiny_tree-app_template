/// 인증 토큰 엔티티
///
/// 액세스 토큰과 리프레시 토큰을 관리합니다.
class AuthToken {
  /// 인증 토큰 생성자
  const AuthToken({
    required this.accessToken,
    this.refreshToken,
    required this.expiresAt,
  });

  /// 액세스 토큰
  final String accessToken;

  /// 리프레시 토큰 (선택적)
  final String? refreshToken;

  /// 토큰 만료 일시
  final DateTime expiresAt;

  /// 토큰이 만료되었는지 확인
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// 토큰이 유효한지 확인 (만료되지 않음)
  bool get isValid => !isExpired;

  /// 복사하여 새 인스턴스 생성
  AuthToken copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
  }) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthToken &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.expiresAt == expiresAt;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
        refreshToken.hashCode ^
        expiresAt.hashCode;
  }

  @override
  String toString() {
    return 'AuthToken(accessToken: ${accessToken.substring(0, 10)}..., refreshToken: ${refreshToken != null ? '${refreshToken!.substring(0, 10)}...' : 'null'}, expiresAt: $expiresAt)';
  }
}
