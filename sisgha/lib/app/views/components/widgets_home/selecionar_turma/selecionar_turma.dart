import 'package:flutter/material.dart';
import 'package:sisgha/app/views/components/widgets_home/selecionar_turma/widgets/app_bar_aluno.dart';
import 'package:sisgha/app/views/components/widgets_home/selecionar_turma/widgets/body_aluno.dart';

class PaginaAlunoSelec extends StatelessWidget {
  const PaginaAlunoSelec({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarAluno(),
      body: BodyAluno(),
    );
  }
}
