import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/dados_do_usuario.dart';

Widget dadosUsuario(BuildContext context) {
  return Column(
    children: [
      Text(
        'Professor(a) "nome_aqui"',
        style: estiloTexto(18, cor: ColorApp.Preto, peso: FontWeight.bold),
      ),
      Text(
        'email_aqui',
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
    {required String textoFlutuante,
    required String informacoes,
    required BuildContext context}) {
  return Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      campoDeTextoLinha(informacoes, context),
      floatLabelLinha(textoFlutuante),
    ],
  );
}
