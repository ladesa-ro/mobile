import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sisgha/core/utils/colors.dart';
import 'package:sisgha/core/utils/estilos.dart';

class AppbarNotificacaoAlunos extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;
  final VoidCallback? onVoltar;

  const AppbarNotificacaoAlunos({
    super.key,
    required this.height,
    this.onVoltar,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        "Notificações",
        style: estiloTexto(
          18,
          peso: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: onVoltar ?? () => Navigator.of(context).pop(),
        icon: Iconify(
          Icones.setaVoltarDireita,
          size: double.infinity,
          color: CoresClaras.branco,
        ),
      ),
    );
  }
}
