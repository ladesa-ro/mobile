import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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

  //sempre implementar no physics dos ListViews ou outro tipo de widget de rolagem
  static AlwaysScrollableScrollPhysics efeitoDeRolagem() {
    return AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics());
  }

  static double calcularAlturaAppBar(BuildContext context,
      {double? appBarSize}) {
    return 100.h - (appBarSize ?? 0) - MediaQuery.of(context).padding.top;
  }

  static String primeiraLetraMaiuscula(String palavra) {
    if (palavra.isEmpty) return palavra;
    return palavra[0].toUpperCase() + palavra.substring(1);
  }

  static List<String?> separarTexto(String? texto) {
    if (texto == null || texto == '') return [];
    if (texto.length < 4) return [];
    String texto1 = texto.substring(0, 2);
    String texto2 = texto[3].toUpperCase() + texto.substring(4);

    List<String> lista = [];
    lista.add(texto1);
    lista.add(texto2);
    return lista;
  }

  static String removerPalavras(String texto) {
    return texto.replaceAll(r' - Fim', '').replaceAll(r' - Início', '');
  }
}
