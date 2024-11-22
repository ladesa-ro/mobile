import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String titulo;
  final String subtitulo;

  const CustomAppBar(
      {super.key,
      required this.height,
      required this.titulo,
      required this.subtitulo});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: ColorApp.BrancoTexto,
      title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DatasFormatadas.diaAtual,
              style: estiloTexto(
                30,
                cor: ColorApp.BrancoTexto,
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
                  titulo,
                  style: estiloTexto(17,
                      cor: ColorApp.BrancoTexto, peso: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  subtitulo,
                  style: estiloTexto(17,
                      cor: ColorApp.BrancoTexto, peso: FontWeight.bold),
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
