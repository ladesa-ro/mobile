// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:sisgha/app/data/armazenamento/shared_preferences.dart';
// import 'package:sisgha/app/domain/api/repository.dart';

// class VerificarImagemArmazenada {
//   static final String _api =
//       "https://dev.ladesa.com.br/api/v1/usuarios/${Armazenamento().id}/imagem/";
//   static Future<File> verificador(String caminhoImagem, int index) async {
//     if (_verificarImagemBaixada(caminhoImagem)) {
//       if (await _verificarSeAImagemMuldou(index)) {
//         return File(caminhoImagem);
//       } else {
//         return _baixarImagem(index);
//       }
//     } else {
//       return _baixarImagem(index);
//     }
//   }

//   static bool _verificarImagemBaixada(String caminhoImagem) {
//     if (File(caminhoImagem).existsSync()) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static Future<File> _baixarImagem(int index) async {
//     if (index == 0) {
//       return await Repository.baixarImagemCapa();
//     } else {
//       return await Repository.baixarImagemPerfil();
//     }
//   }

//   static Future<bool> _verificarSeAImagemMuldou(int index) async {
//     final url = Uri.parse(_api + (index == 0 ? "capa" : "perfil"));
//     var response = await http.get(url);

//     int novoTamanho = response.contentLength ?? 404;

//     if (index == 0
//         ? Armazenamento().tamanhoImagemCapa == novoTamanho
//         : Armazenamento().tamanhoImagemPerfil == novoTamanho) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
