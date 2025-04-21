import 'package:flutter/material.dart';
import 'package:sisgha/app/views/aluno/calendario_alunos/widgets/cards_alunos.dart';
import 'package:sisgha/app/views/components/letreiro_rolante.dart';

import 'package:sizer/sizer.dart';

import '../../../core/utils/Icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/responsividade.dart';
import '../../../core/utils/tamanhos.dart';
import '../../components/appbar.dart';
import '../../components/calendario.dart';
import 'widgets/menu_lateral_alunos.dart';

class CalendarAlunos extends StatelessWidget {
  CalendarAlunos({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //deixei como false pois aparecia a seta de voltar na appbar do calendário
    var appBar = CustomAppBar(
      height: 7.h,
      mes: '${DatasFormatadas.mesAtualFormatado} - ${DatasFormatadas.anoAtual}',
      diaHoje: "Calendário Parcial",
      icones: false,
    );

    double tamanho =
        TamanhoTela.height(context, appBarSize: appBar.preferredSize.height);
    double largura = Tamanhos.larguraGeral();
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      appBar: appBar,
      drawer: MenuLateralAlunos(),
      body: ListView(
        padding: Tamanhos.margem(),
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
                  width: largura * 0.15, //Motivo do erro de respansividade
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
            child: CardsAlunos(),
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
