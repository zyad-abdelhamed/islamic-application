import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/features/app/presentation/view/pages/adhkar_page.dart';

class GetAdhkarController {
  GetAdhkarController({required this.getAdhkarUseCase});

  final GetAdhkarUseCase getAdhkarUseCase;
  late Set<AdhkarEntity> adhkar;

  void getAdhkar(AdhkarParameters adhkarParameters) async {
    Either<Failure, List<AdhkarEntity>> result =
        await getAdhkarUseCase(parameters: adhkarParameters);

    result.fold(
      (failure) {},
      (data) {
        adhkar = data.toSet();

        Navigator.pushReplacement(
            adhkarParameters.context,
            MaterialPageRoute(
              builder: (context) => AdhkarPage(
                  getAdhkarController: this,
                  nameOfAdhkar: adhkarParameters.nameOfAdhkar),
            ));
      },
    );
  }
}
