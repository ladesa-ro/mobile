import 'package:flutter/material.dart';
import 'package:sisgha/app/views/professor/calendario/widgets/card_professor.dart';

import 'package:sizer/sizer.dart';

import '../../../core/utils/Icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/responsividade.dart';
import '../../../core/utils/tamanhos.dart';
import '../../components/appbar.dart';
import '../../components/calendario.dart';
import 'widgets/letreiro_rolante.dart';
import 'widgets/menu_lateral.dart';

class Calendar extends StatelessWidget {
  Calendar({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var appBar = CustomAppBar(
      height: 7.h,
      mes: '${DatasFormatadas.mesAtualFormatado} - ${DatasFormatadas.anoAtual}',
      diaHoje: "Calendário Parcial",
      profOuAluno: false,
    );

    double tamanho =
        TamanhoTela.height(context, appBarSize: appBar.preferredSize.height);
    double largura = Tamanhos.larguraGeral();
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
                SizedBox(
                    height: Tamanhos.aluturaBotoes(),
                    width: (largura * 0.93) - 80,
                    child: LetreiroRolante()),
                  Spacer(),
                SizedBox(
                  height: Tamanhos.aluturaBotoes(),
                  width: largura * 0.15,
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
