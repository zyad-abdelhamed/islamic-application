import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';

Widget buildEditionDropdown(
    ValueNotifier<Map<String, String>> selectedEditionNotifier) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
    child: ValueListenableBuilder<Map<String, String>>(
      valueListenable: selectedEditionNotifier,
      builder: (context, selectedEdition, _) {
        return DropdownButtonFormField<Map<String, String>>(
          value: selectedEdition, 
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          items: AppStrings.tafsirEditions.map((edition) {
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
}

