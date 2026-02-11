/// string_extension.dart - String 및 String? 유틸리티 확장
library;

/// [String?] 타입에 대한 확장 메서드.
///
/// nullable String에서 자주 사용하는 검사 기능을 제공합니다.
extension NullableStringExtension on String? {
  /// 문자열이 null이거나 비어있으면 true를 반환합니다.
  ///
  /// 공백만 있는 문자열은 false를 반환합니다. 공백 포함 검사는 [StringExtension.isBlank]를 사용하세요.
  ///
  /// 예시:
  /// ```dart
  /// String? name = null;
  /// name.isNullOrEmpty; // true
  ///
  /// String? emptyName = '';
  /// emptyName.isNullOrEmpty; // true
  ///
  /// String? validName = 'Alice';
  /// validName.isNullOrEmpty; // false
  ///
  /// String? spaceName = '   ';
  /// spaceName.isNullOrEmpty; // false
  /// ```
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// 문자열이 null이 아니고 비어있지 않으면 true를 반환합니다.
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

/// [String] 타입에 대한 확장 메서드.
extension StringExtension on String {
  /// 문자열이 공백(whitespace)만으로 이루어져 있거나 비어있으면 true를 반환합니다.
  ///
  /// 예시:
  /// ```dart
  /// ''.isBlank;     // true
  /// '   '.isBlank;  // true
  /// 'a'.isBlank;    // false
  /// ' a '.isBlank;  // false
  /// ```
  bool get isBlank => trim().isEmpty;

  /// 문자열이 공백만이 아닌 내용을 포함하면 true를 반환합니다.
  bool get isNotBlank => !isBlank;

  /// 첫 글자를 대문자로 변환합니다. 나머지 글자는 변경하지 않습니다.
  ///
  /// 빈 문자열인 경우 빈 문자열을 반환합니다.
  ///
  /// 예시:
  /// ```dart
  /// 'hello'.capitalize();        // 'Hello'
  /// 'hello world'.capitalize();  // 'Hello world'
  /// 'HELLO'.capitalize();        // 'HELLO'
  /// ''.capitalize();             // ''
  /// ```
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// 문자열이 [maxLength]를 초과하면 잘라내고 [ellipsis]를 붙입니다.
  ///
  /// [maxLength]는 원본 문자열의 최대 허용 길이입니다.
  /// 초과 시 [maxLength]만큼 자르고 [ellipsis]를 붙입니다.
  ///
  /// 예시:
  /// ```dart
  /// 'Hello, World!'.truncate(5);              // 'Hello...'
  /// 'Hello, World!'.truncate(5, ellipsis: '→'); // 'Hello→'
  /// 'Hi'.truncate(10);                        // 'Hi' (변경 없음)
  /// ```
  ///
  /// Throws [ArgumentError] if [maxLength] is less than 1.
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (maxLength < 1) {
      throw ArgumentError.value(
        maxLength,
        'maxLength',
        'maxLength must be at least 1',
      );
    }
    if (length <= maxLength) {
      return this;
    }
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// 문자열에서 모든 공백 문자를 제거합니다.
  ///
  /// 예시:
  /// ```dart
  /// 'hello world'.removeSpaces();  // 'helloworld'
  /// '  a b c  '.removeSpaces();    // 'abc'
  /// ```
  String removeSpaces() => replaceAll(' ', '');

  /// camelCase 문자열을 snake_case로 변환합니다.
  ///
  /// 연속 대문자의 경우 각각 별도의 단어로 처리됩니다.
  ///
  /// 예시:
  /// ```dart
  /// 'helloWorld'.toSnakeCase();  // 'hello_world'
  /// 'myApp'.toSnakeCase();       // 'my_app'
  /// ```
  String toSnakeCase() {
    return replaceAllMapped(
      RegExp('[A-Z]'),
      (Match match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceFirst(RegExp('^_'), '');
  }
}
