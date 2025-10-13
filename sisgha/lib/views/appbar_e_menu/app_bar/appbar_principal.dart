import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/theme/tema_provider.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sisgha/viewmodels/escolha_horarios_alunos.dart';
import 'package:sisgha/widgets/dialogo_troca_de_tema.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/textos_alternados_widget.dart';

PreferredSizeWidget appBar(BuildContext ctx) {
  var temaAtivo = Provider.of<TemasProvider>(ctx).temaAtivo.brightness;
  final tema = Theme.of(ctx).colorScheme;

  String verificarTemaAtivo() {
    if (temaAtivo == Brightness.light) return 'escuro';
    return 'claro';
  }

  return AppBar(
      toolbarHeight: 7.h,
      backgroundColor: tema.primaryContainer,
      title:
          Consumer<EscolhaHorariosAlunos?>(builder: (context, provInfo, child) {
        bool existeInfo = provInfo != null;
        bool existeSelecionado =
            existeInfo ? provInfo.idFormacaoSelecionada != null : false;
        return Row(
          children: [
            existeSelecionado
                ? IconButton(
                    onPressed: () {
                      provInfo.resetarEscolhas();
                      Navigator.of(ctx).pushNamedAndRemoveUntil(
                          '/acessoAluno', (_) => false);
                    },
                    icon: _buildIcones(Icones.setaVoltarDireita, 23, tema))
                : Padding(padding: EdgeInsets.only(left: 2.w)),
            InfoAlternada(provInfo: provInfo),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TituloAlternado(
                    provInfo: provInfo, existeSelecionado: existeSelecionado),
                SubtituloAlternado(
                  existeSelecionado: existeSelecionado,
                )
              ],
            ),
            const Spacer(),
            //Ícon de troca de tema
            IconButton(
                onPressed: () {
                  showDialog(
                    context: ctx,
                    builder: (context) => mostrarDialogoDeTrocaDeTema(
                        context, verificarTemaAtivo(), tema),
                  );
                },
                icon: _buildIcones(Icones.sol, 22, tema)),
            existeSelecionado
                ? Container()
                : IconButton(
                    onPressed: () {
                      Navigator.of(ctx).pushNamed('/notificacao');
                    },
                    icon: _buildIcones(Icones.sino, 22, tema))
          ],
        );
      }));
}

Iconify _buildIcones(String icone, double size, ColorScheme tema) {
  return Iconify(
    icone,
    color: tema.primaryFixed,
    size: size.sp,
  );
}
