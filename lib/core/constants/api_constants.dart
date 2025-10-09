import 'package:test_app/core/helper_function/get_random.dart';
import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';
import 'package:test_app/features/app/data/models/quran_audio_parameters.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';

class Apiconstants {
  static String getTimingsUrl(
      {required double latitude, required double longitude}) {
    return "https://api.aladhan.com/v1/timings?latitude=$latitude&longitude=$longitude";
  }

  static Future<String> getTimingsOfMonthUrl(
      GetPrayerTimesOfMonthPrameters getPrayerTimesOfMonthPrameters,
      {required double latitude,
      required double longitude}) async {
    return "https://api.aladhan.com/v1/calendar?latitude=$latitude&longitude=$longitude&month=${getPrayerTimesOfMonthPrameters.date.month}&year=${getPrayerTimesOfMonthPrameters.date.year}";
  }

  static String get ahadithUrl =>
      'https://hadis-api-id.vercel.app/hadith/abu-dawud?page=${getRandomNumber(4419)}&limit=1';

  static String baseQuranApi = 'https://api.quranhub.com';

  static String getTafsirUrl(TafsirRequestParams params) {
    return '$baseQuranApi/v1/surah/${params.surahNumber}/${params.edition}?offset=${params.offset}&limit=${params.limit}';
  }

  static String getSurahUrl(SurahRequestParams params) {
    return '$baseQuranApi/v1/surah/${params.surahNumber}?offset=${params.offset}&limit=${params.limit}';
  }

  static String getSearchUrl(String query) {
    // مهم: لازم نعمل encode للـ query عشان لو فيه مسافات أو تشكيل
    final encodedQuery = Uri.encodeComponent(query);
    return '$baseQuranApi/v1/search/$encodedQuery';
  }

  static String getAyahTafsirUrl({
    required int ayahNumber,
    required String edition,
  }) {
    return '$baseQuranApi/v1/ayah/$ayahNumber/$edition';
  }

  static String buildAyahAudioUrl(AyahAudioRequestParams params) {
    final bitrate = params.quality.value;
    final edition = params.edition;
    final ayahNumber = params.ayahGlobalNumber;

    return 'https://cdn.islamic.network/quran/audio/$bitrate/$edition/$ayahNumber.mp3';
  }

  static String buildSurahAudioEndpoint(SurahAudioRequestParams params) {
    return 'https://api.alquran.cloud/v1/surah/${params.surahNumber}/${params.edition}';
  }
}
