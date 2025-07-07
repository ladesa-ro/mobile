import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/cache/calendario_funcionalidades.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/estilos.dart';
import '../../core/utils/icones.dart';
import '../professor/calendario/calendario.dart';

Widget estiloDoBlocoDoDiaDeHoje(
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
            style: estiloTextoNumeros(),
          ),
        ),
      ),
    ),
  );
}

Widget estiloDosBlocosDosDiasDoMes(Color color, DateTime day, double height) {
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
        style: estiloTextoNumeros(),
      ),
    ),
  );
}

Widget estiloBlocoDiaSelecionado(DateTime day, double height) {
  return Container(
    width: height * 0.045,
    height: height * 0.045,
    decoration: BoxDecoration(
      color: CoresClaras.verdePrincipal,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: CoresClaras.brancoBorda,
        width: 2,
      ),
    ),
    child: Center(
      child: Text(
        '${day.day}',
        style: estiloTexto(
          15,
          peso: FontWeight.bold,
          cor: CoresClaras.brancoTexto,
        ),
      ),
    ),
  );
}

Widget estiloDosBlocosDosDiasDoMesDesabilitados(double height) {
  return Container(
    width: height * 0.04,
    height: height * 0.04,
    decoration: BoxDecoration(
      color: CoresClaras.verdecinzaCalendario,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

TextStyle estiloTextoNumeros() {
  return estiloTexto(15, cor: CoresClaras.brancoTexto, peso: FontWeight.bold);
}

HeaderStyle estiloCabessario() {
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

DaysOfWeekStyle estiloParteSuperior() {
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

CalendarBuilders calendarBuilder(double heigth) {
  Color cor = Colors.transparent;
  return CalendarBuilders(
    //dia selecionado
    selectedBuilder: (context, date, focusedDay) {
      // Verifica se o dia selecionado está dentro do mês atual
      if (date.month != focusedDay.month) {
        // Retorna o estilo padrão (sem destaque)
        return estiloDosBlocosDosDiasDoMesDesabilitados(
            heigth); // ou estilo padrão neutro
      }

      // Se estiver no mês visível, aplica o estilo de selecionado
      return estiloBlocoDiaSelecionado(date, heigth);
    },
    // durante o mes selecionado
    defaultBuilder: (context, date, events) {
      final etapasProvider = context.read<CalendarioFuncionalidades>();
      final etapasDoDia = etapasProvider.etapasCalendario[normalizarData(date)];
      cor = etapasDoDia?.first.cor ?? CoresClaras.cinza;
      return estiloDosBlocosDosDiasDoMes(cor, date, heigth);
    },

    //hoje
    todayBuilder: (context, day, focusedDay) =>
        estiloDoBlocoDoDiaDeHoje(context, day, cor, heigth),

    //dias dos meses diferentes do selecionado
    outsideBuilder: (context, day, focusedDay) =>
        estiloDosBlocosDosDiasDoMesDesabilitados(heigth),
    disabledBuilder: (context, day, focusedDay) =>
        estiloDosBlocosDosDiasDoMesDesabilitados(heigth),

    //notificação de evento no dia
    markerBuilder: (context, date, events) {
      if (events.isEmpty) return const SizedBox.shrink();

      return Positioned(
        bottom: -3,
        right: 8,
        child: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: events[0].cor ?? Colors.transparent,
              border: Border.all(width: 0.5, color: CoresClaras.cinzaBordas),
              borderRadius: BorderRadius.circular(10)),
        ),
      );
    },
  );
}
