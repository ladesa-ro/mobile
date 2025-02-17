// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdomn-turmas.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown-ano.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_curso.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_formacao.dart';
import 'package:sisgha/app/views/home/home_alunos/home_alunos.dart';

class BodyAluno extends StatefulWidget {
  const BodyAluno({super.key});

  @override
  State<BodyAluno> createState() => _BodyAlunoState();
}

class _BodyAlunoState extends State<BodyAluno> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          SizedBox(height: 70),

          Row(
            children: [
              Icon(Icones.Relogio),
              SizedBox(width: 8),
              Text(
                "Selecionar Horário",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Dropdown de Formação
          DropdownFormacao(
            nome: "",
            direita: 6,
            esquerda: 6,
            descricao: "formação",
          ),

          SizedBox(height: 20),

          // Dropdown de Curso
          DropdownCurso(
            nome: "",
            direita: 0,
            esquerda: 10,
            descricao: "curso",
          ),

          SizedBox(height: 20),

          // Dropdown de Ano
          DropdownAno(
            nome: "",
            direita: 0,
            esquerda: 5,
            descricao: "Ano",
          ),

          SizedBox(height: 20),

          // Dropdown de Turmas
          DropdownTurmas(
            nome: "",
            direita: 0,
            esquerda: 5,
            descricao: "Turmas",
          ),

          SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    setState(() {
                      isClicked = !isClicked; // Alterna o estado do botão
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeAlunos()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isClicked
                        ? ColorsTemaClaro
                            .verdePrincipal // Cor verde quando clicado
                        : ColorsTemaClaro.cinza, // Cor cinza quando não clicado
                    foregroundColor: Colors.white, // Cor do texto
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Ver Horário"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
