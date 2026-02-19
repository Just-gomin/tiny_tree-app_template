/// date_extension.dart - DateTime 유틸리티 확장
library;

import 'package:intl/intl.dart';

/// [DateTime] 타입에 대한 확장 메서드.
extension DateTimeExtension on DateTime {
  /// DateTime을 지정된 패턴으로 포맷합니다.
  ///
  /// [pattern]: DateFormat 패턴 문자열 (기본값: `'yyyy-MM-dd'`)
  /// [locale]: 로케일 문자열 (기본값: `'ko'`)
  ///
  /// 예시:
  /// ```dart
  /// DateTime(2024, 3, 15).formatDate();
  /// // '2024-03-15'
  ///
  /// DateTime(2024, 3, 15).formatDate(pattern: 'yyyy년 MM월 dd일');
  /// // '2024년 03월 15일'
  ///
  /// DateTime(2024, 3, 15, 14, 30).formatDate(pattern: 'yyyy-MM-dd HH:mm');
  /// // '2024-03-15 14:30'
  /// ```
  String formatDate({String pattern = 'yyyy-MM-dd', String locale = 'ko'}) {
    return DateFormat(pattern, locale).format(this);
  }

  /// 현재 시각 기준으로 한국어 상대 시간 표현을 반환합니다.
  /// 의도적으로 한 달은 30일을 기준으로 삼습니다.
  ///
  /// [now]: 비교 기준 시각 (기본값: 현재 시각). 테스트 시 주입 가능합니다.
  ///
  /// 예시:
  /// ```dart
  /// recentDate.timeAgo();     // '방금 전'
  /// fiveMinutesAgo.timeAgo(); // '5분 전'
  /// twoHoursAgo.timeAgo();    // '2시간 전'
  /// threeDaysAgo.timeAgo();   // '3일 전'
  /// twoMonthsAgo.timeAgo();   // '2달 전'
  /// oneYearAgo.timeAgo();     // '1년 전'
  /// ```
  String timeAgo({DateTime? now}) {
    final DateTime n = now ?? DateTime.now();

    final bool isAfter = this.isAfter(n);
    if (isAfter) {
      return '';
    }

    final Duration duration = n.difference(this);

    final int seconds = duration.inSeconds;
    if (seconds < 60) {
      return '방금 전';
    }

    final int minutes = duration.inMinutes;
    if (minutes < 60) {
      return '$minutes분 전';
    }

    final int hours = duration.inHours;
    if (hours < 24) {
      return '$hours시간 전';
    }

    final int days = duration.inDays;
    if (days < 30) {
      return '$days일 전';
    }

    final int months = days ~/ 30;
    if (months < 12) {
      return '$months달 전';
    }

    final int years = days ~/ 365;
    return '$years년 전';
  }

  /// 두 DateTime 사이의 일 수를 반환합니다.
  ///
  /// 결과는 항상 0 이상입니다. 시간 정보는 무시하고 날짜만 비교합니다.
  ///
  /// 예시:
  /// ```dart
  /// DateTime(2024, 1, 1).daysBetween(DateTime(2024, 1, 10)); // 9
  /// DateTime(2024, 1, 10).daysBetween(DateTime(2024, 1, 1)); // 9
  /// ```
  int daysBetween(DateTime other) {
    final DateTime thisDate = DateTime(year, month, day);
    final DateTime otherDate = DateTime(other.year, other.month, other.day);
    return thisDate.difference(otherDate).inDays.abs();
  }

  /// 해당 DateTime이 오늘인지 확인합니다.
  bool isToday({DateTime? now}) {
    final DateTime n = now ?? DateTime.now();
    return year == n.year && month == n.month && day == n.day;
  }

  /// 해당 DateTime이 어제인지 확인합니다.
  bool isYesterday({DateTime? now}) {
    final DateTime n = now ?? DateTime.now();
    final DateTime yesterday = n.subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// 해당 DateTime이 내일인지 확인합니다.
  bool isTomorrow({DateTime? now}) {
    final DateTime n = now ?? DateTime.now();
    final DateTime tomorrow = n.add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// 시간 정보를 제거하고 날짜만 반환합니다.
  ///
  /// 예시:
  /// ```dart
  /// DateTime(2024, 3, 15, 14, 30, 45).dateOnly;
  /// // DateTime(2024, 3, 15)
  /// ```
  DateTime get dateOnly => DateTime(year, month, day);
}

/// ISO 8601 문자열을 [DateTime]으로 파싱합니다.
///
/// 파싱 실패 시 null을 반환합니다.
///
/// 예시:
/// ```dart
/// parseIso8601('2024-03-15T10:30:00Z'); // DateTime 반환
/// parseIso8601('not-a-date');            // null
/// parseIso8601('');                      // null
/// ```
DateTime? parseIso8601(String value) => DateTime.tryParse(value);
