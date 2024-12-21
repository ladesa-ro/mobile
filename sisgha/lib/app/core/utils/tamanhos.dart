import 'package:flutter/material.dart';

import 'responsividade.dart';

class Tamanhos {
  static EdgeInsets margem(BuildContext context) {
    return EdgeInsets.symmetric(
        horizontal: TamanhoTela.horizontal(context) * 0.05);
  }

  static double aluturaBotoes(BuildContext context) {
    return TamanhoTela.vertical(context) * 0.06;
  }
}
