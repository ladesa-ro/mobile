import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/cache/calendario_funcionalidades.dart';
import 'package:sisgha/app/views/components/calendario.dart';
import 'package:sisgha/app/views/professor/calendario/calendario.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../core/utils/estilos.dart';
import '../../../core/utils/icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/padroes.dart';
import '../../../cache/escolha_calendario.dart';
import '../../components/appbar.dart';
import 'widgets/menu_lateral_alunos.dart';

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
    var appBar = CustomAppBar(
      height: 7.h,
      mes: '${DatasFormatadas.mesAtualFormatado} - ${DatasFormatadas.anoAtual}',
      diaHoje: "Calendário Parcial",
      icones: false,
      animacaoAtiva: true,
    );

    double tamanho = Padroes.calcularAlturaAppBar(context,
        appBarSize: appBar.preferredSize.height);
    EdgeInsets margem = Padroes.margem();
    double largura = Padroes.larguraGeral() - margem.horizontal;

    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      appBar: appBar,
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
                        cor: CoresClaras.verdecinzaBorda,
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
                                cor: CoresClaras.verdePrincipal,
                                peso: FontWeight.bold),
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
                    style: _estiloBotao(context),
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
                      border: Border.all(color: CoresClaras.cinzaBordas),
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
                    daysOfWeekStyle: estiloParteSuperior(context),
                    headerStyle: estiloCabessario(),
                    calendarBuilders: calendarBuilder(120.sp, _focusedDay),
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
            SizedBox(height: tamanho * 0.03),
            Consumer<CalendarioFuncionalidades>(
              builder: (context, provider, _) {
                final data = normalizarData(_selectedDay);
                final eventos = provider.tudoJunto[data] ?? [];

                if (eventos.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: tamanho * 0.03),
                    child: Text(
                      "Nenhum evento para este dia.",
                      style: estiloTexto(15,
                          cor: CoresClaras.verdePrincipal,
                          peso: FontWeight.bold),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: eventos.length,
                  itemBuilder: (context, index) {
                    final evento = eventos[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border(
                          left: BorderSide(
                            color: evento.cor,
                            width: 5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    evento.titulo,
                                    style: estiloTexto(
                                      16,
                                      cor: evento.cor,
                                      peso: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(evento.dataInicio,
                                      style: estiloTexto(16)),
                                  Text(evento.dataTermino ?? '',
                                      style: estiloTexto(16)),
                                  Text(evento.tempo ?? '',
                                      style: estiloTexto(16)),
                                  Text(evento.local ?? '',
                                      style: estiloTexto(16)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              height: 45,
                              width: largura * 0.115,
                              child: IconButton(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: CoresClaras.verdePrincipal),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                icon: Iconify(
                                  Icones.sino,
                                  size: tamanho * 0.2,
                                  color: CoresClaras.verdePrincipal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

ButtonStyle _estiloBotao(BuildContext context) {
  return ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    backgroundColor:
        WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
