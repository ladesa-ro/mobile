import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/core/utils/estilos.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sizer/sizer.dart';

class AppbarNotificacaoAlunos extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;
  final VoidCallback onVoltar;

  const AppbarNotificacaoAlunos({
    super.key,
    required this.height,
    required this.onVoltar,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    return AppBar(
      title: Text(
        "Notificações",
        style: estiloTexto(
          17.sp,
          peso: FontWeight.bold,
          cor: tema.primary,
        ),
      ),
      leading: IconButton(
        onPressed: onVoltar,
        icon: Iconify(
          Icones.setaVoltarDireita,
          size: double.infinity,
          color: tema.surfaceDim,
        ),
      ),
    );
  }
}
