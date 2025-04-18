// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../views/components/botton_app_bar.dart';
import '../../views/components/progress_indicator.dart';
import '../../views/components/widget_erro.dart';
import '../../domain/api/repository.dart';
import '../../domain/model/professor.dart';

class DadosProfessor with ChangeNotifier {
  late File _fotoCapaPerfil;
  late File _fotoImagemPerfil;
  late Professor _professor;

  Professor get professor => _professor;
  File get fotoCapaPerfil => _fotoCapaPerfil;
  File get fotoImagemPerfil => _fotoImagemPerfil;

  void alterarFotoCapaPerfil(File value) {
    _fotoCapaPerfil = value;
    notifyListeners();
  }

  void alterarFotoImagemPerfil(File value) {
    _fotoImagemPerfil = value;
    notifyListeners();
  }

  void carregarDadosDoUsuario(Professor user) {
    _professor = user;
  }

  Future<bool> buscarDados(BuildContext context) async {
    final user = await Repository.buscarUser(context);
    carregarDadosDoUsuario(user);

    await carregarImagens();
    notifyListeners();

    return true;
  }

  Future<void> carregarImagens() async {
    _fotoCapaPerfil = await Repository.baixarImagemCapa(_professor.id);
    _fotoImagemPerfil = await Repository.baixarImagemPerfil(_professor.id);
  }

  Future<void> atualizarImagemCapa(BuildContext context, File imagem) async {
    await Repository.atualizarImagemCapa(imagem, context);
    alterarFotoCapaPerfil(imagem);
  }

  Future<void> atualizarImagemPerfil(BuildContext context, File imagem) async {
    await Repository.atualizarImagemPerfil(imagem, context);
    alterarFotoImagemPerfil(imagem);
  }

  void apagarDados() {
    _fotoCapaPerfil = File('');
    _fotoImagemPerfil = File('');
    _professor = Professor.empty();
    notifyListeners();
  }

  Future<void> iniciarProvider(BuildContext context) async {
    _mostrarDialogoDeCarregamento(context);

    final dados = DadosProfessor();
    final sucesso = await dados.buscarDados(context);

    Navigator.of(context).pop(); // fecha o diálogo de carregamento

    if (sucesso) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: dados,
            child: Navigation(initialIndex: 1),
          ),
        ),
        (_) => false,
      );
    } else {
      _mostrarErro(context);
    }
  }

  static void _mostrarErro(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => dialogoDeErro(context, 'Erro ao carregar dados.'),
    );
  }

  static void _mostrarDialogoDeCarregamento(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const AlertDialog(
        content: Progressindicator(tamanho: 200),
      ),
    );
  }
}
