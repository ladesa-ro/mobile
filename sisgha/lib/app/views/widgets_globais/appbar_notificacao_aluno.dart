import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';

class CustomAppBarNotificacao extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;
  final bool seta;

  const CustomAppBarNotificacao({
    super.key,
    required this.height,
    required this.seta,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: seta
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Iconify(
                Icones.setaVoltarDireita,
                size: double.infinity,
                color: ColorsTemaClaro.branco,
              ),
            )
          : null,
      title: Row(
        children: [
          Text(
            'Notificações',
            style: estiloTexto(
              16,
              peso: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
