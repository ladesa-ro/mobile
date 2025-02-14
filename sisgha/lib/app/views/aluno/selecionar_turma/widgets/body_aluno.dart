// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdomn-turmas.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown-ano.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_curso.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_formacao.dart';

class BodyAluno extends StatefulWidget {
  const BodyAluno({super.key});

  @override
  State<BodyAluno> createState() => _BodyAlunoState();
}

class _BodyAlunoState extends State<BodyAluno> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),

          Row(
            children: [
              Icon(Icons.loupe_sharp), // temporario ainda n achei o certo kkkkk 
              SizedBox(
                width: 8,
              ),
              Text(
                "Selecionar Horário",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),

          //
          DropdownFormacao(
            nome: "",
            direita: 6,
            esquerda: 6,
            descricao: "formação",
          ),
          //
          SizedBox(
            height: 20,
          ),
          //

          DropdownCurso(
            nome: "",
            direita: 0,
            esquerda: 10,
            descricao: "curso",
          ),

          SizedBox(
            height: 20,
          ),

          DropdownAno(
            nome: "",
            direita: 0,
            esquerda: 5,
            descricao: "Ano",
          ),

          SizedBox(
            height: 20,
          ),
          DropdownTurmas(
            nome: "",
            direita: 0,
            esquerda: 5,
            descricao: "Turmas",
          ),

          SizedBox(
            height: 20,
          ),

          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    // Use ElevatedButton.styleFrom
                    backgroundColor:
                        ColorsTemaClaro.cinza, // Set background color here
                    foregroundColor: Colors.white, // Text color (optional)
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
          )
        ],
      ),
    );
  }
}
