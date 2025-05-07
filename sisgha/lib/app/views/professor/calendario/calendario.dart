import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/padroes.dart';
import '../../components/appbar.dart';
import '../../components/calendario.dart';
import '../../components/letreiro_rolante.dart';
import 'widgets/card_professor.dart';
import 'widgets/menu_lateral.dart';

class CalendarioProfessor extends StatefulWidget {
  const CalendarioProfessor({super.key});

  @override
  State<CalendarioProfessor> createState() => _CalendarioProfessorState();
}

class _CalendarioProfessorState extends State<CalendarioProfessor> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var appBar = CustomAppBar(
      height: 7.h,
      mes: '${DatasFormatadas.mesAtualFormatado} - ${DatasFormatadas.anoAtual}',
      diaHoje: "Calendário Parcial",
      icones: false,
    );

    double tamanho = Padroes.calcularAlturaAppBar(context,
        appBarSize: appBar.preferredSize.height);
    EdgeInsets margem = Padroes.margem();
    double largura = Padroes.larguraGeral() - margem.horizontal;

    return Scaffold(
      key: scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      appBar: appBar,
      endDrawer: const MenuLateral(),
      body: SingleChildScrollView(
        physics: Padroes.efeitoDeRolagem(),
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
                    child: Center(child: LetreiroRolante()),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: Padroes.aluturaBotoes(),
                  width: largura * 0.17,
                  child: ElevatedButton(
                    style: _estiloBotao(),
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
                child:
                    RepaintBoundary(child: MiniCalendario(showDialog: false))),
            SizedBox(height: tamanho * 0.03),
            SizedBox(
              height: tamanho * 0.3,
              width: largura,
              child: RepaintBoundary(
                child: CardsProfessor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ButtonStyle _estiloBotao() {
  return ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    backgroundColor: WidgetStatePropertyAll(CoresClaras.verdePrincipal),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
