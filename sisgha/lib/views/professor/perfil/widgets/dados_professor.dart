import 'package:flutter/material.dart';

import '../../../../core/utils/estilos.dart';

Widget dadosUsuario(BuildContext context, String nome, String email,
    String matricula, double espacamento, ColorScheme tema) {
  return Column(
    children: [
      Text(
        'Professor(a) $nome',
        style: estiloTexto(16, cor: tema.primary, peso: FontWeight.bold),
      ),
      SizedBox(height: espacamento),
      Text(
        'E-mail: $email',
        style: estiloTexto(14, cor: tema.tertiary, peso: FontWeight.bold),
      ),
      SizedBox(height: espacamento),
      Text(
        'Matrícula: $matricula',
        style: estiloTexto(14, cor: tema.tertiary, peso: FontWeight.bold),
      ),
    ],
  );
}
