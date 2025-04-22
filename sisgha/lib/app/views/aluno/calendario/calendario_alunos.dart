import 'package:flutter/material.dart';
import 'package:sisgha/app/views/aluno/calendario/widgets/cards_alunos.dart';
import 'package:sisgha/app/views/components/letreiro_rolante.dart';

import 'package:sizer/sizer.dart';

import '../../../core/utils/icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/padroes.dart';
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

    double tamanho = Padroes.calcularAlturaAppBar(context,
        appBarSize: appBar.preferredSize.height);
    double largura = Padroes.larguraGeral();
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      appBar: appBar,
      drawer: MenuLateralAlunos(),
      body: ListView(
        padding: Padroes.margem(),
        children: [
          SizedBox(height: tamanho * 0.03),
          SizedBox(
            height: tamanho * 0.085,
            width: Padroes.larguraGeral(),
            child: Row(
              children: [
                SizedBox(
                    height: Padroes.aluturaBotoes(),
                    width: (largura * 0.93) - 80,
                    child: LetreiroRolante()),
                Spacer(),
                SizedBox(
                  height: Padroes.aluturaBotoes(),
                  width: largura * 0.15, //Motivo do erro de respansividade
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
            width: Padroes.larguraGeral(),
            child: MiniCalendario(
              showDialog: false,
            ),
          ),
          SizedBox(
            height: tamanho * 0.03,
          ),
          SizedBox(
            height: tamanho * 0.55,
            width: Padroes.larguraGeral(),
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
