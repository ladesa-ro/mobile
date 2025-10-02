import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/widgets/cards_calendario.dart';
import 'package:sisgha/widgets/letreiro_rolante.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../core/utils/estilos.dart';
import '../../../core/utils/icones.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/padroes.dart';
import '../../../viewmodels/calendario_funcionalidades.dart';
import '../../../viewmodels/escolha_calendario.dart';
import '../../../widgets/calendario.dart';
import '../../professor/calendario/calendario.dart';
import '../../listagem_de_eventos/listagem_de_eventos.dart';
import 'widgets/menu_lateral_alunos.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarioAlunos extends StatefulWidget {
  const CalendarioAlunos({super.key});

  @override
  State<CalendarioAlunos> createState() => _CalendarioAlunosState();
}

class _CalendarioAlunosState extends State<CalendarioAlunos> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    final hoje = normalizarData(DateTime.now());
    _selectedDay = hoje;
    _focusedDay = hoje;
  }

  @override
  Widget build(BuildContext context) {
    double tamanho = Padroes.calcularAlturaAppBar(context, appBarSize: 7.h);
    EdgeInsets margem = Padroes.margem();
    double largura = Padroes.larguraGeral() - margem.horizontal;
    final tema = Theme.of(context).colorScheme;

    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      endDrawer: const MenuLateralAlunos(),
      body: SingleChildScrollView(
        padding: margem,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: tamanho * 0.03),
            Row(
              children: [
                SizedBox(
                  height: Padroes.aluturaBotoes(),
                  width: largura * 0.80,
                  child: RepaintBoundary(
                    child: LetreiroRolante(),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: Padroes.aluturaBotoes(),
                  width: largura * 0.17,
                  child: ElevatedButton(
                    style: _estiloBotao(tema),
                    onPressed: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                    child: Icon(
                      Icones.lupa,
                      color: tema.primaryFixed,
                      size: 4.h,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: tamanho * 0.03),
            SizedBox(
              height: tamanho * 0.55,
              width: largura,
              child: RepaintBoundary(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: tema.onSecondary),
                      borderRadius: BorderRadius.circular(15)),
                  child: TableCalendar(
                    availableGestures: AvailableGestures.none,
                    firstDay: DatasFormatadas.primeiroDiaDoAno,
                    lastDay: DatasFormatadas.ultimoDiaDoAno,
                    focusedDay: _focusedDay,
                    calendarFormat: CalendarFormat.month,
                    locale: 'pt-BR',
                    shouldFillViewport: true,
                    daysOfWeekHeight: 23,
                    daysOfWeekStyle: estiloParteSuperior(tema),
                    headerStyle: estiloCabessario(tema),
                    calendarBuilders:
                        calendarBuilder(120.sp, _focusedDay, tema),
                    pageAnimationCurve: Curves.linear,
                    pageAnimationDuration: const Duration(milliseconds: 300),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    eventLoader: (day) {
                      final provider =
                          Provider.of<CalendarioFuncionalidades>(context);
                      final dataNormalizada = normalizarData(day);
                      return provider.tudoJunto[dataNormalizada] ?? [];
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: tamanho * 0.03,
            ),
            SizedBox(
              width: largura,
              height: Padroes.aluturaBotoes(),
              child: ElevatedButton(
                style: _estiloBotao(tema),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    isScrollControlled: true,
                    enableDrag: false,
                    backgroundColor: Color.fromARGB(88, 0, 0, 0),
                    builder: (context) => ListagemDeEventos(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ver todos os eventos",
                      style: estiloTexto(
                        16,
                        cor: tema.inversePrimary,
                        peso: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icones/Vector.svg',
                      width: 24,
                      height: 24,
                      color: tema.primaryFixed,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: tamanho * 0.03),
            cardCalendario(_selectedDay, tamanho, largura, tema)
          ],
        ),
      ),
    );
  }
}

ButtonStyle _estiloBotao(ColorScheme tema) {
  return ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    backgroundColor: WidgetStatePropertyAll(tema.primaryContainer),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
