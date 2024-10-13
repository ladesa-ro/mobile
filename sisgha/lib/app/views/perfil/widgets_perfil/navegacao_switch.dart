import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhotela.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widget_disponibilidade.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widget_ensino.dart';

class NavSwitch extends StatefulWidget {
  const NavSwitch({super.key, required this.alturaNotifier});
  final ValueNotifier<double> alturaNotifier;

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
      setState(() {
        widget.alturaNotifier.value = _controller.index == 0 ? 900 : 500;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: TamanhoTela.horizontal(context),
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _estiloTabs('Disponibilidade', Icones.IconeSisgha, 0,
                  bordaEsquerda: true, bordaDireita: false),
              _estiloTabs('Ensino', Icones.IconeSisgha, 1,
                  bordaEsquerda: false, bordaDireita: true),
            ],
          ),
        ),
        Flexible(
          child: TabBarView(
            controller: _controller,
            children: const [
              WidgetDisponibilidade(),
              WidgetEnsino(),
            ],
          ),
        ),
      ],
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
          duration: const Duration(milliseconds: 0),
          decoration: BoxDecoration(
            color: _controller.index == index
                ? ColorApp.VerdeFraco
                : ColorApp.Branco,
            borderRadius: BorderRadius.horizontal(
              left: bordaEsquerda ? const Radius.circular(10) : Radius.zero,
              right: bordaDireita ? const Radius.circular(10) : Radius.zero,
            ),
            border: Border.all(
              color: _controller.index == index
                  ? ColorApp.VerdePrincipal
                  : ColorApp.VerdeCinza,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                texto,
                style: estiloTexto(15,
                    cor: _controller.index == index
                        ? ColorApp.VerdePrincipal
                        : ColorApp.VerdeCinza,
                    peso: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                icone,
                color: _controller.index == index
                    ? ColorApp.VerdePrincipal
                    : ColorApp.VerdeCinza,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
