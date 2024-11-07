import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/views/calendario/widgetsCalendario/botoes.dart';
import 'package:sisgha/app/widgets/appBar.dart';
import 'package:sisgha/app/widgets/mini_calend.dart';
import 'package:sizer/sizer.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = CustomAppBar(
        height: 7.h,
        titulo: "Calendário Parcial",
        subtitulo: '${DatasFormatadas.mesAtual} - ${DatasFormatadas.anoAtual}');

    double tamanho =
        TamanhoTela.height(context, appBarSize: appBar.preferredSize.height);
    return Scaffold(
      appBar: appBar,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 35),
        children: [
          SizedBox(
            height: tamanho * 0.03,
          ),
          SizedBox(
            height: tamanho * 0.085,
            width: TamanhoTela.horizontal(context),
            child: Row(
              children: [
                SizedBox(
                    height: tamanho * 0.85,
                    width: (TamanhoTela.horizontal(context) - tamanho * 0.085) -
                        85,
                    child: container()),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  height: tamanho * 0.085,
                  width: tamanho * 0.085,
                  child: ElevatedButton(
                      style: _estiloBotao(),
                      onPressed: () {},
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
