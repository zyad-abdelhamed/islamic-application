import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 15,
          children: [
            const Text(
              'يرجى التأكد من تفعيل الإنترنت والموقع لتحديث موقعك الحالي.',
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // زر تفعيل الإنترنت
          TextButton(
            onPressed: isOnline ? null : onOpenInternet,
            child: Column(
              children: [
                Icon(Icons.wifi,color: isOnline ? Colors.grey :  Colors.blueAccent,),
                Text(
                  'تفعيل الإنترنت',
                  style: TextStyle(
                    color: isOnline ? Colors.grey :  Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),

          // زر تفعيل الموقع
          TextButton(
            onPressed: isLocationEnabled ? null : onOpenLocation,
            child: Column(
              children: [                Icon(Icons.location_pin,color: isLocationEnabled ? Colors.grey :  Colors.blueAccent,),

                Text(
                  'تفعيل الموقع',
                  style: TextStyle(
                    color: isLocationEnabled
                        ? Colors.grey
                        : Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),

              ],
            ),
          // زر تحديث الموقع
          Visibility(
            visible: (isOnline && isLocationEnabled),
            child: MaterialButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              onPressed:
                  (isOnline && isLocationEnabled) ? onUpdateLocation : null,color: Theme.of(context).primaryColor,
              child: const Text('تحديث الموقع',style: TextStyle(color: AppColors.white),),
            ),
          ),
          ],
        ),
      );
    },
  );
}
