import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sizer/sizer.dart';

class AppbarAluno extends StatelessWidget implements PreferredSizeWidget {
  const AppbarAluno({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(
        style: ButtonStyle(
          iconSize: WidgetStatePropertyAll(4.h),
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
      backgroundColor: CoresClaras.verdePrincipal,
    );
  }
}
