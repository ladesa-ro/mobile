import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:table_calendar/table_calendar.dart';

class MiniCalendario extends StatefulWidget {
  const MiniCalendario({super.key});

  @override
  State<MiniCalendario> createState() => _MiniCalendarioState();
}

class _MiniCalendarioState extends State<MiniCalendario> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: TamanhoTela.horizontal(context) - 50,
        height: 350,
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
          calendarBuilders: _calendarBuilder(),
          pageAnimationCurve: Curves.linear,
          pageAnimationDuration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}

Widget _estiloDoBlocoDoDiaDeHoje(
    BuildContext context, DateTime day, Color cor) {
  return Container(
    width: double.maxFinite,
    height: double.maxFinite,
    margin: const EdgeInsets.all(7),
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
          border: Border.all(color: ColorApp.Branco, width: 1.5),
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

Widget _estiloDosBlocosDosDiasDoMes(Color color, DateTime day) {
  return Container(
    width: double.maxFinite,
    height: double.maxFinite,
    margin: const EdgeInsets.all(7),
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

Widget _estiloDosBlocosDosDiasDoMesDesabilitados() {
  return Container(
    width: double.maxFinite,
    height: double.maxFinite,
    margin: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      color: ColorApp.VerdeCinza,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

TextStyle _estiloTextoNumeros() {
  return estiloTexto(15, cor: ColorApp.Branco, peso: FontWeight.bold);
}

HeaderStyle _estiloCabessario() {
  return HeaderStyle(
    headerMargin: const EdgeInsets.only(bottom: 7),
    headerPadding: const EdgeInsets.all(5),
    decoration: const BoxDecoration(
      color: ColorApp.RoxoEscuro,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    titleCentered: true,
    formatButtonVisible: false,
    titleTextStyle:
        estiloTexto(20, cor: ColorApp.Branco, peso: FontWeight.bold),
    leftChevronIcon: const Iconify(
      Icones.setaEsquerda,
      color: ColorApp.Branco,
      size: 30,
    ),
    rightChevronIcon: const Iconify(
      Icones.setaDireita,
      color: ColorApp.Branco,
      size: 30,
    ),
    titleTextFormatter: (date, locale) =>
        DateFormat.MMMM(locale).format(date).toUpperCase(),
  );
}

DaysOfWeekStyle _estiloParteSuperior() {
  return DaysOfWeekStyle(
    weekdayStyle: estiloTexto(15, peso: FontWeight.bold, cor: ColorApp.Preto),
    weekendStyle: estiloTexto(15, peso: FontWeight.bold, cor: ColorApp.Preto),
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

CalendarBuilders _calendarBuilder() {
  Color color = Colors.black;
  return CalendarBuilders(
    defaultBuilder: (context, date, events) {
      final now = DateTime.now();

      if (date.isAfter(DateTime(now.year, 2, 7)) &&
          date.isBefore(DateTime(now.year, 4, 18))) {
        color = const Color(0xFF08C17F);
      } else if (date.isAfter(DateTime(now.year, 4, 17)) &&
          date.isBefore(DateTime(now.year, 6, 20))) {
        color = const Color.fromARGB(255, 69, 0, 158);
      } else if (date.isAfter(DateTime(now.year, 6, 19)) &&
          date.isBefore(DateTime(now.year, 7, 23))) {
        color = Colors.redAccent;
      } else if (date.isAfter(DateTime(now.year, 7, 22)) &&
          date.isBefore(DateTime(now.year, 9, 25))) {
        color = const Color(0xFFB20A33);
      } else if (date.isAfter(DateTime(now.year, 9, 24)) &&
          date.isBefore(DateTime(now.year, 11, 29))) {
        color = Colors.amber;
      } else {
        const TextStyle(color: Colors.transparent);
        color = const Color.fromRGBO(217, 217, 217, 100);
      }
      return _estiloDosBlocosDosDiasDoMes(color, date);
    },
    todayBuilder: (context, day, focusedDay) =>
        _estiloDoBlocoDoDiaDeHoje(context, day, color),
    outsideBuilder: (context, day, focusedDay) =>
        _estiloDosBlocosDosDiasDoMesDesabilitados(),
  );
}
