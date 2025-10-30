import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../core/utils/cores.dart';
import '../../core/utils/estilos.dart';
import '../../core/utils/icones.dart';

class CustomAppBarNotificacao extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;
  final bool seta;

  const CustomAppBarNotificacao(
      {super.key, required this.height, required this.seta});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    return AppBar(
      titleSpacing: 0,
      title: Text(
        "Notificações",
        style: estiloTexto(18, peso: FontWeight.bold),
      ),
      leading: seta
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop(); // Volta pra tela anterior
              },
              icon: Iconify(
                Icones.setaVoltarDireita,
                size: double.infinity,
                color: tema.surfaceDim,
              ),
            )
          : null,
    );
  }
}
