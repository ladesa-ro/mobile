// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/padroes.dart';
import 'package:sisgha/app/domain/api/repository.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_turma.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_curso.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/dropdown_formacao.dart';
import 'package:sisgha/app/providers/escolha_horarios_alunos.dart';

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

  bool abrirTurma = false;
  @override
  void initState() {
    super.initState();

    setState(() {
      abrirCurso = false;

      abrirTurma = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<EscolhaHorariosAlunos>(
        builder: (context, provider, child) => ListView(
          physics: Padroes.efeitoDeRolagem(),
          children: [
            SizedBox(height: Padroes.alturaGeral() * 0.1),
            Row(
              children: [
                Icon(Icones.relogio),
                SizedBox(width: Padroes.larguraGeral() * 0.02),
                Text("Selecionar Horário",
                    style: TextStyle(
                        fontSize: Padroes.larguraGeral() * 0.05,
                        fontWeight: FontWeight.w700)),
              ],
            ),

            SizedBox(height: Padroes.alturaGeral() * 0.02),

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

            SizedBox(height: Padroes.alturaGeral() * 0.02),

            // Dropdown de Curso
            DropdownCurso(
              descricao: 'Curso',
              direita: 10,
              esquerda: 10,
              abrirDropdown: abrirCurso,
              onChanged: (value) {
                if (value != null) {
                  final provider = Provider.of<EscolhaHorariosAlunos>(context,
                      listen: false);
                  provider.selecionarCurso(value); // Seta o curso no estado

                  setState(() {
                    abrirTurma = true; // Mostra o DropdownAno
                  });
                }
              },
            ),

            SizedBox(height: Padroes.alturaGeral() * 0.02),

            DropdownTurma(
              direita: 10,
              esquerda: 10,
              descricao: "Turma",
              onChanged: (value) {
                provider.selecionarTurma(value);
                abrirTurma = true;
              },
              abrirDropdown: abrirTurma,
            ),

            SizedBox(height: Padroes.alturaGeral() * 0.02),

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
                    //style: Padroes.estiloBotao(),
                  ),
                ),
              ],
            ),
          ],
        ),
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
      minimumSize: Size(
        Padroes.larguraGeral(),
        Padroes.aluturaBotoes(),
      ),
      maximumSize: Size(
        Padroes.larguraGeral(),
        Padroes.aluturaBotoes(),
      ),
    );
  }

  bool tudoSelecionado() {
    var provider = Provider.of<EscolhaHorariosAlunos>(context);
    return provider.idFormacaoSelecionada != null &&
        provider.cursoSelecionado != null &&
        provider.turmaSelecionada != null;
  }
}
