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
        width: TamanhoTela.horizontal(context) - 40,
        height: TamanhoTela.vertical(context) * 0.50,
        child: TableCalendar(
          firstDay: DatasFormatadas.primeiroDiaDoAno,
          lastDay: DatasFormatadas.ultimoDiaDoAno,
          focusedDay: DatasFormatadas.diaAtualEmNumero,
          calendarFormat: CalendarFormat.month,
          locale: 'pt-BR',
          headerStyle: estiloCabessario(),
        ),
      ),
    );
  }

  HeaderStyle estiloCabessario() {
    return HeaderStyle(
      headerMargin: EdgeInsets.zero,
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
}
