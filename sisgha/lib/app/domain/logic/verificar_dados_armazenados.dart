import 'package:shared_preferences/shared_preferences.dart';

Future<bool> verificarDadosBaixados() async {
  final armazenamento = await SharedPreferences.getInstance();
  final campos = ['token', 'refreshToken', 'id', 'email', 'matricula', 'nome'];

  for (final campo in campos) {
    final valor = armazenamento.getString(campo);
    if (valor == null || valor.isEmpty) {
      return false;
    }
  }

  return true;
}
