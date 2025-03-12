// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/armazenamento/shared_preferences.dart';
import '../../data/providers/dados_professor.dart';
import '../../data/providers/escolha_horarios_alunos.dart';
import 'login/login.dart';
import '../components/progress_indicator.dart';

class BoasVindasPage extends StatefulWidget {
  const BoasVindasPage({super.key});

  @override
  State<BoasVindasPage> createState() => _BoasVindasPageState();
}

class _BoasVindasPageState extends State<BoasVindasPage> {
  Future<void> iniciarApp(BuildContext context) async {
    await Provider.of<EscolhaHorariosAlunos>(context).pucharOpcoes();
    Armazenamento.iniciar();
    bool tokenAtivo = await verificarToken();
    if (tokenAtivo) {
      return DadosProfessor.iniciarProvider(context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PaginaLogin(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: iniciarApp(context),
            builder: (ctx, snapshot) =>
                Center(child: Progressindicator(tamanho: 200))));
  }
}

Future<bool> verificarToken() async {
  if (Armazenamento().token == "") {
    return false;
  } else {
    return true;
  }
}
