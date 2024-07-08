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
  double _leftPosition = 20;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    _tabController.addListener(() {
      setState(() {
        _onOff = _tabController.index == 0 ? true : false;
        _leftPosition = _onOff ? 20 : 200;
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
                borderRadius: BorderRadius.circular(50)),
            width: double.maxFinite,
            height: 60,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _leftPosition += details.delta.dx;
                  if (_leftPosition < 20) {
                    _leftPosition = 20;
                  } else if (_leftPosition > 200) {
                    _leftPosition = 200;
                  }
                });
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  double midpoint = (0 + 200) / 2;
                  if (_leftPosition < midpoint) {
                    _leftPosition = 0;
                    _tabController.animateTo(0);
                  } else {
                    _leftPosition = TamanhoTela.horizontal(context) - 40;
                    _tabController.animateTo(1);
                  }
                });
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    left: _leftPosition,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ColorApp.VerdePrincipal,
                      ),
                      width: 150,
                      height: 50,
                    ),
                  ),
                  TabBar(
                    labelColor: ColorApp.Branco,
                    unselectedLabelColor: ColorApp.VerdeCinza,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    tabs: [
                      Text(
                        'Disposição',
                        style: estiloTexto(15, peso: FontWeight.bold),
                      ),
                      Text(
                        'Ensino',
                        style: estiloTexto(15, peso: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            )),
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
}
