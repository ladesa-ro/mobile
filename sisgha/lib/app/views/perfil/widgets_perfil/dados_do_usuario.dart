import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhotela.dart';

Widget campoDeTexto(String texto) {
  return Container(
    alignment: AlignmentDirectional.centerStart,
    padding: const EdgeInsets.only(left: 15),
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 50,
    width: double.maxFinite,
    decoration: BoxDecoration(
      border: Border.all(color: ColorApp.VerdeCinza),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      texto,
      style: estiloTexto(16, cor: ColorApp.Preto, peso: FontWeight.w600),
    ),
  );
}

Widget floatLabel(String textoFlutuante, context) {
  return Container(
    alignment: AlignmentDirectional.center,
    margin: const EdgeInsets.only(left: 25),
    color: ColorApp.CorDeFundo,
    width: 70,
    height: 17,
    child: Text(
      textoFlutuante,
      style: estiloTexto(
        15,
        cor: ColorApp.VerdeCinza,
        peso: FontWeight.w600,
      ),
    ),
  );
}

Widget campoDeTextoLinha(String texto, BuildContext context) {
  return Expanded(
      child: Container(
    alignment: AlignmentDirectional.center,
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 50,
    width: (TamanhoTela.horizontal(context) / 2) - 30,
    decoration: BoxDecoration(
      border: Border.all(color: ColorApp.VerdeCinza),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      texto,
      style: estiloTexto(16, cor: ColorApp.VerdeCinza, peso: FontWeight.w600),
    ),
  ));
}

Widget floatLabelLinha(String textoFlutuante) {
  return Container(
    alignment: AlignmentDirectional.center,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    color: ColorApp.CorDeFundo,
    height: 17,
    child: Text(
      textoFlutuante,
      style: estiloTexto(15, cor: ColorApp.VerdeCinza, peso: FontWeight.w600),
    ),
  );
}
