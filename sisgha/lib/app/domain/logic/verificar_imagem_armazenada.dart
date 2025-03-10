import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sisgha/app/data/armazenamento/shared_preferences.dart';
import 'package:sisgha/app/domain/api/repository.dart';

class VerificarImagemArmazenada {
  static Future<File> verificador(String caminhoImagem, int index) async {
    if (verificarImagemBaixada(caminhoImagem)) {
      print(
          "ja estava baixada --------------------------------------------------");

      if (await verificarSeAImagemMuldou(index)) {
        print(
            "Imagem não mudou, usando cache. ----------------------------------------------------");
        return File(caminhoImagem);
      } else {
        print(
            "Imagem mudou, baixando nova versão.............................................................");
        return baixarImagem(index);
      }
    } else {
      print(
          "acabou de baixar --------------------------------------------------");
      return baixarImagem(index);
    }
  }

  static bool verificarImagemBaixada(String caminhoImagem) {
    if (File(caminhoImagem).existsSync()) {
      return true;
    } else {
      return false;
    }
  }

  static Future<File> baixarImagem(int index) async {
    if (index == 0) {
      return await Repository.baixarImagemCapa();
    } else {
      return await Repository.baixarImagemPerfil();
    }
  }

  static Future<bool> verificarSeAImagemMuldou(int index) async {
    var response = await http.get(Uri.parse(index == 0
        ? "https://dev.ladesa.com.br/api/v1/usuarios/${Armazenamento().id}/imagem/capa"
        : "https://dev.ladesa.com.br/api/v1/usuarios/${Armazenamento().id}/imagem/perfil"));
    print(
        "............................................................................... ${response.statusCode}");
    if (response.statusCode == 200) {
      int? novoTamanho;
      if (response.headers.containsKey('content-length')) {
        novoTamanho = int.tryParse(response.headers['content-length']!);
      } else {
        novoTamanho = 0;
      }

      print(
          "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${novoTamanho.toString()}");
      if (index == 0
          ? Armazenamento().tamanhoImagemCapa == novoTamanho
          : Armazenamento().tamanhoImagemPerfil == novoTamanho) {
        return true;
      } else {
        print(
            "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
        return false;
      }
    }
    print(
        "22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222");
    return false;
  }
}
