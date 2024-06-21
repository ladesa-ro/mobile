import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({super.key, required this.height});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    //utimo dia da semana, SABADO
    DateTime date = now.add(Duration(days: 6 - now.weekday));
    final diaDoMes = DateFormat('dd').format(date);

    //primeiro dia da semana, SEGUNDA
    DateTime dia1 = now.add(Duration(days: 1 - now.weekday));
    final dateTeste = DateFormat('dd').format(dia1);

    // corrige um erro de o numero ficar negativo
    final corrigeErro = int.parse(dateTeste) < 0 ? dateTeste * -1 : dateTeste;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: ColorApp.Branco,
      title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DatasFormatadas.diaAtual,
              style: estiloTexto(
                TamanhoTela.vertical(context) > 810 ? 50 : 43,
                cor: ColorApp.Branco,
                peso: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DatasFormatadas.obterDiaFormatado(),
                  style: estiloTexto(
                      TamanhoTela.vertical(context) > 810 ? 20 : 18,
                      cor: ColorApp.Branco,
                      peso: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${DatasFormatadas.mesAtual[0].toUpperCase() + DatasFormatadas.mesAtual.substring(1)} - $corrigeErro a $diaDoMes',
                  style: estiloTexto(
                      TamanhoTela.vertical(context) > 810 ? 20 : 18,
                      cor: ColorApp.Branco,
                      peso: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Iconify(
                Icones.Bell,
                size: 34,
                color: ColorApp.Branco,
              ),
            )
          ]),
    );
  }
}
