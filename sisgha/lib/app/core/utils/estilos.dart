import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

TextStyle estiloTexto(double tamanho, {Color? cor, FontWeight? peso}) {
  return TextStyle(
      fontSize: tamanho.sp,
      color: cor,
      fontWeight: peso,
      fontFamily: 'Poppins');
}

InputDecoration inputDecoration(BuildContext context, String labelText,
    {Widget? suffixIcon}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(
        top: Tamanhos.aluturaBotoes() / 1.5, left: 12, right: 12),
    floatingLabelStyle: estiloTexto(15,
        cor: CoresClaras.verdecinzaTexto, peso: FontWeight.bold),
    labelText: labelText,
    alignLabelWithHint: false,
    enabledBorder: inputBorder(1.5),
    border: inputBorder(2),
    labelStyle: estiloTexto(15,
        cor: CoresClaras.verdecinzaTexto, peso: FontWeight.w600),
    focusedBorder: inputBorder(2),
    suffixIcon: suffixIcon,
  );
}

OutlineInputBorder inputBorder(double bold) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: CoresClaras.verdecinzaBorda,
        style: BorderStyle.solid,
        width: bold),
    borderRadius: BorderRadius.all(Radius.circular(3.w)),
  );
}

BoxDecoration estiloBorda({
  required Color cor,
  required double radius,
  double? grossuraBorda,
}) {
  return BoxDecoration(
    border: Border.all(
      color: cor,
      width: grossuraBorda ?? 1,
    ),
    borderRadius: BorderRadius.circular(radius),
  );
}
