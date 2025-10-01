import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sisgha/core/utils/estilos.dart';
import 'package:sisgha/viewmodels/escolha_horarios_alunos.dart';
import 'package:sizer/sizer.dart';

PreferredSizeWidget appBarNotificacao(
    BuildContext ctx, bool voltarProfessores) {
  var provInfo = Provider.of<EscolhaHorariosAlunos>(ctx);
  final tema = Theme.of(ctx).colorScheme;
  return AppBar(
    toolbarHeight: 7.h,
    titleSpacing: 0,
    backgroundColor: tema.primaryContainer,
    title: Text(
      "Notificações",
      style: estiloTexto(
        18,
        cor: tema.inversePrimary,
        peso: FontWeight.bold,
      ),
    ),
    leading: IconButton(
      onPressed: () {
        if (voltarProfessores) return Navigator.of(ctx).pop();

        provInfo.resetarEscolhas();
        Navigator.of(ctx).pushNamedAndRemoveUntil('/acessoAluno', (_) => false);
      },
      icon: Iconify(
        Icones.setaVoltarDireita,
        size: 22.sp,
        color: tema.primaryFixed,
      ),
    ),
  );
}
