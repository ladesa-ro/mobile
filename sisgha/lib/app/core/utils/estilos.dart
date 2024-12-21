import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';
import 'package:sizer/sizer.dart';

ButtonStyle estiloBotao(context) {
  return ButtonStyle(
    shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
    backgroundColor:
        WidgetStateProperty.all<Color>(ColorApp.VerdePrincipalBotao),
  );
}

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
    floatingLabelStyle:
        estiloTexto(15, cor: ColorApp.VerdeCinzaTexto, peso: FontWeight.bold),
    labelText: labelText,
    contentPadding:
        EdgeInsets.fromLTRB(12, Tamanhos.aluturaBotoes(context) / 2, 12, 0),
    alignLabelWithHint: false,
    enabledBorder: inputBorder(1.5),
    border: inputBorder(2),
    labelStyle:
        estiloTexto(15, cor: ColorApp.VerdeCinzaTexto, peso: FontWeight.w600),
    focusedBorder: inputBorder(2),
    suffixIcon: suffixIcon,
  );
}

OutlineInputBorder inputBorder(double bold) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: ColorApp.VerdeCinzaBorda, style: BorderStyle.solid, width: bold),
    borderRadius: const BorderRadius.all(Radius.circular(13)),
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
