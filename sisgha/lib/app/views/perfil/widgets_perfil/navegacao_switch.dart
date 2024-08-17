import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhotela.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widget_disponibilidade.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widget_ensino.dart';

class NavSwitch extends StatefulWidget {
  NavSwitch({Key? key, required this.alturaNotifier}) : super(key: key);
  final ValueNotifier<double> alturaNotifier;

  @override
  State<NavSwitch> createState() => _NavSwitchState();
}

class _NavSwitchState extends State<NavSwitch> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _onOff = true;
  double _movendoParaEsquerda = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    _tabController.addListener(() {
      setState(() {
        _onOff = _tabController.index == 0 ? true : false;
        _movendoParaEsquerda = _onOff ? 0 : TamanhoTela.horizontal(context);

        widget.alturaNotifier.value = _tabController.index == 0 ? 900 : 500;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 233, 233),
            borderRadius: BorderRadius.circular(50),
          ),
          width: TamanhoTela.horizontal(context),
          height: 65,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double movendoParaDireita = constraints.maxWidth * 0.50;

              return GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _movendoParaEsquerda += details.delta.dx;
                    if (_movendoParaEsquerda < 0) {
                      _movendoParaEsquerda = 0;
                    } else if (_movendoParaEsquerda > 200) {
                      _movendoParaEsquerda = 200;
                    }
                  });
                },
                onHorizontalDragEnd: (details) {
                  setState(
                    () {
                      double midpoint = movendoParaDireita / 2;
                      if (_movendoParaEsquerda < midpoint) {
                        _movendoParaEsquerda = 0;
                        _tabController.animateTo(0);
                      } else {
                        _movendoParaEsquerda = 200;
                        _tabController.animateTo(1);
                      }
                    },
                  );
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      left: _movendoParaEsquerda < movendoParaDireita
                          ? _movendoParaEsquerda
                          : movendoParaDireita,
                      child: container(constraints.maxWidth),
                    ),
                    TabBar(
                      labelColor: ColorApp.Branco,
                      unselectedLabelColor: ColorApp.VerdeCinza,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      tabs: [
                        Text('Disponibilidade',
                            style: estiloTexto(15, peso: FontWeight.bold)),
                        Text('Ensino',
                            style: estiloTexto(15, peso: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Flexible(
          child: TabBarView(
            controller: _tabController,
            children: [
              disponibilidade(),
              const WidgetEnsino(),
            ],
          ),
        ),
      ],
    );
  }

  Widget container(double tamanho) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ColorApp.VerdePrincipal,
      ),
      width: tamanho * 0.50 - 20,
      height: 50,
    );
  }
}
