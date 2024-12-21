import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/colors.dart';

Widget elementoVerde(Alignment alignment) {
  BorderRadiusGeometry borderRadius = BorderRadius.zero;
  borderRadius = verificarLadoDoElementoVerde(alignment);

  return Align(
    alignment: alignment,
    child: Container(
      width: 30.w,
      height: 15.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorApp.VerdePrincipal,
            ColorApp.VerdeClaro,
          ],
        ),
        borderRadius: borderRadius,
      ),
    ),
  );
}

BorderRadius verificarLadoDoElementoVerde(Alignment alignment) {
  return alignment == Alignment.topLeft
      ? BorderRadius.only(bottomRight: Radius.circular(5.h))
      : BorderRadius.only(topLeft: Radius.circular(5.h));
}

const snackBar = SnackBar(
  content: Text(
    "Matricula ou senha inválidos",
    textAlign: TextAlign.center,
  ),
);

Widget iconeVisibilidadeSenha(alternarVisibilidadeSenha, senhaVisivel) {
  return IconButton(
    onPressed: alternarVisibilidadeSenha,
    icon: Icon(senhaVisivel
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined),
  );
}
