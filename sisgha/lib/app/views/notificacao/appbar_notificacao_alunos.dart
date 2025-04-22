import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';

class AppbarNotificacaoAlunos extends StatelessWidget
    implements PreferredSizeWidget
//Utiliza-se o PreferredSizeWidget porque o Scaffold exige
{
  final double height;
  const AppbarNotificacaoAlunos({super.key, required this.height});

  @override
  Size get preferredSize => Size.fromHeight(height);
  //O PreferredSizeWidget exige esse comando (comando feio do cacete)

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
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Iconify(
          Icones.setaVoltarDireita,
          size: double.infinity,
          color: CoresClaras.branco,
        ),
      ),
    );
  }
}
