// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/cache/etapas_calendario.dart';
import 'package:sisgha/app/domain/api/repository.dart';
import 'package:sisgha/app/domain/logic/verificar_dados_armazenados.dart';
import 'package:sisgha/app/domain/model/etapas.dart';

import '../../cache/dados_professor.dart';
import '../../cache/escolha_horarios_alunos.dart';
import '../components/progress_indicator.dart';

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
    final etapas = EtapasCalendario();
    await context.read<EscolhaHorariosAlunos>().pucharOpcoes();
    await Repository.testeBuscarTurmas();
    await Repository.testeBuscarDisciplinas();
    await etapas.adicionarEtapas();

    if (await verificarDadosBaixados()) {
      await context.read<DadosProfessor>().iniciarProvider(context, true);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PaginaLogin()),
      );
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
