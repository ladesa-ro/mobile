import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({super.key, required this.height});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: ColorApp.Branco,
      title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DatasFormatadas.diaAtual,
              style: estiloTexto(
                30,
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
                  style: estiloTexto(17,
                      cor: ColorApp.Branco, peso: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${DatasFormatadas.mesAtual[0].toUpperCase() + DatasFormatadas.mesAtual.substring(1)} - ${DatasFormatadas.obterPrimeiroDiaSemana()} a ${DatasFormatadas.obterUltimoDiaSemana()}',
                  style: estiloTexto(17,
                      cor: ColorApp.Branco, peso: FontWeight.bold),
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
