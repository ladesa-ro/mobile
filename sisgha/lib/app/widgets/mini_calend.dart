import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/constants/colors.dart';
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
    CalendarFormat calendarFormat = CalendarFormat.month;
    DateTime focusedDay = DateTime.now();
    DateTime? selectedDay;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: SizedBox(
        height: TamanhoTela.vertical(context) > 810 ? 425 : 390,
        width: TamanhoTela.vertical(context) > 810 ? 385 : 335,
        child: TableCalendar(
          // Configurações dos nomes dos dias da semana ex: seg. ter. etc
          daysOfWeekHeight: TamanhoTela.vertical(context) > 810 ? 50 : 40,
          rowHeight: TamanhoTela.vertical(context) > 810 ? 48 : 40,
          daysOfWeekStyle: DaysOfWeekStyle(
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
            weekendStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            weekdayStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),

          //configuraçoes padroes
          locale: 'pt_BR',
          firstDay: DateTime.utc(DateTime.now().year, 1, 1),
          lastDay: DateTime.utc(DateTime.now().year, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: calendarFormat,

          // configuraçoes do cabeçalho do calendario
          headerStyle: const HeaderStyle(
              leftChevronIcon: Icon(
                Icons.chevron_left_sharp,
                color: Colors.white,
                size: 30,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right_sharp,
                color: Colors.white,
                size: 30,
              ),
              formatButtonVisible: false,
              titleCentered: true,
              headerMargin: EdgeInsets.zero,
              headerPadding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: ColorApp.RoxoEscuro,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              )),

          calendarBuilders: CalendarBuilders(
            //formata o quadrado do dia de hoje
            todayBuilder: (context, date, events) {
              return Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 69, 0, 158),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorApp.Branco, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )));
            },
            //constroi o titulo/mes do calendario
            headerTitleBuilder: (context, date) {
              final formattedMonth = DateFormat.MMMM('pt_BR').format(date);
              final capitalizedMonth = formattedMonth.toUpperCase();
              return Center(
                child: Text(capitalizedMonth,
                    style: estiloTexto(17,
                        cor: ColorApp.Branco, peso: FontWeight.bold)),
              );
            },
            defaultBuilder: (context, date, events) {
              final now = DateTime.now();
              final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
              final endOfWeek = startOfWeek.add(const Duration(days: 5));

              final isSameWeek =
                  date.isAfter(startOfWeek) && date.isBefore(endOfWeek);

              Color color;
              if (isSameWeek) {
                color = const Color.fromARGB(255, 69, 0, 158);
              } else if (date.isAfter(DateTime(now.year, 4, 17)) &&
                  date.isBefore(DateTime(now.year, 6, 20))) {
                color = const Color.fromARGB(255, 69, 0, 158);
              } else if (date.isAfter(DateTime(now.year, 7, 22)) &&
                  date.isBefore(DateTime(now.year, 9, 25))) {
                color = const Color(0xFFB20A33);
              } else if (date.isAfter(DateTime(now.year, 9, 24)) &&
                  date.isBefore(DateTime(now.year, 11, 29))) {
                color = Colors.amber;
              } else if (date.isAfter(DateTime(now.year, 2, 7)) &&
                  date.isBefore(DateTime(now.year, 4, 1))) {
                color = const Color(0xFF08C17F);
              } else if (date.isAfter(DateTime(now.year, 6, 19)) &&
                  date.isBefore(DateTime(now.year, 7, 23))) {
                color = Colors.redAccent;
              } else {
                const TextStyle(color: Colors.transparent);
                color = const Color.fromRGBO(217, 217, 217, 100);
              }

              //configurações dos quadrados onde estao os dias do mês menos o dia de hoje
              return Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('${date.day}',
                      style: const TextStyle(
                        color: ColorApp.Branco,
                      )),
                ),
              );
            },

            //dias de outros meses que aparecem apagados/cobertos pela cor cinza
            outsideBuilder: (context, date, events) {
              return Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(217, 217, 217, 100),
                ),
              );
            },
          ),
          onFormatChanged: (format) {
            setState(() {
              calendarFormat = format;
            });
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              selectedDay = selectedDay;
              focusedDay = focusedDay;
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          availableGestures: AvailableGestures.all,
        ),
      ),
    );
  }
}
