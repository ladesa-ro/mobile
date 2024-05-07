import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';

ButtonStyle estiloBotao(
    context, double left, double top, double right, double bottom) {
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.fromLTRB(left, top, right, bottom)),
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
    enabledBorder: inputBorder(1.5),
    border: inputBorder(2),
    labelStyle:
        estiloTexto(14, cor: ColorApp.VerdeCinza, peso: FontWeight.w600),
    focusedBorder: inputBorder(2),
    suffixIcon: suffixIcon,
  );
}

OutlineInputBorder inputBorder(double bold) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: ColorApp.VerdeCinza, style: BorderStyle.solid, width: bold),
    borderRadius: const BorderRadius.all(Radius.circular(13)),
  );
}
