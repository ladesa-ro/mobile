// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisgha/app/data/providers/dados_professor.dart';
import 'package:sisgha/app/data/providers/escolha_horarios_alunos.dart';

import '../../data/armazenamento/shared_preferences.dart';
import 'login/login.dart';
import '../components/progress_indicator.dart';

class BoasVindasPage extends StatefulWidget {
  const BoasVindasPage({super.key});

  @override
  State<BoasVindasPage> createState() => _BoasVindasPageState();
}

class _BoasVindasPageState extends State<BoasVindasPage> {
  @override
  void initState() {
    super.initState();
    iniciarAplicacao();
  }

  Future<void> iniciarAplicacao() async {
    await Armazenamento.iniciar();
    bool tokenValido = await verificarToken();

    if (tokenValido) {
      DadosProfessor.iniciarProvider(context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PaginaLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Progressindicator(
          tamanho: 200,
        ),
      ),
    );
  }
}

Future<bool> verificarToken() async {
  Armazenamento arm = Armazenamento();
  return arm.token.isNotEmpty;
}
