// Obtain shared preferences.
import 'package:demo_aigen/Common/SettingFile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonFunction {
  late SharedPreferences _prefs;
  final _Akey = "KEY";

  saveAPIKey(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_Akey, value);
  }

  Future<String> getAPIKey() async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(_Akey) ?? "-";
    return value;
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }

}