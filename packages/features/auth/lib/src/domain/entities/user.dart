/// 사용자 엔티티
///
/// 백엔드와 무관하게 앱에서 사용하는 사용자 정보를 나타냅니다.
class User {
  /// 사용자 생성자
  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.createdAt,
    this.lastSignInAt,
  });

  /// 사용자 고유 ID
  final String id;

  /// 이메일 주소
  final String email;

  /// 사용자 표시 이름
  final String? displayName;

  /// 프로필 사진 URL
  final String? photoUrl;

  /// 계정 생성 일시
  final DateTime createdAt;

  /// 마지막 로그인 일시
  final DateTime? lastSignInAt;

  /// 복사하여 새 인스턴스 생성
  User copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastSignInAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoUrl == photoUrl &&
        other.createdAt == createdAt &&
        other.lastSignInAt == lastSignInAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoUrl.hashCode ^
        createdAt.hashCode ^
        lastSignInAt.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl, createdAt: $createdAt, lastSignInAt: $lastSignInAt)';
  }
}
