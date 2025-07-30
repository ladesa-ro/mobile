import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../core/utils/estilos.dart';
import '../../../core/utils/icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/padroes.dart';
import '../../../cache/escolha_calendario.dart';
import '../../components/appbar.dart';
import 'widgets/cards_alunos.dart';
import 'widgets/menu_lateral_alunos.dart';

class CalendarioAlunos extends StatefulWidget {
  const CalendarioAlunos({super.key});

  @override
  State<CalendarioAlunos> createState() => _CalendarioAlunosState();
}

class _CalendarioAlunosState extends State<CalendarioAlunos> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
           //   child:
                //  RepaintBoundary(child: MiniCalendario(showDialog: false))
            ),
            SizedBox(height: tamanho * 0.03),
            RepaintBoundary(
              child: CardsAlunos(),
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
    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
