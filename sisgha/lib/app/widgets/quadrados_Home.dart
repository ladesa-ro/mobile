import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';

@override
// ignore: non_constant_identifier_names
Widget QuadradosHome(BuildContext context) {
  return Scaffold(
    body: SizedBox(
      height: MediaQuery.sizeOf(context).height > 750
          ? MediaQuery.sizeOf(context).height * 0.08
          : MediaQuery.sizeOf(context).height * 0.10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            child: ConstrutorQuadrados(context, index),
          );
        },
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget ConstrutorQuadrados(BuildContext context, int index) {
  List<String> weekdays = [
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sab',
  ];
  DateTime now = DateTime.now();
  DateTime date = now.add(Duration(days: index - now.weekday + 1));
  final diaDoMes = DateFormat('dd').format(date);

  return Row(
    children: [
      SizedBox(
        width: TamanhoTela.horizontal(context) * 0.04,
      ),
      Container(
        decoration: BoxDecoration(
          color: diaDoMes == DateFormat('dd').format(now)
              ? ColorApp.VerdeEscuro
              : null,
          border: Border.all(
            color: ColorApp.VerdeEscuro,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.height * 0.10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              weekdays[index],
              style: estiloTexto(15,
                  cor: diaDoMes == DateFormat('dd').format(now)
                      ? ColorApp.Branco
                      : ColorApp.VerdeCinza,
                  peso: FontWeight.w600),
            ),
            Container(
              width: 30,
              height: 2,
              color: diaDoMes == DateFormat('dd').format(now)
                  ? ColorApp.Branco
                  : ColorApp.VerdeCinza,
            ),
            Text(
              diaDoMes,
              style: estiloTexto(15,
                  cor: diaDoMes == DateFormat('dd').format(now)
                      ? ColorApp.Branco
                      : ColorApp.VerdeCinza,
                  peso: FontWeight.w600),
            ),
          ],
        ),
      )
    ],
  );
}
