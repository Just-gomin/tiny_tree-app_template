/// number_extension.dart - num 유틸리티 확장
library;

import 'dart:math' as math;

import 'package:intl/intl.dart';

/// [num] 타입에 대한 확장 메서드.
///
/// [int]와 [double] 모두에서 사용 가능합니다.
extension NumExtension on num {
  /// 지정된 소수점 자릿수로 반올림합니다.
  ///
  /// [decimals]: 소수점 자릿수 (기본값: 0)
  ///
  /// 예시:
  /// ```dart
  /// 3.14159.roundTo(2);  // 3.14
  /// 3.14159.roundTo(0);  // 3.0
  /// 1234.5.roundTo(1);   // 1234.5
  /// ```
  ///
  /// Throws [ArgumentError] if [decimals] is negative.
  double roundTo(int decimals) {
    if (decimals < 0) {
      throw ArgumentError.value(
        decimals,
        'decimals',
        'decimals must be non-negative',
      );
    }
    final double factor = math.pow(10, decimals).toDouble();
    return (this * factor).round() / factor;
  }

  /// 숫자를 퍼센트 문자열로 변환합니다.
  ///
  /// 0.0 ~ 1.0 범위의 값을 퍼센트로 변환합니다.
  ///
  /// [decimals]: 소수점 자릿수 (기본값: 0)
  ///
  /// 예시:
  /// ```dart
  /// 0.75.toPercentage();              // '75%'
  /// 0.1234.toPercentage(decimals: 1); // '12.3%'
  /// 1.0.toPercentage();               // '100%'
  /// ```
  String toPercentage({int decimals = 0}) {
    final double percentValue = (this * 100).roundTo(decimals);
    if (decimals == 0) {
      return '${percentValue.toInt()}%';
    }
    return '$percentValue%';
  }

  /// 숫자를 통화 형식 문자열로 변환합니다.
  ///
  /// [locale]: 로케일 문자열 (기본값: `'ko'`)
  /// [symbol]: 통화 기호 (기본값: `'₩'`)
  /// [decimalDigits]: 소수점 자릿수 (기본값: 0)
  ///
  /// 예시:
  /// ```dart
  /// 1234567.formatCurrency();
  /// // '₩1,234,567'
  ///
  /// 1234.5.formatCurrency(locale: 'en', symbol: r'$', decimalDigits: 2);
  /// // '$1,234.50'
  /// ```
  String formatCurrency({
    String locale = 'ko',
    String symbol = '₩',
    int decimalDigits = 0,
  }) {
    return NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(this);
  }

  /// 숫자를 천 단위 구분 기호가 있는 문자열로 변환합니다.
  ///
  /// 예시:
  /// ```dart
  /// 1234567.withThousandsSeparator();     // '1,234,567'
  /// 1234567.89.withThousandsSeparator();  // '1,234,567.89'
  /// ```
  String withThousandsSeparator({String locale = 'ko'}) {
    final NumberFormat format = NumberFormat('#,###', locale);
    final String str = toString();
    final int dotIndex = str.indexOf('.');
    if (dotIndex == -1) {
      return format.format(this);
    }
    final String integerStr = str.substring(0, dotIndex);
    final String decimalStr = str.substring(dotIndex + 1);
    return '${format.format(int.parse(integerStr))}.$decimalStr';
  }

  /// 숫자가 주어진 범위 내에 있는지 확인합니다. (경계값 포함)
  ///
  /// 예시:
  /// ```dart
  /// 5.isBetween(1, 10);   // true
  /// 0.isBetween(1, 10);   // false
  /// 10.isBetween(1, 10);  // true
  /// ```
  bool isBetween(num min, num max) => this >= min && this <= max;

  /// 소수점 부분을 반환합니다.
  ///
  /// 예시:
  /// ```dart
  /// 3.14.decimalPart(); // 0.14
  /// 1234.0.decimalPart(); // 0.0
  /// ```
  num decimalPart() {
    return this - toInt();
  }
}
