import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';

// ignore: non_constant_identifier_names
Widget Horarios(BuildContext context) {
  return Scaffold(
      body: Column(
    children: [
      Container(
        padding: const EdgeInsets.only(left: 15, right: 10),
        margin: const EdgeInsets.only(right: 15, left: 15),
        height: TamanhoTela.vertical(context) * 0.12,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            style: BorderStyle.solid,
            width: 1.5,
            color: ColorApp.VerdeCinza,
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Linguagem de Programação',
                  style: estiloTexto(
                      TamanhoTela.vertical(context) > 810 ? 15 : 13,
                      cor: ColorApp.VerdeCinza,
                      peso: FontWeight.w500),
                ),
                Text('2º A Informatica - Ambiente: Labin 1',
                    style: estiloTexto(
                        TamanhoTela.vertical(context) > 810 ? 15 : 13,
                        cor: ColorApp.VerdeCinza,
                        peso: FontWeight.w500)),
                Text('Horario 8:10 - 9:00',
                    style: estiloTexto(
                        TamanhoTela.vertical(context) > 810 ? 15 : 13,
                        cor: ColorApp.VerdeCinza,
                        peso: FontWeight.w500))
              ],
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        padding: const EdgeInsets.only(left: 15, right: 13),
        margin: const EdgeInsets.only(right: 15, left: 15),
        height: TamanhoTela.vertical(context) * 0.12,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            style: BorderStyle.solid,
            width: 1.5,
            color: ColorApp.Preto,
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Linguagem de Programação',
                  style: estiloTexto(
                      TamanhoTela.vertical(context) > 810 ? 15 : 13,
                      cor: ColorApp.Preto,
                      peso: FontWeight.bold),
                ),
                Text('2º A Informatica - Ambiente: Labin 1',
                    style: estiloTexto(
                        TamanhoTela.vertical(context) > 810 ? 15 : 13,
                        cor: ColorApp.Preto,
                        peso: FontWeight.w300)),
                Text('Horario 8:10 - 9:00',
                    style: estiloTexto(
                        TamanhoTela.vertical(context) > 810 ? 15 : 13,
                        cor: ColorApp.Preto,
                        peso: FontWeight.bold))
              ],
            ),
            const Spacer(),
            const Iconify(
              Icones.Relogio,
              color: ColorApp.VerdeEscuro,
              size: 35,
            )
          ],
        ),
      ),
    ],
  ));
}
