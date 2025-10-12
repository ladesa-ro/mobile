import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import 'package:sizer/sizer.dart';

import '../../core/utils/icones.dart';

Widget elementoVerde(Alignment alignment, ColorScheme tema) {
  BorderRadiusGeometry borderRadius = BorderRadius.zero;
  borderRadius = verificarLadoDoElementoVerde(alignment);

  return Align(
    alignment: alignment,
    child: Container(
      width: 30.w,
      height: 15.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            tema.primaryContainer,
            tema.secondaryContainer,
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
    icon: Iconify(
      senhaVisivel ? Icones.visibilidadeSenhaOn : Icones.visibilidadeSenhaOff,
      size: 3.h,
    ),
  );
}
