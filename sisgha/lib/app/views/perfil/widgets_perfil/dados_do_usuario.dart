import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widgets_perfil.dart';

Widget dadosUsuario(BuildContext context, user) {
  return Column(
    children: [
      Text(
        'Professor(a) ${user.nome}',
        style: estiloTexto(18, cor: ColorApp.Preto, peso: FontWeight.bold),
      ),
      Text(
        ' ${user.email}',
        style: estiloTexto(15, cor: ColorApp.VerdeCinza, peso: FontWeight.w500),
      ),
    ],
  );
}

Widget formulario(
    {required String textoFlutuante, required String informacoes}) {
  return Stack(
    alignment: AlignmentDirectional.topStart,
    children: [
      campoDeTexto(informacoes),
      floatLabel(textoFlutuante),
    ],
  );
}

Widget formularioLinha(
    {required String textoFlutuante, required String informacoes}) {
  return Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      campoDeTextoLinha(informacoes),
      floatLabelLinha(textoFlutuante),
    ],
  );
}
