import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/utils/cores.dart';
import '../../core/utils/dias.dart';
import '../../core/utils/estilos.dart';
import '../../core/utils/icones.dart';
import '../../core/utils/padroes.dart';
import '../../widgets/calendario.dart';
import '../../widgets/widgets_home/quadrados_home.dart';

class HomeAlunos extends StatefulWidget {
  const HomeAlunos({super.key});

  @override
  State<HomeAlunos> createState() => _HomeAlunosState();
}

class _HomeAlunosState extends State<HomeAlunos> {
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

    double tamanho = Padroes.calcularAlturaAppBar(context, appBarSize: 7.h);
    DateTime now = DateTime.now();

    final tema = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: Padroes.margem(),
        child: Column(
          children: [
            SizedBox(height: tamanho * 0.03),
            ElevatedButton(
              style: Padroes.estiloBotao(context, tema),
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
                            cor: tema.tertiary, radius: 15, grossuraBorda: 1.5),
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
                          headerStyle: estiloCabessario(tema),
                          calendarBuilders: calendarBuilder(100.h, null, tema),
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
                    color: tema.scrim,
                  ),
                  const Spacer(),
                  Text(
                    'Calendário ${now.year}',
                    style: estiloTexto(15,
                        cor: tema.primary, peso: FontWeight.bold),
                  ),
                  const Spacer(),
                  Iconify(
                    Icones.setaBaixo,
                    size: 4.h,
                    color: tema.scrim,
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
            SizedBox(height: tamanho * 0.03),
            Expanded(child: const QuadradosHome()),
          ],
        ),
      ),
    );
  }
}
