import 'package:storage/storage.dart';

class ClockSettings {
  final String timezone;
  final bool is24HourFormat;

  const ClockSettings({
    required this.timezone,
    required this.is24HourFormat,
  });

  factory ClockSettings.defaultSettings() {
    return const ClockSettings(
      timezone: 'Asia/Seoul',
      is24HourFormat: true,
    );
  }
}

class TimezoneInfo {
  final String name;
  final String displayName;
  final int utcOffset;

  const TimezoneInfo({
    required this.name,
    required this.displayName,
    required this.utcOffset,
  });
}

class ClockService {
  static const String _timezoneKey = 'timezone';
  static const String _is24HourKey = 'is24Hour';

  final StorageRepository _storage = SharedPreferencesStorage();

  static const List<TimezoneInfo> timezones = [
    TimezoneInfo(name: 'Asia/Seoul', displayName: 'Seoul', utcOffset: 9),
    TimezoneInfo(name: 'Asia/Tokyo', displayName: 'Tokyo', utcOffset: 9),
    TimezoneInfo(name: 'America/New_York', displayName: 'New York', utcOffset: -5),
    TimezoneInfo(name: 'Europe/London', displayName: 'London', utcOffset: 0),
    TimezoneInfo(name: 'Australia/Sydney', displayName: 'Sydney', utcOffset: 11),
  ];

  Future<ClockSettings> loadSettings() async {
    try {
      final timezone = await _storage.get(_timezoneKey) ?? 'Asia/Seoul';
      final is24HourStr = await _storage.get(_is24HourKey);
      final is24Hour = is24HourStr == 'true' || is24HourStr == null;
      return ClockSettings(
        timezone: timezone,
        is24HourFormat: is24Hour,
      );
    } catch (e) {
      return ClockSettings.defaultSettings();
    }
  }

  Future<void> saveTimezone(String timezone) async {
    await _storage.save(_timezoneKey, timezone);
  }

  Future<void> saveTimeFormat(bool is24Hour) async {
    await _storage.save(_is24HourKey, is24Hour.toString());
  }

  DateTime getTimeForTimezone(String timezone) {
    final timezoneInfo = timezones.firstWhere(
      (tz) => tz.name == timezone,
      orElse: () => timezones.first,
    );
    final now = DateTime.now().toUtc();
    return now.add(Duration(hours: timezoneInfo.utcOffset));
  }
}
