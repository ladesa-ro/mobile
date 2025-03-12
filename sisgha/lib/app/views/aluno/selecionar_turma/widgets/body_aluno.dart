// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/responsividade.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';
import 'package:sisgha/app/data/providers/escolha_horarios_alunos.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdomn_turmas.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_ano.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_curso.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_formacao.dart';

class BodyAluno extends StatefulWidget {
  const BodyAluno({super.key});

  @override
  State<BodyAluno> createState() => _BodyAlunoState();
}

class _BodyAlunoState extends State<BodyAluno> {
  bool abrirCurso = false;

  void abrirDropdownCurso() {
    setState(() {
      abrirCurso = true;
    });
  }

  bool abrirAno = false;
  bool abrirTurma = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EscolhaHorariosAlunos>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        physics: Tamanhos.efeitoDeRolagem(),
        children: [
          SizedBox(height: TamanhoTela.vertical(context) * 0.1),
          Row(
            children: [
              Icon(Icones.Relogio),
              SizedBox(width: TamanhoTela.horizontal(context) * 0.08),
              Text("Selecionar Horário",
                  style: TextStyle(
                      fontSize: TamanhoTela.horizontal(context) * 0.05,
                      fontWeight: FontWeight.w700)),
            ],
          ),

          SizedBox(height: TamanhoTela.vertical(context) * 0.02),

          // Dropdown de Formação
          DropdownFormacao(
            direita: 10,
            esquerda: 10,
            descricao: "Formação",
            onChanged: (value) {
              provider.selecionarFormacao(value);
              abrirCurso = true;
            },
          ),

          SizedBox(height: TamanhoTela.vertical(context) * 0.02),

          // Dropdown de Curso
          DropdownCurso(
            direita: 10,
            esquerda: 10,
            descricao: "Curso",
            onChanged: (value) {
              provider.selecionarCurso(value);
              abrirAno = true;
            },
            abrirDropdown: abrirCurso,
          ),

          SizedBox(height: TamanhoTela.vertical(context) * 0.02),
          //dropdow do ano
          DropdownAno(
            direita: 10,
            esquerda: 10,
            descricao: "Ano",
            onChanged: (value) {
              provider.selecionarAno(value);
              abrirTurma = true;
            },
            abrirDropdown: abrirAno,
          ),

          SizedBox(height: TamanhoTela.vertical(context) * 0.02),
          //dropdown da turma
          DropdownTurmas(
            direita: 10,
            esquerda: 10,
            descricao: "Turmas",
            onChanged: (value) {
              provider.selecionarTurma(value);
            },
            abrirDropdown: abrirTurma,
          ),

          SizedBox(height: TamanhoTela.vertical(context) * 0.02),

          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: tudoSelecionado()
                      ? () {
                          Navigator.of(context).pushNamed('/navegação');
                        }
                      : null,
                  style: _estiloBotao(),
                  child: const Text("Ver Horário"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ButtonStyle _estiloBotao() {
    return ElevatedButton.styleFrom(
      backgroundColor:
          tudoSelecionado() ? CoresClaras.verdePrincipal : CoresClaras.cinza,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding:
          EdgeInsets.symmetric(vertical: TamanhoTela.vertical(context) * 0.04),
    );
  }

  bool tudoSelecionado() {
    var provider = Provider.of<EscolhaHorariosAlunos>(context);
    return provider.formacaoSelecionada != null &&
        provider.cursoSelecionado != null &&
        provider.anoSelecionado != null &&
        provider.turmaSelecionada != null;
  }
}
