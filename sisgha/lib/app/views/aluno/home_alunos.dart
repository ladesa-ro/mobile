import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/data/providers/escolha_horarios_alunos.dart';
import 'package:sisgha/app/data/providers/escolha_menu_lateral.dart';

import 'package:sizer/sizer.dart';

import '../../core/utils/dias.dart';
import '../../core/utils/responsividade.dart';
import '../components/appbar.dart';
import '../components/widgets_home/botao_mini_calendario.dart';
import '../components/widgets_home/quadrados_home.dart';

class HomeAlunos extends StatelessWidget {
  const HomeAlunos({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    var appBar = CustomAppBar(
      height: 7.h,
      titulo: DatasFormatadas.primeiroAUltimoDia,
      subtitulo: DatasFormatadas.obterDiaFormatado(),
      alunoProfessor: false,
    );

    double tamanho =
        TamanhoTela.height(context, appBarSize: appBar.preferredSize.height);

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          SizedBox(height: tamanho * 0.03),
          botaoMiniCalendario(context),
          SizedBox(height: tamanho * 0.03),
          Expanded(child: const QuadradosHome()),
        ],
      ),
    );
  }
}
