import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../core/utils/Icones.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/dias.dart';
import '../../core/utils/responsividade.dart';
import '../../core/utils/tamanhos.dart';
import '../widgets_globais/appbar.dart';
import '../widgets_globais/calendario.dart';
import 'widgets/letreiro_rolante.dart';
import 'widgets/menu_lateral.dart';

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
        padding: Tamanhos.margem(context),
        children: [
          SizedBox(height: tamanho * 0.03),
          SizedBox(
            height: tamanho * 0.085,
            width: TamanhoTela.horizontal(context),
            child: Row(
              children: [
                // SizedBox(
                //     height: tamanho * 0.85,
                //     width: (TamanhoTela.horizontal(context) - tamanho * 0.085) -
                //         80,
                //     child: LetreiroRolante()),
                Spacer(),
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
