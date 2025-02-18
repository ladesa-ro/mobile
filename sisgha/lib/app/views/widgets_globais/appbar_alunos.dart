import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/dias.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';

class CustomAppBarAluno extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String titulo;
  final String subtitulo;

  const CustomAppBarAluno(
      {super.key,
      required this.height,
      required this.titulo,
      required this.subtitulo});

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

          ],
        ),
      ),
    );
  }
}
