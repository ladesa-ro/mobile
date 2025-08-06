// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/domain/api/repository.dart';
import 'package:sisgha/app/domain/logic/verificar_dados_armazenados.dart';

import '../../cache/dados_professor.dart';
import '../../cache/escolha_horarios_alunos.dart';
import '../components/progress_indicator.dart';

import '../components/widget_erro.dart';
import 'login/login.dart';

class BoasVindasPage extends StatefulWidget {
  const BoasVindasPage({super.key});

  @override
  State<BoasVindasPage> createState() => _BoasVindasPageState();
}

class _BoasVindasPageState extends State<BoasVindasPage> {
  @override
  void initState() {
    super.initState();
    _iniciar();
  }

  Future<void> _iniciar() async {
    try {
      await Future.delayed(const Duration(seconds: 7), () async {
        await context.read<EscolhaHorariosAlunos>().pucharOpcoes();
        await Repository.testeBuscarTurmas();
        await Repository.testeBuscarDisciplinas();
        if (await verificarDadosBaixados()) {
          await context.read<DadosProfessor>().iniciarProvider(context, true);
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const PaginaLogin()),
          );
        }
      });
    } on TimeoutException {
      showDialog(
          context: context, builder: (context) => dialogoDeErro(context));
    } catch (e) {
      showDialog(
          context: context, builder: (context) => dialogoDeErro(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Progressindicator(
        tamanho: 200,
      )),
    );
  }
}
