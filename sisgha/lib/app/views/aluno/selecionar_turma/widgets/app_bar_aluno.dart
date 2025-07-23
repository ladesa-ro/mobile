import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sizer/sizer.dart';

import '../../../../cache/escolha_horarios_alunos.dart';

class AppbarAluno extends StatelessWidget implements PreferredSizeWidget {
  const AppbarAluno({super.key});
  @override
  Size get preferredSize => Size.fromHeight(7.h);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EscolhaHorariosAlunos>(context, listen: false);
    return AppBar(
      leading: IconButton(
        icon: Iconify(
          Icones.setaVoltarDireita,
          size: double.infinity,
          color: CoresClaras.branco,
        ),
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
      title: Text(
        "Acesso de Aluno",
        style: estiloTexto(
          18.sp,
          peso: FontWeight.bold,
          cor: CoresClaras.brancoTexto,
        ),
      ),
      backgroundColor: CoresClaras.verdePrincipal,
    );
  }
}
