import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';

class TafsirEditionDropdown extends StatelessWidget {
  final ValueNotifier<Map<String, String>> selectedEditionNotifier;

  const TafsirEditionDropdown({
    super.key,
    required this.selectedEditionNotifier,
  });

  Future<List<Map<String, String>>> loadTafsirEditions() async {
    final data = await getJson(RoutesConstants.tafsirJsonRouteName);
    return List<Map<String, String>>.from(data["tafsirEditions"]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
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

        // Default selected if not set
        if (selectedEditionNotifier.value.isEmpty && editions.isNotEmpty) {
          selectedEditionNotifier.value = editions.first;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
          child: ValueListenableBuilder<Map<String, String>>(
            valueListenable: selectedEditionNotifier,
            builder: (context, selectedEdition, _) {
              return DropdownButtonFormField<Map<String, String>>(
                value: editions.contains(selectedEdition)
                    ? selectedEdition
                    : null,
                items: editions.map((edition) {
                  return DropdownMenuItem<Map<String, String>>(
                    value: edition,
                    child: Text(edition['name'] ?? ''),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedEditionNotifier.value = value;
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
