import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';

Widget disciplinaprof(
    String materia, String turma, String horario, BuildContext context) {
  bool ativadoOuNao = _verificar(horario);

  return Container(
    margin: const EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
    padding: const EdgeInsets.only(left: 12, right: 5),
    height: TamanhoTela.vertical(context) * 0.15,
    decoration: BoxDecoration(
      border: Border.all(
          color: ativadoOuNao ? ColorApp.VerdePrincipal : ColorApp.VerdeCinza,
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
                  cor: ativadoOuNao ? ColorApp.Preto : ColorApp.VerdeCinza,
                  peso: ativadoOuNao ? FontWeight.bold : FontWeight.normal),
            ),
            Text(
              turma,
              style: estiloTexto(15,
                  cor: ativadoOuNao ? ColorApp.Preto : ColorApp.VerdeCinza,
                  peso: ativadoOuNao ? FontWeight.bold : FontWeight.normal),
            ),
            Text(
              'Horario: $horario',
              style: estiloTexto(15,
                  cor: ativadoOuNao ? ColorApp.Preto : ColorApp.VerdeCinza,
                  peso: ativadoOuNao ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
        const Spacer(),
        ativadoOuNao
            ? const Icon(
                Icones.Relogio,
                color: ColorApp.VerdePrincipal,
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
