// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
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
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: TamanhoTela.horizontal(context),
        height: TamanhoTela.horizontal(context),
        child: TableCalendar(
          daysOfWeekHeight: TamanhoTela.vertical(context) > 700 ? 38 : 30,
          daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              weekdayStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          locale: 'pt_BR',
          firstDay: DateTime.utc(DateTime.now().year, 1, 1),
          lastDay: DateTime.utc(DateTime.now().year, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: calendarFormat,
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
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, date, events) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 55, 0, 255),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Color.fromRGBO(197, 197, 197, 0.514),
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.white),
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
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              );
            },
            defaultBuilder: (context, date, events) {
              final now = DateTime.now();
              final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
              final endOfWeek = startOfWeek.add(Duration(days: 5));

              final isSameWeek =
                  date.isAfter(startOfWeek) && date.isBefore(endOfWeek);

              Color color;
              if (isSameWeek) {
                color = Color.fromARGB(255, 69, 0, 158);
              } else if (date.isAfter(DateTime(now.year, 4, 17)) &&
                  date.isBefore(DateTime(now.year, 6, 20))) {
                color = Color.fromARGB(255, 69, 0, 158);
              } else if (date.isAfter(DateTime(now.year, 7, 22)) &&
                  date.isBefore(DateTime(now.year, 9, 25))) {
                color = Color(0xFFB20A33);
              } else if (date.isAfter(DateTime(now.year, 9, 24)) &&
                  date.isBefore(DateTime(now.year, 11, 29))) {
                color = Colors.amber;
              } else if (date.isAfter(DateTime(now.year, 2, 7)) &&
                  date.isBefore(DateTime(now.year, 4, 1))) {
                color = Color(0xFF08C17F);
              } else if (date.isAfter(DateTime(now.year, 6, 19)) &&
                  date.isBefore(DateTime(now.year, 7, 23))) {
                color = Colors.redAccent;
              } else {
                TextStyle(color: Colors.transparent);
                color = Color.fromRGBO(217, 217, 217, 100);
              }

              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                  child: Text('${date.day}',
                      style: TextStyle(
                        color: ColorApp.Branco,
                      )),
                ),
              );
            },
            outsideBuilder: (context, date, events) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Color.fromRGBO(217, 217, 217, 100),
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle(color: const Color.fromARGB(0, 255, 0, 0)),
                  ),
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
