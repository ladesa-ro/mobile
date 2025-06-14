import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/dias.dart';
import '../../core/utils/padroes.dart';
import '../components/appbar.dart';
import '../components/widgets_home/botao_mini_calendario.dart';
import '../components/widgets_home/quadrados_home_alunos.dart';

class HomeAlunos extends StatelessWidget {
  const HomeAlunos({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    var appBar = CustomAppBar(
      height: 7.h,
      mes: DatasFormatadas.primeiroAUltimoDia,
      diaHoje: DatasFormatadas.obterDiaFormatado(),
      icones: true,
      animacaoAtiva: true,
    );

    double tamanho = Padroes.calcularAlturaAppBar(context,
        appBarSize: appBar.preferredSize.height);

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: Padroes.margem(),
        child: Column(
          children: [
            SizedBox(height: tamanho * 0.03),
            botaoMiniCalendario(context),
            SizedBox(height: tamanho * 0.03),
            Expanded(child: const QuadradosHomeAlunos()),
            SizedBox(height: tamanho * 0.03),
          ],
        ),
      ),
    );
  }
}
