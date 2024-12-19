import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../constants/Icones.dart';
import '../../constants/colors.dart';
import '../../constants/dias.dart';
import '../../constants/tamanhoTela.dart';
import '../../widgets/appBar.dart';
import '../../widgets/mini_calend.dart';
import 'widgetsCalendario/letreiro_rolante.dart';
import 'widgetsCalendario/menu_lateral.dart';

class Calendar extends StatelessWidget {
  Calendar({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var appBar = CustomAppBar(
        height: 7.h,
        titulo: "Calendário Parcial",
        subtitulo: '${DatasFormatadas.mesAtual} - ${DatasFormatadas.anoAtual}');

    double tamanho =
        TamanhoTela.height(context, appBarSize: appBar.preferredSize.height);
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      appBar: appBar,
      drawer: MenuLateral(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 35),
        children: [
          SizedBox(height: tamanho * 0.03),
          SizedBox(
            height: tamanho * 0.085,
            width: TamanhoTela.horizontal(context),
            child: Row(
              children: [
                SizedBox(
                    height: tamanho * 0.85,
                    width: (TamanhoTela.horizontal(context) - tamanho * 0.085) -
                        85,
                    child: LetreiroRolante()),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  height: tamanho * 0.085,
                  width: tamanho * 0.085,
                  child: ElevatedButton(
                      style: _estiloBotao(),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Icones.Lupa),
                ),
              ],
            ),
          ),
          SizedBox(
            height: tamanho * 0.03,
          ),
          SizedBox(
            height: tamanho * 0.55,
            width: TamanhoTela.horizontal(context),
            child: MiniCalendario(
              showDialog: false,
            ),
          ),
        ],
      ),
    );
  }
}

ButtonStyle _estiloBotao() {
  return ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    backgroundColor: WidgetStatePropertyAll(ColorApp.VerdePrincipal),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
