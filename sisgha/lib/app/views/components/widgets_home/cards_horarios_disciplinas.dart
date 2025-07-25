import 'package:flutter/material.dart';

import '../../../core/utils/icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/estilos.dart';
import '../../../core/utils/padroes.dart';
import '../../../domain/model/teste_disciplinas.dart';
import '../../../domain/model/teste_turmas.dart';

class ConstrutorHorarios extends StatefulWidget {
  const ConstrutorHorarios({super.key, required this.numero});
  final int numero;

  @override
  State<ConstrutorHorarios> createState() => _ConstrutorHorariosState();
}

class _ConstrutorHorariosState extends State<ConstrutorHorarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          physics: RangeMaintainingScrollPhysics(),
          itemCount: TesteTurma().turmas.length - widget.numero,
          itemBuilder: (context, index) {
            final turma = TesteTurma().turmas[index];
            final disciplina = TesteDisciplinas().disciplinas[index];
            return disciplinaprof(
                disciplina.nome, turma.nome, '08:00 - 09:00', context);
          },
        ),
      ),
    );
  }
}

Widget disciplinaprof(
    String materia, String turma, String horario, BuildContext context) {
  bool ativadoOuNao = _verificar(horario);

  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.only(left: 12, right: 5),
    height: Padroes.alturaGeral() * 0.10,
    decoration: BoxDecoration(
      border: Border.all(
          color: ativadoOuNao
              ? CoresClaras.verdePrincipalBorda
              : CoresClaras.verdecinzaBorda,
          width: 2),
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              materia,
              style: estiloTexto(15,
                  cor: ativadoOuNao
                      ? CoresClaras.pretoTexto
                      : CoresClaras.verdecinzaTexto,
                  peso: ativadoOuNao ? FontWeight.bold : FontWeight.normal),
            ),
            Text(
              turma,
              style: estiloTexto(15,
                  cor: ativadoOuNao
                      ? CoresClaras.pretoTexto
                      : CoresClaras.verdecinzaTexto,
                  peso: ativadoOuNao ? FontWeight.bold : FontWeight.normal),
            ),
            Text(
              'Horario: $horario',
              style: estiloTexto(15,
                  cor: ativadoOuNao
                      ? CoresClaras.pretoTexto
                      : CoresClaras.verdecinzaTexto,
                  peso: ativadoOuNao ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
        const Spacer(),
        ativadoOuNao
            ? const Icon(
                Icones.relogio,
                color: CoresClaras.verdeEscuro,
              )
            : Container(),
        const SizedBox(
          width: 10,
        )
      ],
    ),
  );
}

bool _verificar(String horario) {
  if (horario == '10:00 - 11:30') {
    return true;
  }
  return false;
}
