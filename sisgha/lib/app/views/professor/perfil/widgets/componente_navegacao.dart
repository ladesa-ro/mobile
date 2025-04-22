import 'package:flutter/material.dart';

import '../../../../core/utils/icones.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/estilos.dart';
import 'componente_disponibilidade.dart';
import 'componente_ensino.dart';

class NavSwitch extends StatefulWidget {
  const NavSwitch({super.key});

  @override
  State<NavSwitch> createState() => _NavSwitchState();
}

class _NavSwitchState extends State<NavSwitch> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _estiloTabs('Disponibilidade', Icones.iconeSisgha, 0,
                    bordaEsquerda: true, bordaDireita: false),
                _estiloTabs('Ensino', Icones.disciplina, 1,
                    bordaEsquerda: false, bordaDireita: true),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.9,
            width: constraints.maxWidth,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: const [
                WidgetDisponibilidade(),
                WidgetEnsino(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _estiloTabs(String texto, IconData icone, int index,
      {required bool bordaEsquerda, required bool bordaDireita}) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        _controller.animateTo(index);
      },
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        decoration: _boxDecoration(index, bordaEsquerda, bordaDireita),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              texto,
              style: estiloTexto(
                15,
                cor: _controller.index == index
                    ? CoresClaras.verdePrincipalTexto
                    : CoresClaras.verdecinzaTexto,
                peso: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              icone,
              color: _controller.index == index
                  ? CoresClaras.verdePrincipalTexto
                  : CoresClaras.verdecinzaTexto,
              size: index == 0 ? 20 : 25,
            ),
          ],
        ),
      ),
    ));
  }

  BoxDecoration _boxDecoration(
      int index, bool bordaEsquerda, bool bordaDireita) {
    return BoxDecoration(
      color: _controller.index == index
          ? CoresClaras.corDeFundoClara
          : CoresClaras.branco,
      borderRadius: BorderRadius.horizontal(
        left: bordaEsquerda ? const Radius.circular(10) : Radius.zero,
        right: bordaDireita ? const Radius.circular(10) : Radius.zero,
      ),
      border: Border.all(
        color: _controller.index == index
            ? CoresClaras.verdePrincipalBorda
            : CoresClaras.verdecinzaBorda,
      ),
    );
  }
}
