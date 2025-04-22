import 'package:flutter/material.dart';
import 'package:sisgha/app/views/professor/calendario/widgets/card_professor.dart';

import 'package:sizer/sizer.dart';

import '../../../core/utils/icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/responsividade.dart';
import '../../../core/utils/tamanhos.dart';
import '../../components/appbar.dart';
import '../../components/calendario.dart';
import '../../components/letreiro_rolante.dart';
import 'widgets/menu_lateral.dart';

class CalendarioProfessor extends StatelessWidget {
  CalendarioProfessor({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var appBar = CustomAppBar(
      height: 7.h,
      mes: '${DatasFormatadas.mesAtualFormatado} - ${DatasFormatadas.anoAtual}',
      diaHoje: "Calendário Parcial",
      icones: false,
    );

    double tamanho =
        TamanhoTela.height(context, appBarSize: appBar.preferredSize.height);
    EdgeInsets margem = Tamanhos.margem();

    double largura = Tamanhos.larguraGeral() - margem.horizontal;

    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      appBar: appBar,
      drawer: MenuLateral(),
      body: ListView(
        padding: margem,
        children: [
          SizedBox(height: tamanho * 0.03),
          SizedBox(
            height: tamanho * 0.085,
            width: TamanhoTela.horizontal(context),
            child: Row(
              children: [
                SizedBox(
                    height: Tamanhos.aluturaBotoes(),
                    width: largura * 0.80,
                    child: LetreiroRolante()),
                Spacer(),
                SizedBox(
                  height: Tamanhos.aluturaBotoes(),
                  width: largura * 0.17,
                  child: ElevatedButton(
                      style: _estiloBotao(),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Icones.lupa),
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
          SizedBox(
            height: tamanho * 0.03,
          ),
          SizedBox(
            height: tamanho * 0.55,
            width: TamanhoTela.horizontal(context),
            child: CardsProfessor(),
          ),
        ],
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
