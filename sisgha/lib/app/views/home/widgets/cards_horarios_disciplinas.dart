import 'package:flutter/material.dart';

import '../../../core/utils/Icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/estilos.dart';
import '../../../core/utils/responsividade.dart';
import '../../../core/utils/tamanhos.dart';

class ConstrutorHorarios extends StatefulWidget {
  final String materia;
  final String turma;
  final String horario;

  const ConstrutorHorarios({
    super.key,
    required this.materia,
    required this.turma,
    required this.horario,
  });

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
          padding: Tamanhos.margem(context),
          physics: RangeMaintainingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return disciplinaprof(
                widget.materia, widget.turma, widget.horario, context);
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
    height: TamanhoTela.vertical(context) * 0.10,
    decoration: BoxDecoration(
      border: Border.all(
          color: ativadoOuNao
              ? ColorsTemaClaro.verdePrincipalBorda
              : ColorsTemaClaro.verdecinzaBorda,
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
                      ? ColorsTemaClaro.pretoTexto
                      : ColorsTemaClaro.verdecinzaTexto,
                  peso: ativadoOuNao ? FontWeight.bold : FontWeight.normal),
            ),
            Text(
              turma,
              style: estiloTexto(15,
                  cor: ativadoOuNao
                      ? ColorsTemaClaro.pretoTexto
                      : ColorsTemaClaro.verdecinzaTexto,
                  peso: ativadoOuNao ? FontWeight.bold : FontWeight.normal),
            ),
            Text(
              'Horario: $horario',
              style: estiloTexto(15,
                  cor: ativadoOuNao
                      ? ColorsTemaClaro.pretoTexto
                      : ColorsTemaClaro.verdecinzaTexto,
                  peso: ativadoOuNao ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
        const Spacer(),
        ativadoOuNao
            ? const Icon(
                Icones.Relogio,
                color: ColorsTemaClaro.verdeEscuro,
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
