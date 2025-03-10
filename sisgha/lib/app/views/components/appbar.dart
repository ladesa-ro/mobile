import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/dias.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String titulo;
  final String subtitulo;

  final bool
      ealunos; //se for alunos colocar trur e se  for o professor colocar false

  const CustomAppBar(
      {super.key,
      required this.height,
      required this.titulo,
      required this.subtitulo,
      required this.ealunos});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: Tamanhos.margem(context),
        child: Row(
          children: [
            if (ealunos == true)
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Iconify(
                  Icones.setaVoltarDireita,
                  size: 40,
                  color: ColorsTemaClaro.branco,
                ),
              ),
            Text(
              DatasFormatadas.diaAtual,
              style: estiloTexto(
                30,
                cor: ColorsTemaClaro.brancoTexto,
                peso: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: estiloTexto(17,
                      cor: ColorsTemaClaro.brancoTexto, peso: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitulo,
                  style: estiloTexto(17,
                      cor: ColorsTemaClaro.brancoTexto, peso: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            if (!ealunos)
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/notificacao');
                },
                icon: const Iconify(
                  Icones.Sino,
                  size: 34,
                  color: ColorsTemaClaro.branco,
                ),
              )
          ],
        ),
      ),
    );
  }
}
