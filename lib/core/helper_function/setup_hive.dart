import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/features/app/data/datasources/daily_adhkar_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/location_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/quran_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_adapter.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
import 'package:test_app/features/app/domain/entities/featured_record_type_adapter.dart';
import 'package:test_app/features/app/domain/entities/location_entity.dart';
import 'package:test_app/features/app/domain/entities/location_type_adapter.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/domain/entities/prayer_sounds_type_adapter.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/entities/type_adapter_for_book_mark.dart';
import 'package:test_app/features/app/domain/entities/type_adapter_for_surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/domain/entities/type_adapter_for_timings.dart';
import 'package:test_app/core/constants/data_base_constants.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TypeAdapterForTimings());
  Hive.registerAdapter(LocationTypeAdapter());
  Hive.registerAdapter(PrayerSoundSettingsAdapter());
  Hive.registerAdapter(TypeAdapterForBookMark());
  Hive.registerAdapter(FeaturedRecordEntityAdapter());
  Hive.registerAdapter(DailyAdhkarEntityAdapter());
  Hive.registerAdapter(TypeAdapterForAyahEntity());
  Hive.registerAdapter(TafsirAyahEntityAdapter());
  Hive.registerAdapter(SurahWithTafsirEntityAdapter());
  await Hive.openBox<DailyAdhkarEntity>(DailyAdhkarLocalDataSourceImpl.boxName);
  await Hive.openBox<FeaturedRecordEntity>(
      DataBaseConstants.featuerdRecordsHiveKey);
  await Hive.openBox<bool>(DataBaseConstants.rTableBoxHiveKey);
  await Hive.openBox<LocationEntity>(LocationLocalDataSourceImpl.boxName);
  await Hive.openBox<Timings>(PrayersLocalDataSourceImpl.prayersBoxName);
  await Hive.openBox<PrayerSoundSettingsEntity>(
      PrayersLocalDataSourceImpl.soundSettingsBoxName);
  await Hive.openBox<BookMarkEntity>(QuranLocalDataSourceImpl.bookMarksBoxName);
  await Hive.openBox<SurahWithTafsirEntity>(
      QuranLocalDataSourceImpl.quranWithTafsirBoxName);
}
