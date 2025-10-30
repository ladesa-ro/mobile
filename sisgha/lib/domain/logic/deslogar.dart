// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/viewmodels/escolha_horarios_alunos.dart';

import '../../repository/repository.dart';

Future widgetQuit(BuildContext context) async {
  if (await Repository.sair(context)) {
    context.read<EscolhaHorariosAlunos>().resetarEscolhas();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
  }
}
