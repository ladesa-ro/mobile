import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/botton_sheat.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/button_style_edit.dart';

Widget circleAvatar(BuildContext context, link) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(100),
    ),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          child: SizedBox(
            width: 90,
            height: 90,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 126, 126, 126),
              //Aqui muda a imagem que aparece a imagem circular
              backgroundImage: NetworkImage(link),
            ),
          ),
        ),
        Positioned(
          left: 50,
          top: 50,
          child: SizedBox(
            child: ElevatedButton(
              style: buttonStyleEdit(ColorApp.Preto),
              onPressed: () => {
                bottomSheat(context),
              },
              child: const Iconify(
                Icones.Lapiz,
                size: 14,
                color: ColorApp.Branco,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
