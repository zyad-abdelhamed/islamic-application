import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/features/app/data/models/tafsir_edition_model.dart';
import 'package:test_app/features/app/domain/entities/tafsir_edition_entity.dart';

class TafsirEditionDropdown extends StatelessWidget {
  final ValueNotifier<TafsirEditionEntity?> selectedEditionNotifier;

  const TafsirEditionDropdown({
    super.key,
    required this.selectedEditionNotifier,
  });

  Future<List<TafsirEditionEntity>> loadTafsirEditions() async {
    final Map<String, dynamic> data =
        await getJson(RoutesConstants.tafsirJsonRouteName);

    return (data["tafsirEditions"] as List)
        .map((map) => TafsirEditionModel.fromJson(map))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TafsirEditionEntity>>(
      future: loadTafsirEditions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GetAdaptiveLoadingWidget();
        } else if (snapshot.hasError) {
          return const Text('حدث خطأ أثناء تحميل التفاسير');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('لا توجد تفاسير متاحة');
        }

        final editions = snapshot.data!;

        // حدد أول قيمة افتراضيًا لو مفيش اختيار
        if (selectedEditionNotifier.value == null && editions.isNotEmpty) {
          selectedEditionNotifier.value = editions.first;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
          child: ValueListenableBuilder<TafsirEditionEntity?>(
            valueListenable: selectedEditionNotifier,
            builder: (context, selectedEdition, _) {
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                value: selectedEdition?.identifier,
                items: editions.map((edition) {
                  return DropdownMenuItem<String>(
                    value: edition.identifier,
                    child: Text(edition.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedEditionNotifier.value =
                        editions.firstWhere((e) => e.identifier == value);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
