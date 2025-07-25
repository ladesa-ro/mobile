import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sisgha/app/core/utils/padroes.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/estilos.dart';
import '../../../core/utils/icones.dart';
import '../../components/appbar.dart';
import '../../components/calendario.dart';
import '../../components/widgets_home/quadrados_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DatasFormatadas.diaAtualEmNumero;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    var appBar = CustomAppBar(
      height: 7.h,
      mes: DatasFormatadas.primeiroAUltimoDia,
      diaHoje: DatasFormatadas.obterDiaFormatado(),
      icones: false,
      animacaoAtiva: false,
    );
    DateTime now = DateTime.now();
    double tamanho = Padroes.calcularAlturaAppBar(context,
        appBarSize: appBar.preferredSize.height);

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: Padroes.margem(),
        child: Column(
          children: [
            SizedBox(height: tamanho * 0.03), // ja ta certo
            // Inicio do botão de calendário
            ElevatedButton(
              style: Padroes.estiloBotao(context),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      insetPadding: EdgeInsets.zero,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 15),
                        decoration: estiloBorda(
                            cor: CoresClaras.verdecinzaBorda,
                            radius: 15,
                            grossuraBorda: 1.5),
                        width: 100.w * 0.85,
                        height: 100.h * 0.4,
                        child: TableCalendar(
                          firstDay: DatasFormatadas.primeiroDiaDoAno,
                          lastDay: DatasFormatadas.ultimoDiaDoAno,
                          focusedDay: _selectedDay,
                          calendarFormat: CalendarFormat.month,
                          locale: 'pt-BR',
                          shouldFillViewport: true,
                          daysOfWeekHeight: 23,
                          daysOfWeekStyle: estiloParteSuperior(context),
                          headerStyle: estiloCabessario(),
                          calendarBuilders: calendarBuilder(100.h, null),
                          pageAnimationCurve: Curves.linear,
                          pageAnimationDuration:
                              const Duration(milliseconds: 500),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icones.calendario,
                    size: 3.h,
                    color: CoresClaras.branco,
                  ),
                  const Spacer(),
                  Text(
                    'Calendário ${now.year}',
                    style: estiloTexto(15,
                        cor: CoresClaras.brancoTexto, peso: FontWeight.bold),
                  ),
                  const Spacer(),
                  Iconify(
                    Icones.setaBaixo,
                    size: 4.h,
                    color: CoresClaras.branco,
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
            //fim do botão de calendário
            SizedBox(height: tamanho * 0.03), // ja ta certo
            Expanded(
              child: const QuadradosHome(),
            ),
          ],
        ),
      ),
    );
  }
}
