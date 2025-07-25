import 'package:flutter/material.dart';


class AppbarNotificacaoAlunos extends StatelessWidget implements PreferredSizeWidget {
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
    return AppBar(
      title: const Text("Notificações"),
      leading: IconButton(
        onPressed: onVoltar,
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}