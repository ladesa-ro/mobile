import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/widgets/cards_calendario.dart';
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
import '../../listagemDeEvento/modal_eventos_alunos.dart';
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: estiloBorda(
                        cor: tema.tertiary,
                        radius: 15,
                        grossuraBorda: 2,
                      ),
                      height: 40,
                      child: Center(
                        child: Consumer<EscolhaCalendario>(
                          builder: (BuildContext context,
                                  EscolhaCalendario value, Widget? child) =>
                              TextScroll(
                            velocity: Velocity(pixelsPerSecond: Offset(5, 0)),
                            'Técnico Integrado - Informática 2023 - 2023',
                            style: estiloTexto(15,
                                cor: tema.primary, peso: FontWeight.bold),
                            mode: TextScrollMode.bouncing,
                          ),
                        ),
                      ),
                    ),
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
                    child: Icones.lupa,
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
                    daysOfWeekHeight: 4.h,
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
                    builder: (context) => ModalEventosAlunos(),
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
