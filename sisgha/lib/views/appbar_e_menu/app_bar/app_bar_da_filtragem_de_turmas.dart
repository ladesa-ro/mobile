import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/estilos.dart';
import '../../../core/utils/icones.dart';
import '../../../viewmodels/escolha_horarios_alunos.dart';

PreferredSizeWidget appBarFiltragemTurmas(BuildContext ctx) {
  final provider = Provider.of<EscolhaHorariosAlunos>(ctx, listen: false);
  final tema = Theme.of(ctx).colorScheme;

  return AppBar(
    toolbarHeight: 7.h,
    leading: IconButton(
      icon: Iconify(
        Icones.setaVoltarDireita,
        size: double.infinity,
        color: tema.primaryFixed,
      ),
      onPressed: () {
        provider.resetarEscolhas();
        Navigator.of(ctx).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      },
      style: ButtonStyle(
        iconSize: WidgetStatePropertyAll(6.h),
      ),
      color: tema.onPrimary,
    ),
    title: Text(
      "Acesso de Aluno",
      style: estiloTexto(
        17,
        peso: FontWeight.bold,
        cor: tema.inversePrimary,
      ),
    ),
    backgroundColor: tema.primaryContainer,
  );
}
