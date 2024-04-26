import 'package:flutter/material.dart';

const Color corPersonalizada = Color.fromRGBO(154, 182, 158, 1);

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

InputDecoration inputDecoration(String labelText, {Widget? suffixIcon}) {
  return InputDecoration(
    labelText: labelText,
    contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
    alignLabelWithHint: true,
    border: inputBorder(),
    labelStyle: estiloTexto(14, cor: corPersonalizada, peso: FontWeight.w600),
    focusedBorder: inputBorder(),
    suffixIcon: suffixIcon,
  );
}

OutlineInputBorder inputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: corPersonalizada),
    borderRadius: const BorderRadius.all(Radius.circular(13)),
  );
}
