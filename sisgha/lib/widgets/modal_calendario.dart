import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sisgha/widgets/calendario.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../core/utils/dias.dart';
import '../core/utils/estilos.dart';

class ModalCalendario extends StatefulWidget {
  const ModalCalendario({super.key});

  @override
  State<ModalCalendario> createState() => _ModalCalendarioState();
}

class _ModalCalendarioState extends State<ModalCalendario> {
  late DateTime _selectedDay;
  @override
  void initState() {
    super.initState();
    _selectedDay = DatasFormatadas.diaAtualEmNumero;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    final tema = Theme.of(context).colorScheme;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        decoration:
            estiloBorda(cor: tema.tertiary, radius: 15, grossuraBorda: 1.5),
        width: 100.w * 0.85,
        height: 100.h * 0.4,
        child: TableCalendar(
          firstDay: DatasFormatadas.primeiroDiaDoAno,
          lastDay: DatasFormatadas.ultimoDiaDoAno,
          focusedDay: _selectedDay,
          calendarFormat: CalendarFormat.month,
          locale: 'pt-BR',
          shouldFillViewport: true,
          daysOfWeekHeight: 4.h,
          daysOfWeekStyle: estiloParteSuperior(tema),
          headerStyle: estiloCabessario(tema),
          calendarBuilders: calendarBuilder(100.h, null, tema),
          pageAnimationCurve: Curves.linear,
          pageAnimationDuration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
