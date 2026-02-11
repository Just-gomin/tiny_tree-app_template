import 'package:test/test.dart';
import 'package:utils/utils.dart';

void main() {
  group('NullableStringExtension', () {
    group('isNullOrEmpty', () {
      test('null 문자열은 true를 반환한다', () {
        expect((null as String?).isNullOrEmpty, isTrue);
      });

      test('빈 문자열은 true를 반환한다', () {
        expect(''.isNullOrEmpty, isTrue);
      });

      test('값이 있는 문자열은 false를 반환한다', () {
        expect('hello'.isNullOrEmpty, isFalse);
      });

      test('공백만 있는 문자열은 false를 반환한다', () {
        expect('   '.isNullOrEmpty, isFalse);
      });
    });

    group('isNotNullOrEmpty', () {
      test('null 문자열은 false를 반환한다', () {
        expect((null as String?).isNotNullOrEmpty, isFalse);
      });

      test('값이 있는 문자열은 true를 반환한다', () {
        expect('hello'.isNotNullOrEmpty, isTrue);
      });
    });
  });

  group('StringExtension', () {
    group('isBlank', () {
      test('빈 문자열은 true를 반환한다', () {
        expect(''.isBlank, isTrue);
      });

      test('공백만 있는 문자열은 true를 반환한다', () {
        expect('   '.isBlank, isTrue);
      });

      test('탭 문자만 있는 문자열은 true를 반환한다', () {
        expect('\t'.isBlank, isTrue);
      });

      test('공백이 포함된 문자열은 false를 반환한다', () {
        expect(' a '.isBlank, isFalse);
      });

      test('일반 문자열은 false를 반환한다', () {
        expect('hello'.isBlank, isFalse);
      });
    });

    group('isNotBlank', () {
      test('빈 문자열은 false를 반환한다', () {
        expect(''.isNotBlank, isFalse);
      });

      test('값이 있는 문자열은 true를 반환한다', () {
        expect('hello'.isNotBlank, isTrue);
      });
    });

    group('capitalize', () {
      test('첫 글자를 대문자로 변환한다', () {
        expect('hello'.capitalize(), equals('Hello'));
      });

      test('빈 문자열은 빈 문자열을 반환한다', () {
        expect(''.capitalize(), equals(''));
      });

      test('이미 대문자인 경우 변경하지 않는다', () {
        expect('Hello'.capitalize(), equals('Hello'));
      });

      test('나머지 글자는 변경하지 않는다', () {
        expect('hELLO'.capitalize(), equals('HELLO'));
      });

      test('단일 문자를 처리한다', () {
        expect('a'.capitalize(), equals('A'));
      });

      test('여러 단어에서 첫 단어만 대문자로 변환한다', () {
        expect('hello world'.capitalize(), equals('Hello world'));
      });
    });

    group('truncate', () {
      test('길이가 초과되면 잘라내고 ellipsis를 붙인다', () {
        expect('Hello, World!'.truncate(5), equals('Hello...'));
      });

      test('길이가 초과되지 않으면 변경 없이 반환한다', () {
        expect('Hi'.truncate(10), equals('Hi'));
      });

      test('정확히 maxLength와 같으면 변경 없이 반환한다', () {
        expect('Hello'.truncate(5), equals('Hello'));
      });

      test('커스텀 ellipsis를 사용할 수 있다', () {
        expect('Hello World'.truncate(5, ellipsis: '→'), equals('Hello→'));
      });

      test('ellipsis를 빈 문자열로 설정할 수 있다', () {
        expect('Hello World'.truncate(5, ellipsis: ''), equals('Hello'));
      });

      test('maxLength가 0이면 ArgumentError를 던진다', () {
        expect(() => 'Hello'.truncate(0), throwsArgumentError);
      });

      test('maxLength가 음수이면 ArgumentError를 던진다', () {
        expect(() => 'Hello'.truncate(-1), throwsArgumentError);
      });
    });

    group('removeSpaces', () {
      test('중간 공백을 제거한다', () {
        expect('hello world'.removeSpaces(), equals('helloworld'));
      });

      test('앞뒤 공백을 제거한다', () {
        expect('  a b c  '.removeSpaces(), equals('abc'));
      });

      test('공백이 없는 문자열은 변경 없이 반환한다', () {
        expect('hello'.removeSpaces(), equals('hello'));
      });

      test('빈 문자열은 빈 문자열을 반환한다', () {
        expect(''.removeSpaces(), equals(''));
      });
    });

    group('toSnakeCase', () {
      test('camelCase를 snake_case로 변환한다', () {
        expect('helloWorld'.toSnakeCase(), equals('hello_world'));
      });

      test('이미 소문자인 문자열은 변경 없이 반환한다', () {
        expect('hello'.toSnakeCase(), equals('hello'));
      });

      test('여러 단어를 snake_case로 변환한다', () {
        expect('myAppName'.toSnakeCase(), equals('my_app_name'));
      });

      test('첫 글자가 대문자인 경우 처리한다', () {
        expect('HelloWorld'.toSnakeCase(), equals('hello_world'));
      });
    });
  });
}
