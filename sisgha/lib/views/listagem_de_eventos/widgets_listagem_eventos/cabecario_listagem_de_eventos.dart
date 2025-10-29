import 'package:flutter/material.dart';
import 'package:sisgha/core/utils/estilos.dart';
import 'package:sizer/sizer.dart';

Widget cabecarioListagemDeEventos(BuildContext ctx, ColorScheme tema) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Container(
            width: 1.5.w,
            height: 4.h,
            decoration: BoxDecoration(
                color: tema.primaryContainer,
                borderRadius: BorderRadius.circular(8)),
          ),
          const SizedBox(width: 8),
          Text(
            'Eventos',
            style: estiloTexto(
              19,
              peso: FontWeight.bold,
              cor: tema.primary,
            ),
          ),
        ],
      ),
      const Spacer(),
      IconButton(
        color: tema.onSecondaryFixedVariant,
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(ctx).pop(),
      ),
    ],
  );
}
