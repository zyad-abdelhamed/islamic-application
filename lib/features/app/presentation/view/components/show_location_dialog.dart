import 'package:flutter/material.dart';

void showLocationUpdateDialog({
  required BuildContext context,
  required bool isOnline,
  required bool isLocationEnabled,
  required VoidCallback onOpenInternet,
  required VoidCallback onOpenLocation,
  required VoidCallback onUpdateLocation,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('تحديث الموقع'),
        content: const Text(
          'يرجى التأكد من تفعيل الإنترنت والموقع لتحديث موقعك الحالي.',
        ),
        actions: [
          // زر تفعيل الإنترنت
          TextButton(
            onPressed: isOnline ? null : onOpenInternet,
            child: Text(
              'تفعيل الإنترنت',
              style: TextStyle(
                color: isOnline ? Colors.grey : Theme.of(context).primaryColor,
              ),
            ),
          ),

          // زر تفعيل الموقع
          TextButton(
            onPressed: isLocationEnabled ? null : onOpenLocation,
            child: Text(
              'تفعيل الموقع',
              style: TextStyle(
                color: isLocationEnabled ? Colors.grey : Theme.of(context).primaryColor,
              ),
            ),
          ),

          // زر تحديث الموقع
          ElevatedButton(
            onPressed: (isOnline && isLocationEnabled)
                ? onUpdateLocation
                : null,
            child: const Text('تحديث الموقع'),
          ),
        ],
      );
    },
  );
}
