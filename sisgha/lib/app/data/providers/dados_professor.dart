// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/data/api/repository.dart';
import 'package:sisgha/app/data/model/professor.dart';

import '../../views/widgets_globais/botton_app_bar.dart';
import '../../views/widgets_globais/widget_erro.dart';

class DadosProfessor with ChangeNotifier {
  dynamic _fotoCapaPerfil;
  dynamic _fotoImagemPerfil;
  dynamic _horariosDisponibilidade;
  dynamic _materiasMinistradas;
  File? _imagemCapa;
  File? _imagemPerfil;
  Professor professor =
      Professor(matricula: 'matricula', nome: 'nome', email: 'email', id: 'id');

  dynamic get fotoCapaPerfil => _fotoCapaPerfil;
  dynamic get fotoImagemPerfil => _fotoImagemPerfil;
  dynamic get horariosDisponibilidade => _horariosDisponibilidade;
  dynamic get materiasMinistradas => _materiasMinistradas;

  Future<bool> buscarDados(BuildContext context) async {
    final user = await buscarUser(context);
    professor = Professor(
        matricula: user.matricula,
        nome: user.nome,
        email: user.email,
        id: user.id);
    _fotoCapaPerfil = _imagemCapa == null
        ? Image.network(
            "https://dev.ladesa.com.br/api/usuarios/${user.id}/imagem/capa",
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.bottomCenter)
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

  Future<void> atualizarImagemCap(BuildContext context, File imagem) async {
    bool sucesso = await atualizarImagemCapa(imagem, context);
    if (sucesso) {
      _imagemCapa = imagem;
      notifyListeners();
      return;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialogoDeErro(context);
        },
      );
    }
  }

  Future<void> atualizarImagemPerfi(BuildContext context, File imagem) async {
    bool sucesso = await atualizarImagemPerfil(imagem, context);
    if (sucesso) {
      _imagemPerfil = imagem;
      notifyListeners();
      return;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialogoDeErro(context);
        },
      );
    }
  }

  static void iniciarProvider(BuildContext context) async {
    final dados = DadosProfessor();
    await dados.buscarDados(context);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => dados,
          child: Navigation(initialIndex: 1),
        ),
      ),
      (route) => false,
    );
  }
}
