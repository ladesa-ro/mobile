import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/padroes.dart';
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
            RepaintBoundary(child: CardCurso()),
            RepaintBoundary(child: CardTurma()),
            ElevatedButton(onPressed: () {}, child: Text('Ver Horário')),
          ],
        ),
      ],
    );
  }
}
