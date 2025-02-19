// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../views/widgets_globais/botton_app_bar.dart';
import '../../views/widgets_globais/progress_indicator.dart';
import '../../views/widgets_globais/widget_erro.dart';
import '../api/repository.dart';
import '../cache/cache.dart';
import '../model/professor.dart';

class DadosProfessor with ChangeNotifier {
  late File _fotoCapaPerfil;
  late File _fotoImagemPerfil;
  late Professor professor;

  File get fotoCapaPerfil => _fotoCapaPerfil;
  File get fotoImagemPerfil => _fotoImagemPerfil;

  Future<bool> buscarDados(BuildContext context) async {
    mostrarDialogoDeCarregmento(context);
    final user = await Repository.buscarUser(context);
    if (user == null ||
        user.id == null ||
        user.id.isEmpty ||
        user.nome == null ||
        user.nome.isEmpty ||
        user.email == null ||
        user.email.isEmpty ||
        user.matricula == null ||
        user.matricula.isEmpty) {
      return false;
    }

    professor = Professor(
        matricula: user.matricula,
        nome: user.nome,
        email: user.email,
        id: user.id);

    final baixarImagemCapa = await Cache.baixarImagem(context,
        "https://dev.ladesa.com.br/api/v1/usuarios/${user.id}/imagem/capa");

    final baixarImagemPerfil = await Cache.baixarImagem(context,
        "https://dev.ladesa.com.br/api/v1/usuarios/${user.id}/imagem/perfil");

    _fotoCapaPerfil = baixarImagemCapa.absolute;
    _fotoImagemPerfil = baixarImagemPerfil.absolute;

    notifyListeners();
    return true;
  }

  Future<void> atualizarImagemCapaProvider(
      BuildContext context, File imagem) async {
    await Repository.atualizarImagemCapa(imagem, context);

    Cache.substituirArquivoNoCache(context, _fotoCapaPerfil.path, imagem);
    _fotoCapaPerfil = imagem.absolute;

    return notifyListeners();
  }

  Future<void> atualizarImagemPerfilProvider(
      BuildContext context, File imagem) async {
    await Repository.atualizarImagemPerfil(imagem, context);

    _fotoImagemPerfil = imagem.absolute;
    return notifyListeners();
  }

  void apagarDados(BuildContext context) {
    _fotoCapaPerfil = File('');
    _fotoImagemPerfil = File('');
    Cache.limparCache(context);
    professor = Professor(matricula: '', nome: '', email: '', id: '');
    notifyListeners();
  }

  static void iniciarProvider(BuildContext context) async {
    final dados = DadosProfessor();

    bool sucesso = await dados.buscarDados(context);

    if (sucesso) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: dados,
            child: Navigation(initialIndex: 1),
          ),
        ),
        (route) => false,
      );
    } else {
      return error(context);
    }
  }

  static void error(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return dialogoDeErro(context, 'error');
      },
    );
  }

  static void mostrarDialogoDeCarregmento(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Progressindicator(tamanho: 200),
      ),
    );
  }
}
