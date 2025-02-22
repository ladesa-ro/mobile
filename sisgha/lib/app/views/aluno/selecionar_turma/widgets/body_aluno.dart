// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdomn_turmas.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown-ano.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_curso.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_formacao.dart';

import '../../../components/botton_app_bar.dart';

class BodyAluno extends StatefulWidget {
  const BodyAluno({super.key});

  @override
  State<BodyAluno> createState() => _BodyAlunoState();
}

class _BodyAlunoState extends State<BodyAluno> {
  bool isClicked = false;
  String? selectedFormacao;
  String? selectedCurso;
  String? selectedAno;
  String? selectedTurma;

  bool tudoSelecionado() {
    return selectedFormacao != null &&
        selectedCurso != null &&
        selectedAno != null &&
        selectedTurma != null;
  }

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
            direita: 0,
            esquerda: 6,
            descricao: "formação",
            onChanged: (value) {
              setState(() {
                selectedFormacao = value;
              });
            },
          ),

          SizedBox(height: 20),

          // Dropdown de Curso
          DropdownCurso(
            nome: "",
            direita: 0,
            esquerda: 10,
            descricao: "curso",
            onChanged: (value) {
              setState(() {
                selectedCurso = value;
              });
            },
          ),

          SizedBox(height: 20),

          // Dropdown de Ano
          DropdownAno(
            nome: "",
            direita: 0,
            esquerda: 5,
            descricao: "Ano",
            onChanged: (value) {
              setState(() {
                selectedAno = value;
              });
            },
          ),

          SizedBox(height: 20),

          // Dropdown de Turmas
          DropdownTurmas(
            nome: "",
            direita: 0,
            esquerda: 5,
            descricao: "Turmas",
            onChanged: (value) {
              setState(() {
                selectedTurma = value;
              });
            },
          ),

          SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: tudoSelecionado()
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Navigation(initialIndex: 1),
                            ),
                          );
                        }
                      : null, // Se não tiver tudo selecionado, o botão fica desativado
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tudoSelecionado()
                        ? ColorsTemaClaro.verdePrincipal
                        : ColorsTemaClaro.cinza,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Bordas levemente arredondadas
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 30), // Aumenta pra cima e pra baixo
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
