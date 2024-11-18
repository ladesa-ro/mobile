import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/views/calendario/widgetsCalendario/widgetDrawer.dart';
import 'package:sisgha/app/widgets/appBar.dart';
import 'package:sisgha/app/widgets/mini_calend.dart';
import 'package:sizer/sizer.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ScrollController _controller;
  bool _direcao = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _iniciarAnimacao();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _iniciarAnimacao() {
    if (!_controller.hasClients) return;

    final destino = _direcao
        ? _controller.position.maxScrollExtent
        : _controller.position.minScrollExtent;

    _controller
        .animateTo(
      destino,
      duration: const Duration(seconds: 10),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _direcao ? _direcao = false : _direcao = true;
      Future.delayed(const Duration(milliseconds: 1500), _iniciarAnimacao);
    });
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
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      appBar: appBar,
      drawer: menuLateral(context),
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

Drawer menuLateral(context) {
  return Drawer(
    width: TamanhoTela.horizontal(context) * 0.8,
    child: LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          SizedBox(
            height: 30,
          ),
          headerDrawer(context, constraints.maxHeight, constraints.maxWidth),
          Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
        ],
      ),
    ),
  );
}
