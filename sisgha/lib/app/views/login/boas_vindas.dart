// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisgha/app/data/providers/dados_professor.dart';
import 'package:sisgha/app/data/providers/escolha_horarios_alunos.dart';

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

    Timer(const Duration(milliseconds: 2550), () {
      const Progressindicator(
        tamanho: 200,
      );
      verificarToken().then((value) {
        if (value) {
          DadosProfessor.iniciarProvider(context);
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const PaginaLogin(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<EscolhaHorariosAlunos>(context).pucharOpcoes(context),
      builder: (context, snapshot) => Scaffold(
        body: Center(
          child: Progressindicator(
            tamanho: 200,
          ),
        ),
      ),
    );
  }
}

Future<bool> verificarToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("token") == null) {
    return false;
  } else {
    return true;
  }
}
