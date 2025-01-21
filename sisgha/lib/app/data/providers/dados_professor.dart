// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/data/cache/cache.dart';

import '../../views/widgets_globais/botton_app_bar.dart';
import '../../views/widgets_globais/progress_indicator.dart';
import '../../views/widgets_globais/widget_erro.dart';
import '../api/repository.dart';
import '../model/professor.dart';

class DadosProfessor with ChangeNotifier {
  dynamic _fotoCapaPerfil;
  dynamic _fotoImagemPerfil;
  dynamic _horariosDisponibilidade;
  dynamic _materiasMinistradas;
  File? _imagemCapa;
  File? _imagemPerfil;
  late Professor professor;

  dynamic get fotoCapaPerfil => _fotoCapaPerfil;
  dynamic get fotoImagemPerfil => _fotoImagemPerfil;
  dynamic get horariosDisponibilidade => _horariosDisponibilidade;
  dynamic get materiasMinistradas => _materiasMinistradas;

  Future<bool> buscarDados(BuildContext context) async {
    mostrarDialogoDeCarregmento(context);
    final user = await buscarUser(context);
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

    File arquivo = await Cache.baixarImagem(
        "https://dev.ladesa.com.br/api/usuarios/${user.id}/imagem/capa");
    _fotoCapaPerfil = _imagemCapa == null
        ? Image.file(arquivo,
            fit: BoxFit.cover, alignment: AlignmentDirectional.bottomCenter)
        : Image.file(_imagemCapa!,
            fit: BoxFit.cover, alignment: AlignmentDirectional.bottomCenter);

    _fotoImagemPerfil = _imagemPerfil == null
        ? NetworkImage(
                "https://dev.ladesa.com.br/api/usuarios/${user.id}/imagem/perfil")
            as ImageProvider
        : FileImage(File(_imagemPerfil!.path));
    notifyListeners();
    return true;
  }

  Future<void> atualizarImagemCapaProvider(
      BuildContext context, File imagem) async {
    bool sucesso = await atualizarImagemCapa(imagem, context);
    if (sucesso) {
      _imagemCapa = imagem;
      return notifyListeners();
    } else {
      return error(context);
    }
  }

  Future<void> atualizarImagemPerfilProvider(
      BuildContext context, File imagem) async {
    bool sucesso = await atualizarImagemPerfil(imagem, context);
    if (sucesso) {
      _imagemPerfil = imagem;
      return notifyListeners();
    } else {
      return error(context);
    }
  }

  void apagarDados() {
    _fotoCapaPerfil = null;
    _fotoImagemPerfil = null;
    _horariosDisponibilidade = null;
    _materiasMinistradas = null;
    _imagemCapa = null;
    _imagemPerfil = null;
    professor = Professor(matricula: '', nome: '', email: '', id: '');
    Cache.limparCache();
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
        return dialogoDeErro(context);
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
