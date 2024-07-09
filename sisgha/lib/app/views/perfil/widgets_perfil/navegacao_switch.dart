import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';

class NavSwitch extends StatefulWidget {
  const NavSwitch({Key? key}) : super(key: key);

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
        _movendoParaEsquerda = _onOff ? 0 : double.infinity;
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
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 233, 233),
            borderRadius: BorderRadius.circular(50),
          ),
          width: TamanhoTela.horizontal(context) > 400 ? 410 : 350,
          height: 65,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double movendoParaDireita = TamanhoTela.horizontal(context) > 410
                  ? constraints.maxWidth - 180
                  : constraints.maxWidth - 150;
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
                  setState(() {
                    print(TamanhoTela.horizontal(context));
                    double midpoint = movendoParaDireita / 2;
                    if (_movendoParaEsquerda < midpoint) {
                      _movendoParaEsquerda = 0;
                      _tabController.animateTo(0);
                    } else {
                      _movendoParaEsquerda = 200;
                      _tabController.animateTo(1);
                    }
                  });
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      left: _movendoParaEsquerda < movendoParaDireita
                          ? _movendoParaEsquerda + 10
                          : movendoParaDireita - 10,
                      child: container(),
                    ),
                    TabBar(
                      labelColor: ColorApp.Branco,
                      unselectedLabelColor: ColorApp.VerdeCinza,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      tabs: [
                        Text('Disposição',
                            style: estiloTexto(15, peso: FontWeight.bold)),
                        Text(
                          'Ensino',
                          style: estiloTexto(15, peso: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              Text('Page 1'),
              Text('Page 2'),
            ],
          ),
        ),
      ],
    );
  }

  Widget container() {
    return Container(
      alignment: _onOff
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ColorApp.VerdePrincipal,
      ),
      width: TamanhoTela.horizontal(context) > 400 ? 180 : 150,
      height: 50,
    );
  }
}
