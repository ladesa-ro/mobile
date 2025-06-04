import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

class Padroes {
  static EdgeInsets margem() {
    return EdgeInsets.symmetric(horizontal: larguraGeral() * 0.05);
  }

  static double aluturaBotoes() {
    return 6.5.h;
  }

  static double alturaGeral() {
    return 100.h;
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
            WidgetStateProperty.all<Color>(CoresClaras.verdePrincipalBotao),
        foregroundColor: WidgetStatePropertyAll(CoresClaras.brancoTexto));
  }

  //sempre implementar no physics dos ListViews ou outro tipo de widget de rolagem
  static AlwaysScrollableScrollPhysics efeitoDeRolagem() {
    return AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics());
  }

  static double calcularAlturaAppBar(BuildContext context,
      {double? appBarSize}) {
    return MediaQuery.of(context).size.height -
        (appBarSize ?? 0) -
        MediaQuery.of(context).padding.top -
        larguraGeral() * 0.08;
  }
}
