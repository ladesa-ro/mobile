import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/constants/colors.dart';
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
      content: SizedBox(
        width: TamanhoTela.horizontal(context),
        height: TamanhoTela.horizontal(context),
        child: TableCalendar(
          daysOfWeekHeight: 28,

          //configurações dos nomes dos dias da semana ex: seg. ter. etc
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekendStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            weekdayStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),

          //
          locale: 'pt_BR',
          firstDay: DateTime.utc(DateTime.now().year, 1, 1),
          lastDay: DateTime.utc(DateTime.now().year, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: calendarFormat,

          // configuraçoes do cabeçalho do calendario
          headerStyle: const HeaderStyle(
            leftChevronIcon:
                Icon(Icons.chevron_left_sharp, color: Colors.white),
            rightChevronIcon:
                Icon(Icons.chevron_right_sharp, color: Colors.white),
            formatButtonVisible: false,
            titleCentered: true,
            headerMargin: EdgeInsets.all(0),
            headerPadding: EdgeInsets.all(0),
            titleTextStyle: TextStyle(fontSize: 20),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
          ),

          //
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, date, events) {
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 0, 255),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color.fromRGBO(197, 197, 197, 0.514),
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
            headerTitleBuilder: (context, date) {
              final formattedMonth = DateFormat.MMMM('pt_BR').format(date);
              final capitalizedMonth =
                  formattedMonth[0].toUpperCase() + formattedMonth.substring(1);
              return Center(
                child: Text(
                  capitalizedMonth,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
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
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(11),
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
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
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
          availableGestures: AvailableGestures.none,
        ),
      ),
    );
  }
}
