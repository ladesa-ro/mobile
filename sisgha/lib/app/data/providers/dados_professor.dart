// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/data/armazenamento/shared_preferences.dart';
import 'package:sisgha/app/domain/logic/verificar_imagem_armazenada.dart';
import 'package:sisgha/app/views/components/progress_indicator.dart';

import '../../views/components/botton_app_bar.dart';
import '../../views/components/widget_erro.dart';
import '../../domain/api/repository.dart';
import '../../domain/model/professor.dart';

class DadosProfessor with ChangeNotifier {
  late File _fotoCapaPerfil;
  late File _fotoImagemPerfil;
  late Professor professor;

  File get fotoCapaPerfil => _fotoCapaPerfil;
  File get fotoImagemPerfil => _fotoImagemPerfil;
  File AlterarFotoCapaPerfil(File value) => _fotoCapaPerfil = value;
  File AlterarFotoImagemPerfil(File value) => _fotoImagemPerfil = value;

  Future<bool> buscarDados(BuildContext context) async {
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

    _fotoCapaPerfil = await VerificarImagemArmazenada.verificador(
        Armazenamento().localImagemCapa, 0);
    _fotoImagemPerfil = await VerificarImagemArmazenada.verificador(
        Armazenamento().localImagemPerfil, 1);
    notifyListeners();
    return true;
  }

  Future<void> atualizarImagemCapaProvider(
      BuildContext context, File imagem) async {
    await Repository.atualizarImagemCapa(imagem, context);

    _fotoCapaPerfil = imagem.absolute;

    return notifyListeners();
  }

  Future<void> atualizarImagemPerfilProvider(
      BuildContext context, File imagem) async {
    await Repository.atualizarImagemPerfil(imagem, context);

    _fotoImagemPerfil = imagem.absolute;
    return notifyListeners();
  }

  void apagarDados() {
    _fotoCapaPerfil = File('');
    _fotoImagemPerfil = File('');
    professor = Professor(matricula: '', nome: '', email: '', id: '');
    notifyListeners();
  }

  static void iniciarProvider(BuildContext context) async {
    mostrarDialogoDeCarregmento(context);
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
