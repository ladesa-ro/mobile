import 'package:shared_preferences/shared_preferences.dart';

class Armazenamento {
  static SharedPreferences? _sharedPreferences;

  static Future<void> iniciar() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    if (_sharedPreferences == null) {
      throw Exception();
    }
    return _sharedPreferences!;
  }

  // puchar as informações
  String get id => instance.getString("id") ?? "";
  String get token => instance.getString("token") ?? "";
  String get refreshToken => instance.getString("refreshToken") ?? "";
  String get localImagemPerfil => instance.getString("localImagemPerfil") ?? "";
  String get localImagemCapa => instance.getString("localImagemCapa") ?? "";
  int get tamanhoImagemPerfil => instance.getInt("tamanhoImagemPerfil") ?? 0;
  int get tamanhoImagemCapa => instance.getInt("tamanhoImagemCapa") ?? 0;

  Future<void> salvarId(String value) async =>
      await instance.setString("id", value);
  Future<void> salvarToken(String value) async =>
      await instance.setString("token", value);
  Future<void> salvarRefreshToken(String value) async =>
      await instance.setString("refreshToken", value);
  Future<void> salvarLocalImagemPerfil(String value) async =>
      await instance.setString("localImagemPerfil", value);
  Future<void> salvarLocalImagemCapa(String value) async =>
      await instance.setString("localImagemCapa", value);
  Future<void> salvarTamanhoImagemPerfil(int value) async =>
      await instance.setInt("tamanhoImagemPerfil", value);
  Future<void> salvarTamanhoImagemCapa(int value) async =>
      await instance.setInt("tamanhoImagemCapa", value);
  void apagarDados() async => await _sharedPreferences!.clear();
}
