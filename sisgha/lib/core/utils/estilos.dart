import 'package:flutter/material.dart';
import 'package:sisgha/core/utils/padroes.dart';
import 'package:sizer/sizer.dart';

TextStyle estiloTexto(
  double tamanho, {
  Color? cor,
  FontWeight? peso,
}) {
  return TextStyle(
      fontSize: tamanho.sp,
      color: cor,
      fontWeight: peso,
      fontFamily: 'Poppins');
}

InputDecoration inputDecoration(BuildContext context, String labelText,
    {Widget? suffixIcon}) {
  final tema = Theme.of(context).colorScheme;
  return InputDecoration(
    fillColor: tema.error,
    contentPadding: EdgeInsets.only(
        top: Padroes.aluturaBotoes() / 1.5, left: 12, right: 12),
    floatingLabelStyle:
        estiloTexto(15, cor: tema.tertiary, peso: FontWeight.bold),
    labelText: labelText,
    alignLabelWithHint: false,
    enabledBorder: inputBorder(1.5, tema),
    border: inputBorder(2, tema),
    labelStyle: estiloTexto(15, cor: tema.tertiary, peso: FontWeight.w600),
    focusedBorder: inputBorder(2, tema),
    suffixIcon: suffixIcon,
  );
}

OutlineInputBorder inputBorder(double bold, ColorScheme tema) {
  return OutlineInputBorder(
    borderSide:
        BorderSide(color: tema.tertiary, style: BorderStyle.solid, width: bold),
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

//utilizado na tela de filtragem das turmas para logar como aluno
BoxDecoration bordasCardsAlunos(bool selecionado, ColorScheme tema) {
  return BoxDecoration(
      border: Border.all(
          color: selecionado ? tema.onPrimary : tema.onSecondary, width: 2),
      borderRadius: BorderRadius.circular(15));
}
