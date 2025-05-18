import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/padroes.dart';
import 'package:sisgha/app/providers/escolha_horarios_alunos.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/tests/card_curso.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/tests/card_formacao.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/tests/card_turma.dart';

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EscolhaHorariosAlunos>(context);

    bool botaoAtivo = provider.idFormacaoSelecionada != null &&
            provider.cursoSelecionado != null &&
            provider.turmaSelecionada != null
        ? true
        : false;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView(
          shrinkWrap: true,
          physics: Padroes.efeitoDeRolagem(),
          padding: Padroes.margem(),
          children: [
            Row(
              children: [
                Text(
                  'Selecionar Horario',
                  style: estiloTexto(15, peso: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(Icones.relogio)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RepaintBoundary(child: CardFormacao()),
            SizedBox(height: 20),
            RepaintBoundary(child: CardCurso()),
            SizedBox(height: 20),
            RepaintBoundary(child: CardTurma()),
            SizedBox(height: 20),
            ElevatedButton(
              style: buttonStyle(),
              onPressed: () => botaoAtivo
                  ? Navigator.of(context).pushNamed('/navegação')
                  : null,
              child: Text(
                'Ver Horário',
                style: estiloTexto(16,
                    cor: CoresClaras.brancoTexto, peso: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
          Size(double.infinity, Padroes.aluturaBotoes())),
      maximumSize: WidgetStatePropertyAll(
          Size(double.infinity, Padroes.aluturaBotoes())),
      backgroundColor: WidgetStatePropertyAll(CoresClaras.verdePrincipalBotao),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          side: BorderSide(color: CoresClaras.verdePrincipalBorda),
          borderRadius: BorderRadiusGeometry.circular(15))),
    );
  }
}
