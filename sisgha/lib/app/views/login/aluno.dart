import 'package:flutter/material.dart';

class PaginaAluno extends StatelessWidget {
  const PaginaAluno({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "Acesso do aluno",
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
