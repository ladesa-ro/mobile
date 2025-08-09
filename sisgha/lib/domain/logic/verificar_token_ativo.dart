import 'package:shared_preferences/shared_preferences.dart';

Future<bool> verificarTokenAtivo() async {
  final armazenamento = await SharedPreferences.getInstance();
  final token = armazenamento.getString('token');
  if (token == "" || token == null) {
    return false;
  } else {
    return true;
  }
}
