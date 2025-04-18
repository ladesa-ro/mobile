// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/providers/dados_professor.dart';
import '../../data/providers/escolha_horarios_alunos.dart';
import '../../domain/model/token.dart';
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
    await context.read<EscolhaHorariosAlunos>().pucharOpcoes();

    if (Token.token.isNotEmpty) {
      await context.read<DadosProfessor>().iniciarProvider(context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PaginaLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Progressindicator(tamanho: 200)),
    );
  }
}
