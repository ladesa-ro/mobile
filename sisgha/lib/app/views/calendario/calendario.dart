import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/widgets/appBar.dart';
import 'package:sisgha/app/widgets/mini_calend.dart';
import 'package:sizer/sizer.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late ScrollController _controller;
  bool verificacao = true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 0.0);
    Future.delayed(Duration(seconds: 1), () => salvar());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void salvar() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      verificacao = false;
      animacao();
    }
    if (_controller.offset <= _controller.position.minScrollExtent) {
      verificacao = true;
      animacao();
    }
  }

  void animacao() {
    _controller
        .animateTo(
            verificacao
                ? _controller.position.maxScrollExtent
                : _controller.position.minScrollExtent,
            duration: Duration(seconds: 10),
            curve: Curves.easeInOut)
        .then((funciona) =>
            Future.delayed(Duration(milliseconds: 1500), () => salvar()));
  }

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
                      onPressed: () {
                        setState(() {
                          salvar();
                        });
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

  Widget container() {
    return LayoutBuilder(
      builder: (context, constraints) => IgnorePointer(
        child: Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: estiloBorda(
              cor: ColorApp.VerdeCinza, radius: 15, grossuraBorda: 2),
          child: ListView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Técnico Integrado - Informática 2023 - 2023',
                  style: estiloTexto(15,
                      cor: ColorApp.VerdePrincipal, peso: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
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
