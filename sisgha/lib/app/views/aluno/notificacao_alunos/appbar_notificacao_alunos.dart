import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/estilos.dart';

class AppbarNotificacaoAlunos extends StatelessWidget
    implements PreferredSizeWidget
//Utiliza-se o PreferredSizeWidget porque o Scaffold exige
{
  @override
  Size get preferredSize => const Size.fromHeight(60);
  //O PreferredSizeWidget exige esse comando (comando feio do cacete)

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Notificações",
        style: estiloTexto(
          16,
          peso: FontWeight.bold,
        ),
      
      ),
    );
  }
}
