import 'package:shared_preferences/shared_preferences.dart';

Future<bool> verificarTokenAtivo() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  if (token != null) {
    return true;
  } else {
    return false;
  }
}
