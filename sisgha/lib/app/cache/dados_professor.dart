// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisgha/app/cache/escolha_calendario.dart';
import 'package:sisgha/app/cache/etapas_calendario.dart';
import 'package:sisgha/app/cache/lista_eventos.dart';

import '../views/components/botton_app_bar.dart';
import '../domain/api/repository.dart';
import '../domain/model/professor.dart';

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

  Future buscarDados(BuildContext context) async {
    final user = await Repository.buscarUser(context);
    carregarDadosDoUsuario(user);

    await carregarImagens();
    notifyListeners();
  }

  Future carregarDados() async {
    SharedPreferences armazenamento = await SharedPreferences.getInstance();
    final user = Professor(
        matricula: armazenamento.getString("matricula")!,
        nome: armazenamento.getString("nome")!,
        email: armazenamento.getString("email")!,
        id: armazenamento.getString("id")!);
    carregarDadosDoUsuario(user);
    await carregarImagens();

    notifyListeners();
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

  Future<void> iniciarProvider(BuildContext context, bool verificado) async {
    final dados = DadosProfessor();
    verificado ? await dados.carregarDados() : await dados.buscarDados(context);
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<DadosProfessor>.value(
          value: dados,
          child: Navigation(initialIndex: 1),
        ),
      ),
      (_) => false,
    );
  }
}
