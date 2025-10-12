import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';

import 'package:sisgha/core/utils/icones.dart';
import 'package:sisgha/core/utils/estilos.dart';
import 'package:sizer/sizer.dart';

import '../core/theme/tema_provider.dart';

Widget mostrarDialogoDeTrocaDeTema(
    BuildContext context, String text, ColorScheme tema) {
  final provider = Provider.of<TemasProvider>(context);
  bool temaAtual = provider.temaAtivo.brightness == Brightness.light;
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 2.h),
        Iconify(
          temaAtual ? Icones.lua : Icones.sol,
          color: tema.onSecondaryFixedVariant,
          size: 3.h,
        ),
        SizedBox(height: 1.5.h),
        Text(
          "Modificar tema",
          style: estiloTexto(16, cor: tema.primary, peso: FontWeight.bold),
        ),
        SizedBox(height: 0.5.h),
        Text(
          "Deseja modificar o tema para $text",
          style: estiloTexto(14, cor: tema.primary, peso: FontWeight.bold),
        ),
        SizedBox(height: 1.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: _estiloBotao(tema.errorContainer),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Text(
                    "Não  ",
                    style:
                        estiloTexto(14, cor: tema.error, peso: FontWeight.bold),
                  ),
                  Icon(
                    Icons.close,
                    color: tema.error,
                  ),
                ],
              ),
            ),
            SizedBox(width: 3.w),
            ElevatedButton(
              style: _estiloBotao(tema.onPrimary),
              onPressed: () {
                provider.mudarTema();
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Text(
                    "Sim  ",
                    style: estiloTexto(14,
                        cor: tema.secondary, peso: FontWeight.bold),
                  ),
                  Icon(
                    Icons.done,
                    color: tema.secondaryFixed,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    ),
  );
}

_estiloBotao(Color cor) {
  return ButtonStyle(
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w),
          side: BorderSide(color: cor))));
}
