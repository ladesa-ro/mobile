import 'package:flutter/material.dart';

ButtonStyle estiloBotao(context) {
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.fromLTRB(0, 10, 0, 10)),
    shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    backgroundColor:
        MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
  );
}

TextStyle estiloTexto(double tamanho, {Color? cor, FontWeight? peso}) {
  return TextStyle(
    fontSize: tamanho,
    color: cor,
    fontWeight: peso,
  );
}
