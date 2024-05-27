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
    DateTime date = now.add(Duration(days: 6 - now.weekday));
    final diaDoMes = DateFormat('dd').format(date);
    final primeirodiaSemana = int.parse(diaDoMes) - 6;

    final corrigeErro =
        primeirodiaSemana < 0 ? primeirodiaSemana * -1 : primeirodiaSemana;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: ColorApp.Branco,
      title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DatasFormatadas.DiaAgora,
              style: estiloTexto(
                TamanhoTela.vertical(context) > 810 ? 43 : 36,
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
                  '${DatasFormatadas.DiaExtensoFormatado[0].toUpperCase() + DatasFormatadas.DiaExtensoFormatado.substring(1)}${DatasFormatadas.DiaExtensoFormatado == 'sabado' || DatasFormatadas.DiaExtensoFormatado == 'domingo' ? '' : 'Feira'}',
                  style: estiloTexto(
                      TamanhoTela.vertical(context) > 810 ? 16 : 14,
                      cor: ColorApp.Branco,
                      peso: FontWeight.bold),
                ),
                Text(
                  '${DatasFormatadas.MesAgora[0].toUpperCase() + DatasFormatadas.MesAgora.substring(1)} - $corrigeErro a $diaDoMes',
                  style: estiloTexto(
                      TamanhoTela.vertical(context) > 810 ? 16 : 14,
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
                size: 30,
                color: ColorApp.Branco,
              ),
            )
          ]),
    );
  }
}
