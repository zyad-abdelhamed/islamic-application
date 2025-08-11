import 'package:equatable/equatable.dart';

class PrayerSoundSettingsEntity extends Equatable {
  final bool fajr;
  final bool dhuhr;
  final bool asr;
  final bool maghrib;
  final bool isha;

  const PrayerSoundSettingsEntity({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  PrayerSoundSettingsEntity copyWithPrayer(String prayerKey, bool value) {
    switch (prayerKey) {
      case "فجر":
        return copyWith(fajr: value);
      case "ظهر":
        return copyWith(dhuhr: value);
      case "عصر":
        return copyWith(asr: value);
      case "مغرب":
        return copyWith(maghrib: value);
      case "عشاء":
        return copyWith(isha: value);
      default:
        return this;
    }
  }

  PrayerSoundSettingsEntity copyWith({
    bool? fajr,
    bool? dhuhr,
    bool? asr,
    bool? maghrib,
    bool? isha,
  }) {
    return PrayerSoundSettingsEntity(
      fajr: fajr ?? this.fajr,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
    );
  }

  @override
  List<Object?> get props => [fajr, dhuhr, asr, maghrib, isha];
}
