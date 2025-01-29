import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';
import 'responsividade.dart';

class Tamanhos {
  static EdgeInsets margem(BuildContext context) {
    return EdgeInsets.symmetric(
        horizontal: TamanhoTela.horizontal(context) * 0.05);
  }

  static double aluturaBotoes() {
    return 6.5.h;
  }

  static double larguraGeral() {
    return 100.w;
  }

  static ButtonStyle estiloBotao() {
    return ButtonStyle(
        maximumSize: WidgetStatePropertyAll(Size(100.w, 6.5.h)),
        minimumSize: WidgetStatePropertyAll(Size(100.w, 6.5.h)),
        shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w))),
        backgroundColor:
            WidgetStateProperty.all<Color>(ColorApp.verdePrincipalBotao),
        foregroundColor: WidgetStatePropertyAll(ColorApp.brancoTexto));
  }
}
