import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../../providers/escolha_horarios_alunos.dart';

class AppbarAluno extends StatelessWidget implements PreferredSizeWidget {
  const AppbarAluno({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EscolhaHorariosAlunos>(context, listen: false);
    return AppBar(
      centerTitle: true,
      leading: BackButton(
        onPressed: () {
          provider.resetarTudo();
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (route) => false,
          );
        },
        style: ButtonStyle(
          iconSize: WidgetStatePropertyAll(6.h),
        ),
        color: Colors.white,
      ),
      title: const Text(
        "Acesso de Aluno",
        style: TextStyle(
          
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        
      ),
      backgroundColor: CoresClaras.verdePrincipal,
    );
  }
}
