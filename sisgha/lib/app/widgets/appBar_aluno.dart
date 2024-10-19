import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';

class AppbarAluno extends StatelessWidget implements PreferredSizeWidget {
  const AppbarAluno({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(
        style: ButtonStyle(
          iconSize: WidgetStatePropertyAll(40),
        ),
        color: Colors.white,
      ),
      title: const Text(
        "Acesso de Aluno",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: ColorApp.VerdePrincipal,
    );
  }
}
