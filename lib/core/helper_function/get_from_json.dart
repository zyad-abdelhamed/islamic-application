import 'dart:convert';
import 'package:flutter/services.dart';

Future<dynamic> getJson(String route) async {
    final String jsonString =
        await rootBundle.loadString(route);
    return json.decode(jsonString);
  }