// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_aluno.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          Center(
            child: Text(
              "Selecione sua Turma",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
          ),
          //
          SizedBox(
            height: 20,
          ),
          //
          DropdownAluno(
            nome: "Formação",
            direita: 6,
            esquerda: 6,
            descricao: "Selecione um nível de formação",
          ),
          //
          SizedBox(
            height: 20,
          ),
          //
          Row(
            children: const [
              SizedBox(
                width: 180,
                child: DropdownAluno(
                  nome: "Curso",
                  direita: 0,
                  esquerda: 10,
                  descricao: "Selecione o curso",
                ),
              ),
              SizedBox(
                width: 8,
              ),
              //
              SizedBox(
                width: 160,
                child: DropdownAluno(
                  nome: "Turma",
                  direita: 0,
                  esquerda: 5,
                  descricao: "Turmas",
                ),
              ),
            ],
          ),
          //
          SizedBox(
            height: 20,
          ),
          //
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  child: Icon(
                    Icons.search,
                    size: 40,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
