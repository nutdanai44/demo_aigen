// Obtain shared preferences.
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

}