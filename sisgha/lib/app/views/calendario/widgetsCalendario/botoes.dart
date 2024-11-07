import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';

Widget container() {
  return LayoutBuilder(
    builder: (context, constraints) => Container(
      height: constraints.maxHeight,
      width: constraints.maxWidth,
      decoration:
          estiloBorda(cor: ColorApp.VerdeCinza, radius: 15, grossuraBorda: 2),
    ),
  );
}
