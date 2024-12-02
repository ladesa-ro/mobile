import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/views/calendario/widgetsCalendario/menuLateral.dart';
import 'package:sisgha/app/widgets/appBar.dart';
import 'package:sisgha/app/widgets/mini_calend.dart';
import 'package:sizer/sizer.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int anoSelecionado = 0;
  int modalidadeSelecionada = 0;
  static const listaModalidades = [
    'Técnico Integrado',
    'Graduação',
    'Técnico Concomitante',
    'Técnico Subsequente'
  ];
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
      drawer: menuLateral(),
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
                    child: letreiroRolante()),
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

  Widget letreiroRolante() {
    return LayoutBuilder(
      builder: (context, constraints) => IgnorePointer(
        child: Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: estiloBorda(
              cor: ColorApp.VerdeCinzaBorda, radius: 15, grossuraBorda: 2),
          child: ListView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Técnico Integrado - Informática 2023 - 2023',
                  style: estiloTexto(15,
                      cor: ColorApp.VerdePrincipalTexto, peso: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Drawer menuLateral() {
    return Drawer(
      width: TamanhoTela.horizontal(context) * 0.8,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: constraints.maxHeight * 0.03),
              headerDrawer(
                  context, constraints.maxHeight, constraints.maxWidth),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                'Ano Letivo',
                style: estiloTexto(16,
                    cor: ColorApp.VerdePrincipal, peso: FontWeight.bold),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
                width: constraints.maxWidth,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => setState(() {
                      anoSelecionado = index;
                    }),
                    child: quadradoAnoLetivo(
                        context,
                        constraints.maxWidth,
                        "202$index - $anoSelecionado",
                        anoSelecionado == index ? true : false),
                  ),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Modalidade',
                    style: estiloTexto(16,
                        cor: ColorApp.VerdePrincipal, peso: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: constraints.maxWidth * 0.02,
                    runSpacing: constraints.maxHeight * 0.01,
                    children: listaModalidades.asMap().entries.map((entry) {
                      int index = entry.key;
                      String modalidade = entry.value;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            modalidadeSelecionada = index;
                          });
                        },
                        child: quadradoModalidades(
                            modalidadeSelecionada == index,
                            modalidade,
                            constraints.maxWidth),
                      );
                    }).toList(),
                  )
                ],
              ),
              Spacer(),
              SizedBox(
                height: constraints.maxHeight * 0.07,
                child: ElevatedButton(
                    style: _estiloBotao(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Buscar',
                        style: estiloTexto(15, cor: ColorApp.BrancoTexto),
                      ),
                    )),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.02,
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
