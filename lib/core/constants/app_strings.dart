import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';


abstract class AppStrings {
  static List<String> appBarTitles({required bool withTwoLines}) {
    String getNewlineOrWightSpace() => withTwoLines ? '\n ' : ' ';
    return <String>[
      'القرآن${getNewlineOrWightSpace()}الكريم',
      'تفسير${getNewlineOrWightSpace()}القرآن',
      'السبحه${getNewlineOrWightSpace()}الالكترونيه',
      'جدول${getNewlineOrWightSpace()}رمضان',
      'اتجاه${getNewlineOrWightSpace()}القبله'
      'اخرى'
    ];
  }

  static Map<String, dynamic> _localizedStrings = {};

  static Future<void> load() async {
    // Load general strings
    _localizedStrings = await getJson(RoutesConstants.appStringsJsonRouteName);
  }

  static dynamic translate(String key) {
    return _localizedStrings[key] ?? '** $key not found';
  }
}
