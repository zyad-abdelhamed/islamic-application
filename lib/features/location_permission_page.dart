import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/services/position_service.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({super.key});

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {
  bool isConnected = true;
  bool isLocationEnabled = true;
  LocationPermission permissionStatus = LocationPermission.denied;

  late StreamSubscription<bool> internetSubscription;
  late StreamSubscription<bool> locationEnabledSubscription;
  late StreamSubscription<LocationPermission> permissionSubscription;

  @override
  void initState() {
    super.initState();

    final locationService = sl<BaseLocationService>();

    // متابعة اتصال الإنترنت
    internetSubscription = sl<InternetConnection>()
        .onInternetStatusChanged
        .listen((connected) {
      setState(() {
        isConnected = connected;
      });
    });

    // متابعة حالة الموقع (مفعّل أم لا)
    locationEnabledSubscription = locationService.isLocationServiceEnabledStream.listen((enabled) {
      setState(() {
        isLocationEnabled = enabled;
      });
    });

    // متابعة حالة تصريح الوصول للموقع
    permissionSubscription = locationService.locationPermissionStream.listen((perm) {
      setState(() {
        permissionStatus = perm;
      });
    });
  }

  @override
  void dispose() {
    internetSubscription.cancel();
    locationEnabledSubscription.cancel();
    permissionSubscription.cancel();
    super.dispose();
  }

  bool get shouldShowLocationButton {
    return !isLocationEnabled ||
        (permissionStatus != LocationPermission.always &&
         permissionStatus != LocationPermission.whileInUse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 100, color: Colors.teal),
              SizedBox(height: 20),
              Text(
                "تفعيل الموقع مطلوب",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                "لكي تتمكن من استخدام:",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                "• مواقيت الصلاة حسب موقعك\n• تحديد اتجاه القبلة بدقة",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              Visibility(
                visible: shouldShowLocationButton,
                child: ElevatedButton(
                  onPressed: () => sl<BaseLocationService>().requestPermission,
                  child: Text("تفعيل الموقع الآن"),
                ),
              ),

              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  showLocationWarningDialog(context);
                },
                child: Text("لاحقاً"),
              ),
              SizedBox(height: 20),
              Visibility(
                visible:  !shouldShowLocationButton,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isConnected ? Icons.wifi : Icons.wifi_off,
                          color: isConnected ? Colors.green : Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          isConnected ? "متصل بالإنترنت" : "لا يوجد اتصال بالإنترنت",
                          style: TextStyle(
                            fontSize: 16,
                            color: isConnected ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isLocationEnabled ? Icons.location_on : Icons.location_off,
                          color: isConnected ? Colors.green : Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          isConnected ? "الموقع مفعّل" : "الموقع غير مفعّل",
                          style: TextStyle(
                            fontSize: 16,
                            color: isConnected ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isConnected && isLocationEnabled,
                      child: ElevatedButton(onPressed: (){}, child: Text("حفظ الموقع"))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void showLocationWarningDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('تنبيه هام'),
      content: Text(
        'خدمة الموقع غير مفعّلة أو تم رفض الإذن.\n\n'
        'لن تتمكن من استخدام الميزات التالية:\n'
        '• مواقيت الصلاة حسب موقعك\n'
        '• تحديد اتجاه القبلة بدقة\n\n'
        'سيتم عرض هذه الرسالة في الصفحة الرئيسية، ويمكنك تغيير الإعدادات لاحقًا من هذه الرسالة.',
        textAlign: TextAlign.right,
        style: TextStyle(height: 1.5),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // إغلاق الـ dialog
          },
          child: Text('فهمت'),
        ),
      ],
    ),
  );
}
