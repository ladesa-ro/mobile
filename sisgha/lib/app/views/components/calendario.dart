import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/dias.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class MiniCalendario extends StatefulWidget {
  final bool showDialog;
  const MiniCalendario({super.key, this.showDialog = false});
  @override
  State<MiniCalendario> createState() => _MiniCalendarioState();
}

class _MiniCalendarioState extends State<MiniCalendario> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => widget.showDialog
          ? Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              insetPadding: EdgeInsets.zero,
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                decoration: estiloBorda(
                    cor: CoresClaras.verdecinzaBorda,
                    radius: 15,
                    grossuraBorda: 1.5),
                width: constraints.maxWidth * 0.85,
                height: constraints.maxHeight * 0.4,
                child: TableCalendar(
                  firstDay: DatasFormatadas.primeiroDiaDoAno,
                  lastDay: DatasFormatadas.ultimoDiaDoAno,
                  focusedDay: DatasFormatadas.diaAtualEmNumero,
                  calendarFormat: CalendarFormat.month,
                  locale: 'pt-BR',
                  shouldFillViewport: true,
                  daysOfWeekHeight: 23,
                  daysOfWeekStyle: _estiloParteSuperior(),
                  headerStyle: _estiloCabessario(),
                  calendarBuilders: _calendarBuilder(constraints.maxHeight),
                  pageAnimationCurve: Curves.linear,
                  pageAnimationDuration: const Duration(milliseconds: 500),
                ),
              ),
            )
          : SizedBox(
              child: Container(
                padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
                decoration: estiloBorda(
                    cor: CoresClaras.verdecinzaBorda,
                    radius: 15,
                    grossuraBorda: 2),
                child: TableCalendar(
                  firstDay: DatasFormatadas.primeiroDiaDoAno,
                  lastDay: DatasFormatadas.ultimoDiaDoAno,
                  focusedDay: DatasFormatadas.diaAtualEmNumero,
                  calendarFormat: CalendarFormat.month,
                  locale: 'pt-BR',
                  shouldFillViewport: true,
                  daysOfWeekHeight: 23,
                  daysOfWeekStyle: _estiloParteSuperior(),
                  headerStyle: _estiloCabessario(),
                  calendarBuilders:
                      _calendarBuilder(constraints.maxHeight * 2.3),
                  pageAnimationCurve: Curves.linear,
                  pageAnimationDuration: const Duration(milliseconds: 500),
                ),
              ),
            ),
    );
  }
}

Widget _estiloDoBlocoDoDiaDeHoje(
    BuildContext context, DateTime day, Color cor, double height) {
  return Container(
    width: height * 0.04,
    height: height * 0.04,
    decoration: BoxDecoration(
      color: cor,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: CoresClaras.brancoBorda, width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            '${day.day}',
            style: _estiloTextoNumeros(),
          ),
        ),
      ),
    ),
  );
}

Widget _estiloDosBlocosDosDiasDoMes(Color color, DateTime day, double height) {
  return Container(
    width: height * 0.04,
    height: height * 0.04,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        '${day.day}',
        style: _estiloTextoNumeros(),
      ),
    ),
  );
}

Widget _estiloDosBlocosDosDiasDoMesDesabilitados(double height) {
  return Container(
    width: height * 0.04,
    height: height * 0.04,
    decoration: BoxDecoration(
      color: CoresClaras.verdecinzaCalendario,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

TextStyle _estiloTextoNumeros() {
  return estiloTexto(15, cor: CoresClaras.brancoTexto, peso: FontWeight.bold);
}

HeaderStyle _estiloCabessario() {
  return HeaderStyle(
    headerMargin: const EdgeInsets.only(bottom: 7),
    headerPadding: EdgeInsets.all(1.h),
    decoration: const BoxDecoration(
      color: CoresClaras.roxo,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    titleCentered: true,
    formatButtonVisible: false,
    titleTextStyle:
        estiloTexto(16, cor: CoresClaras.brancoTexto, peso: FontWeight.bold),
    leftChevronIcon: Iconify(
      Icones.setaEsquerda,
      color: CoresClaras.branco,
      size: 3.h,
    ),
    rightChevronIcon: Iconify(
      Icones.setaDireita,
      color: CoresClaras.branco,
      size: 3.h,
    ),
    titleTextFormatter: (date, locale) =>
        DateFormat.MMMM(locale).format(date).toUpperCase(),
  );
}

DaysOfWeekStyle _estiloParteSuperior() {
  return DaysOfWeekStyle(
    weekdayStyle:
        estiloTexto(15, peso: FontWeight.bold, cor: CoresClaras.pretoTexto),
    weekendStyle:
        estiloTexto(15, peso: FontWeight.bold, cor: CoresClaras.pretoTexto),
    dowTextFormatter: (date, locale) {
      switch (date.weekday) {
        case DateTime.monday:
          return 'Seg';
        case DateTime.tuesday:
          return 'Ter';
        case DateTime.wednesday:
          return 'Qua';
        case DateTime.thursday:
          return 'Qui';
        case DateTime.friday:
          return 'Sex';
        case DateTime.saturday:
          return 'Sab';
        case DateTime.sunday:
          return 'Dom';
        default:
          return '';
      }
    },
  );
}

CalendarBuilders _calendarBuilder(double heigth) {
  Color color = Colors.black;
  return CalendarBuilders(
    defaultBuilder: (context, date, events) {
      final now = DateTime.now();

      if (date.isAfter(DateTime(now.year, 2, 7)) &&
          date.isBefore(DateTime(now.year, 4, 18))) {
        color = const Color(0xFF08C17F);
      } else if (date.isAfter(DateTime(now.year, 4, 17)) &&
          date.isBefore(DateTime(now.year, 6, 20))) {
        color = CoresClaras.roxo;
      } else if (date.isAfter(DateTime(now.year, 6, 19)) &&
          date.isBefore(DateTime(now.year, 7, 23))) {
        color = CoresClaras.vermelhoFracoCalendario;
      } else if (date.isAfter(DateTime(now.year, 7, 22)) &&
          date.isBefore(DateTime(now.year, 9, 25))) {
        color = CoresClaras.vermelhoCalendario;
      } else if (date.isAfter(DateTime(now.year, 9, 24)) &&
          date.isBefore(DateTime(now.year, 11, 29))) {
        color = Colors.amber;
      } else {
        const TextStyle(color: Colors.transparent);
        color = CoresClaras.cinza;
      }
      return _estiloDosBlocosDosDiasDoMes(color, date, heigth);
    },
    todayBuilder: (context, day, focusedDay) =>
        _estiloDoBlocoDoDiaDeHoje(context, day, color, heigth),
    outsideBuilder: (context, day, focusedDay) =>
        _estiloDosBlocosDosDiasDoMesDesabilitados(heigth),
  );
}
