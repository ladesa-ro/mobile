import 'package:flutter/material.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/app_bar_aluno.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/body_aluno.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/teste.dart';

class PaginaAlunoSelec extends StatelessWidget {
  const PaginaAlunoSelec({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarAluno(),
      body: Teste(),
    );
  }
}
