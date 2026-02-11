import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';
import 'package:utils/utils.dart';

void main() {
  setUpAll(initializeDateFormatting);

  group('DateTimeExtension', () {
    group('formatDate', () {
      test('기본 패턴으로 포맷한다', () {
        final DateTime date = DateTime(2024, 3, 15);
        expect(date.formatDate(), equals('2024-03-15'));
      });

      test('커스텀 패턴으로 포맷한다', () {
        final DateTime date = DateTime(2024, 3, 15);
        expect(date.formatDate(pattern: 'MM/dd/yyyy'), equals('03/15/2024'));
      });

      test('시간을 포함한 패턴으로 포맷한다', () {
        final DateTime date = DateTime(2024, 3, 15, 14, 30);
        expect(
          date.formatDate(pattern: 'yyyy-MM-dd HH:mm'),
          equals('2024-03-15 14:30'),
        );
      });
    });

    group('timeAgo', () {
      test('60초 미만은 방금 전을 반환한다', () {
        final DateTime now = DateTime(2024, 1, 1, 12);
        final DateTime past = DateTime(2024, 1, 1, 11, 59, 40);
        expect(past.timeAgo(now: now), equals('방금 전'));
      });

      test('5분 전을 반환한다', () {
        final DateTime now = DateTime(2024, 1, 1, 12);
        final DateTime past = DateTime(2024, 1, 1, 11, 55);
        expect(past.timeAgo(now: now), equals('5분 전'));
      });

      test('2시간 전을 반환한다', () {
        final DateTime now = DateTime(2024, 1, 1, 12);
        final DateTime past = DateTime(2024, 1, 1, 10);
        expect(past.timeAgo(now: now), equals('2시간 전'));
      });

      test('3일 전을 반환한다', () {
        final DateTime now = DateTime(2024, 1, 10);
        final DateTime past = DateTime(2024, 1, 7);
        expect(past.timeAgo(now: now), equals('3일 전'));
      });

      test('1달 전을 반환한다', () {
        final DateTime now = DateTime(2024, 3);
        final DateTime past = DateTime(2024, 1, 20);
        expect(past.timeAgo(now: now), equals('1달 전'));
      });

      test('1년 전을 반환한다', () {
        final DateTime now = DateTime(2025);
        final DateTime past = DateTime(2024);
        expect(past.timeAgo(now: now), equals('1년 전'));
      });

      test('미래 날짜는 빈 문자열을 반환한다', () {
        final DateTime now = DateTime(2024);
        final DateTime future = DateTime(2024, 1, 2);
        expect(future.timeAgo(now: now), equals(''));
      });
    });

    group('daysBetween', () {
      test('두 날짜 사이의 일수를 반환한다', () {
        final DateTime a = DateTime(2024);
        final DateTime b = DateTime(2024, 1, 10);
        expect(a.daysBetween(b), equals(9));
      });

      test('순서가 바뀌어도 양수를 반환한다', () {
        final DateTime a = DateTime(2024, 1, 10);
        final DateTime b = DateTime(2024);
        expect(a.daysBetween(b), equals(9));
      });

      test('같은 날짜의 다른 시간은 0을 반환한다', () {
        final DateTime a = DateTime(2024, 1, 1, 10);
        final DateTime b = DateTime(2024, 1, 1, 23, 59);
        expect(a.daysBetween(b), equals(0));
      });

      test('같은 날짜는 0을 반환한다', () {
        final DateTime a = DateTime(2024, 3, 15);
        expect(a.daysBetween(a), equals(0));
      });
    });

    group('dateOnly', () {
      test('시간 정보를 제거한 날짜만 반환한다', () {
        final DateTime dt = DateTime(2024, 3, 15, 14, 30, 45);
        expect(dt.dateOnly, equals(DateTime(2024, 3, 15)));
      });

      test('이미 시간이 0인 경우도 처리한다', () {
        final DateTime dt = DateTime(2024, 3, 15);
        expect(dt.dateOnly, equals(DateTime(2024, 3, 15)));
      });
    });
  });

  group('parseIso8601', () {
    test('유효한 ISO 8601 문자열을 파싱한다', () {
      final DateTime? date = parseIso8601('2024-03-15T10:30:00Z');
      expect(date, isNotNull);
      expect(date!.year, equals(2024));
      expect(date.month, equals(3));
      expect(date.day, equals(15));
    });

    test('날짜만 있는 문자열을 파싱한다', () {
      final DateTime? date = parseIso8601('2024-03-15');
      expect(date, isNotNull);
      expect(date!.year, equals(2024));
    });

    test('유효하지 않은 문자열은 null을 반환한다', () {
      expect(parseIso8601('not-a-date'), isNull);
    });

    test('빈 문자열은 null을 반환한다', () {
      expect(parseIso8601(''), isNull);
    });
  });
}
