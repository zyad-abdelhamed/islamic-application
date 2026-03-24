import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/helper_function/get_random.dart';
import 'package:test_app/features/app/data/models/allah_name.dart';
import 'package:test_app/features/app/domain/entities/allah_name.dart';
import 'package:test_app/features/app/presentation/controller/cubit/allah_names_state.dart';

class AllahNamesCubit extends Cubit<AllahNamesState> {
  AllahNamesCubit() : super(AllahNamesStateInitial());
  List<AllahNameEntity> _names = [];
  void init() {
    _names = [
      AllahNameModel.fromJson({
        "name": "الرَّحْمَنُ",
        "transliteration": "Ar Rahmaan",
        "meaning": "The Most Merciful",
        "description":
            "The One who has plenty of mercy for the believers and the disbelievers in this world.",
        "audioUrl": "/audio/asma-ul-husna/rahman.mp3",
      }),
      AllahNameModel.fromJson({
        "name": "الرَّحِيمُ",
        "transliteration": "Ar Raheem",
        "meaning": "The Most Compassionate",
        "description": "The One who has plenty of mercy for the believers.",
        "audioUrl": "/audio/asma-ul-husna/rahim.mp3",
      }),
      AllahNameModel.fromJson({
        "name": "الْمَلِكُ",
        "transliteration": "Al Malik",
        "meaning": "The King",
        "description":
            "The Sovereign Lord, The One who has absolute ownership.",
        "audioUrl": "/audio/asma-ul-husna/malik.mp3",
      }),
      AllahNameModel.fromJson({
        "name": "الْقُدُّوسُ",
        "transliteration": "Al Quddus",
        "meaning": "The Most Holy",
        "description": "The One who is pure from any imperfection.",
        "audioUrl": "/audio/asma-ul-husna/quddus.mp3",
      }),
      AllahNameModel.fromJson({
        "name": "السَّلَامُ",
        "transliteration": "As-Salaam",
        "meaning": "The Source of Peace",
        "description": "The One who gives peace and safety to all creation.",
        "audioUrl": "/audio/asma-ul-husna/salam.mp3",
      }),
    ];
    getRandomName();
  }

  AllahNameEntity? current;

  static AllahNamesCubit get(BuildContext context) =>
      BlocProvider.of<AllahNamesCubit>(context);

  void getRandomName() {
    if (_names.isEmpty) return;

    AllahNameEntity newName;
    do {
      newName = _names[getRandomNumber(_names.length)];
    } while (current != null && newName.name == current!.name); // do not repeat
    /// why we use do while here specifically?
    /// the main reason => for first time, we need to make condition finnaly because we don't have current name.
    /// the sub reason => because loop itself.

    current = newName;
    emit(GetRandomAllahName(current: newName));
  }

  void toggleFavorite() {
    /// do toggleFavorite states here.

    emit(AllahNamesStateIsToggleFavoriteSuccess()); // these for test.
  }
}
