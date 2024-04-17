import 'package:flutter/material.dart';
import 'package:sisgha_mobile/pages/barra_top.dart';
import 'package:sisgha_mobile/pages/estilos.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;
    initializeDateFormatting('pt_BR', null);

    DateTime now = DateTime.now();

    DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));

    DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));

    DateFormat portugueseDateFormat = DateFormat('MMMM', 'pt_BR');

    String formattedFirstDayOfWeek =
        portugueseDateFormat.format(firstDayOfWeek)[0].toUpperCase() +
            portugueseDateFormat.format(firstDayOfWeek).substring(1) +
            ' ' +
            DateFormat('dd').format(firstDayOfWeek);
    String formattedLastDayOfWeek = DateFormat('dd').format(lastDayOfWeek);

    String formattedYear = DateFormat('yyyy').format(now);

    String formattedDate =
        '$formattedFirstDayOfWeek - $formattedLastDayOfWeek, $formattedYear';

    return Scaffold(
      appBar: CustomAppBar(height: 80),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            height: 70,
            width: 390,
            child: ElevatedButton(
              style: estiloBotao(context),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(0),
                      content: Container(
                        width: double.maxFinite,
                        height: 370,
                        child: TableCalendar(
                          daysOfWeekHeight: 0,
                          locale: 'pt_BR',
                          firstDay: DateTime.utc(2024, 1, 1),
                          lastDay: DateTime.utc(2024, 12, 31),
                          focusedDay: _focusedDay,
                          calendarFormat: _calendarFormat,
                          headerStyle: const HeaderStyle(
                            leftChevronIcon: Icon(Icons.chevron_left_sharp,
                                color: Colors.white),
                            rightChevronIcon: Icon(Icons.chevron_right_sharp,
                                color: Colors.white),
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
                                  color: Color(0xFF7EDFBC),
                                  borderRadius: BorderRadius.circular(11),
                                  border: Border.all(
                                    color: Color.fromRGBO(8, 193, 127, 100),
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
                              final formattedMonth =
                                  DateFormat.MMMM('pt_BR').format(date);
                              final capitalizedMonth =
                                  formattedMonth[0].toUpperCase() +
                                      formattedMonth.substring(1);
                              return Center(
                                child: Text(
                                  capitalizedMonth,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              );
                            },
                            defaultBuilder: (context, date, events) {
                              final now = DateTime.now();
                              final startOfWeek =
                                  now.subtract(Duration(days: now.weekday - 1));
                              final endOfWeek =
                                  startOfWeek.add(Duration(days: 5));

                              final isSameWeek = date.isAfter(startOfWeek) &&
                                  date.isBefore(endOfWeek);

                              Color color;
                              if (isSameWeek) {
                                color = Color(0xFF7EDFBC);
                              } else if (date
                                      .isAfter(DateTime(now.year, 4, 17)) &&
                                  date.isBefore(DateTime(now.year, 6, 20))) {
                                color = Color(0xFFAE31DA);
                              } else if (date
                                      .isAfter(DateTime(now.year, 7, 22)) &&
                                  date.isBefore(DateTime(now.year, 9, 25))) {
                                color = Color(0xFFB20A33);
                              } else if (date
                                      .isAfter(DateTime(now.year, 9, 24)) &&
                                  date.isBefore(DateTime(now.year, 11, 29))) {
                                color = Colors.amber;
                              } else if (date
                                      .isAfter(DateTime(now.year, 2, 7)) &&
                                  date.isBefore(DateTime(now.year, 4, 1))) {
                                color = Color(0xFF08C17F);
                              } else if (date
                                      .isAfter(DateTime(now.year, 6, 19)) &&
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
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
                                    style: TextStyle(color: Colors.transparent),
                                  ),
                                ),
                              );
                            },
                          ),
                          onFormatChanged: (format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          availableGestures: AvailableGestures.none,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    size: 40,
                    color: Colors.white,
                    Icons.calendar_month,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    formattedDate,
                    style: estiloTexto(18,
                        cor: Colors.white, peso: FontWeight.w700),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
