import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/viewmodels/calendario_funcionalidades.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../core/utils/estilos.dart';
import '../core/utils/icones.dart';
import '../views/professor/calendario/calendario.dart';

Widget estiloDoBlocoDoDiaDeHoje(BuildContext context, DateTime day, Color cor,
    double height, ColorScheme tema) {
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
          border: Border.all(color: tema.onTertiary, width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            '${day.day}',
            style: estiloTextoNumeros(tema),
          ),
        ),
      ),
    ),
  );
}

Widget estiloDosBlocosDosDiasDoMes(
    Color color, DateTime day, double height, ColorScheme tema) {
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
        style: estiloTextoNumeros(tema),
      ),
    ),
  );
}

Widget estiloBlocoDiaSelecionado(
    DateTime day, double height, ColorScheme tema) {
  return Container(
    width: height * 0.045,
    height: height * 0.045,
    decoration: BoxDecoration(
      color: tema.primaryContainer,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: tema.onTertiary,
        width: 2,
      ),
    ),
    child: Center(
      child: Text(
        '${day.day}',
        style: estiloTexto(
          15,
          peso: FontWeight.bold,
          cor: tema.surface,
        ),
      ),
    ),
  );
}

Widget estiloDosBlocosDosDiasDoMesDesabilitados(
    double height, ColorScheme tema) {
  return Container(
    width: height * 0.04,
    height: height * 0.04,
    decoration: BoxDecoration(
      color: tema.surfaceVariant,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

TextStyle estiloTextoNumeros(ColorScheme tema) {
  return estiloTexto(15, cor: tema.surface, peso: FontWeight.bold);
}

HeaderStyle estiloCabessario(ColorScheme tema) {
  return HeaderStyle(
    headerMargin: const EdgeInsets.only(bottom: 7),
    headerPadding: EdgeInsets.all(1.h),
    decoration: BoxDecoration(
      color: tema.surfaceContainer,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    titleCentered: true,
    formatButtonVisible: false,
    titleTextStyle:
        estiloTexto(16, cor: tema.primaryFixed, peso: FontWeight.bold),
    leftChevronIcon: Iconify(
      Icones.setaEsquerda,
      color: tema.primaryFixed,
      size: 3.h,
    ),
    rightChevronIcon: Iconify(
      Icones.setaDireita,
      color: tema.primaryFixed,
      size: 3.h,
    ),
    titleTextFormatter: (date, locale) =>
        DateFormat.MMMM(locale).format(date).toUpperCase(),
  );
}

// Estilo dos dias da semana
DaysOfWeekStyle estiloParteSuperior(ColorScheme tema) {
  return DaysOfWeekStyle(
    weekdayStyle: estiloTexto(16, peso: FontWeight.bold, cor: tema.primary),
    weekendStyle: estiloTexto(16, peso: FontWeight.bold, cor: tema.primary),
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

CalendarBuilders calendarBuilder(
    double heigth, DateTime? diafocado, ColorScheme tema) {
  return CalendarBuilders(

      //dia selecionado
      selectedBuilder: (context, date, focusedDay) {
        // Verifica se o dia selecionado está dentro do mês atual
        if (date.month != focusedDay.month) {
          // Retorna o estilo padrão (sem destaque)
          return estiloDosBlocosDosDiasDoMesDesabilitados(
              heigth, tema); // ou estilo padrão neutro
        }

        // Se estiver no mês visível, aplica o estilo de selecionado
        return estiloBlocoDiaSelecionado(date, heigth, tema);
      },
      // durante o mes selecionado
      defaultBuilder: (context, date, events) {
        final provider = context.read<CalendarioFuncionalidades>();
        final eventoDoDia = provider.tudoJunto[normalizarData(date)];
        final cor = eventoDoDia?.first.cor ?? tema.surfaceVariant;

        return estiloDosBlocosDosDiasDoMes(cor, date, heigth, tema);
      },

      //hoje
      todayBuilder: (context, day, focusedDay) {
        final provider = context.read<CalendarioFuncionalidades>();
        final eventoDoDia = provider.tudoJunto[normalizarData(day)];
        final cor = eventoDoDia?.first.cor ?? tema.primaryContainer;
        if (day.month != focusedDay.month) {
          // Retorna o estilo padrão (sem destaque)
          return estiloDosBlocosDosDiasDoMesDesabilitados(
              heigth, tema); // ou estilo padrão neutro
        }
        return estiloDoBlocoDoDiaDeHoje(context, day, cor, heigth, tema);
      },

      //dias dos meses diferentes do selecionado
      outsideBuilder: (context, day, focusedDay) =>
          estiloDosBlocosDosDiasDoMesDesabilitados(heigth, tema),
      disabledBuilder: (context, day, focusedDay) =>
          estiloDosBlocosDosDiasDoMesDesabilitados(heigth, tema),

      //notificação de evento no dia
      markerBuilder: (context, date, events) {
        return Container();
      });
}
