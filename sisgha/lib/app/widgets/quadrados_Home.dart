import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';

Widget Quadrados_Home(context) {
  return Container(
    foregroundDecoration: BoxDecoration(),
    decoration: BoxDecoration(
        color: ColorApp.Branco,
        border: Border.all(
            color: ColorApp.VerdeEscuro,
            width: 1.0,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignInside),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15))),
    width: TamanhoTela.horizontal(context) / 8,
    height: TamanhoTela.vertical(context) / 12,
    child: Column(
      children: [
        Spacer(),
        Text(
          'Seg',
          style: estiloTexto(15, cor: ColorApp.VerdeEscuro),
        ),
        Spacer(),
        Container(
          width: 30,
          height: 2,
          color: ColorApp.VerdeEscuro,
        ),
        Spacer(),
        Text('${DatasFormatadas.DiaAgora}',
            style: estiloTexto(15, cor: ColorApp.VerdeEscuro)),
        Spacer()
      ],
    ),
  );
}

Widget ConstruindoQuadrados(context) {
  return Row(
    children: [
      Spacer(),
      Quadrados_Home(context),
      Spacer(),
      Quadrados_Home(context),
      Spacer(),
      Quadrados_Home(context),
      Spacer(),
      Quadrados_Home(context),
      Spacer(),
      Quadrados_Home(context),
      Spacer(),
      Quadrados_Home(context),
      Spacer(),
    ],
  );
}
