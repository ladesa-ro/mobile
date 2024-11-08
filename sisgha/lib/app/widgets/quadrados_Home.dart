import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/widgets/horarios.dart';

class QuadradosHome extends StatefulWidget {
  const QuadradosHome({super.key});

  @override
  State<QuadradosHome> createState() => _QuadradosHomeState();
}

class _QuadradosHomeState extends State<QuadradosHome>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late int _quadradoSelecionado;

  @override
  void initState() {
    super.initState();

    _quadradoSelecionado =
        DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday - 1;

    _tabController = TabController(
        animationDuration: const Duration(milliseconds: 500),
        length: 6,
        vsync: this,
        initialIndex: _quadradoSelecionado == -1 ? 0 : _quadradoSelecionado);
    _tabController.addListener(() {
      setState(() {
        _quadradoSelecionado = _tabController.index;
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
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: TabBar(
              indicatorWeight: 0,
              splashFactory: NoSplash.splashFactory,
              labelPadding:
                  EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.01),
              indicator: const BoxDecoration(),
              dividerHeight: 0,
              controller: _tabController,
              tabs: List.generate(
                6,
                (index) => _contruindoInterface(index),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Horarios(
                  materia: 'Matemática',
                  turma: '3A',
                  horario: '08:00 - 09:30',
                ),
                Horarios(
                  materia: 'História',
                  turma: '2B',
                  horario: '10:00 - 11:30',
                ),
                Horarios(
                  materia: 'Geografia',
                  turma: '1C',
                  horario: '13:00 - 14:30',
                ),
                Horarios(
                  materia: 'Lógica de Programação',
                  turma: '3C',
                  horario: '13:00 - 14:30',
                ),
                Horarios(
                  materia: 'Geografia',
                  turma: '1C',
                  horario: '13:00 - 14:30',
                ),
                Horarios(
                  materia: 'Geografia',
                  turma: '1C',
                  horario: '13:00 - 14:30',
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _contruindoInterface(int index) {
    List<String> diasDaSemana = [
      'Seg',
      'Ter',
      'Qua',
      'Qui',
      'Sex',
      'Sab',
    ];

    DateTime now = DateTime.now();
    DateTime date = now.add(Duration(days: (now.weekday - 7) + index));
    final diaDaSemanaSoQueEmNumeros = DateFormat('dd').format(date);

    bool selecionado = _quadradoSelecionado == index;

    retorno({required dynamic atributo1, required dynamic atributo2}) {
      return selecionado ? atributo1 : atributo2;
    }

    BoxDecoration boxDecoration(bool selecionado) {
      return BoxDecoration(
        color: retorno(
            atributo1: ColorApp.VerdePrincipal, atributo2: Colors.transparent),
        border: Border.all(
            color: ColorApp.VerdePrincipal,
            width: 1.0,
            style: BorderStyle.solid),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: retorno(atributo1: 5.0, atributo2: 0.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: boxDecoration(selecionado),
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    diasDaSemana[index],
                    style: estiloTexto(15,
                        cor: retorno(
                            atributo1: ColorApp.Branco,
                            atributo2: ColorApp.VerdePrincipal),
                        peso: FontWeight.w600),
                  ),
                  Container(
                    color: retorno(
                        atributo1: ColorApp.Branco,
                        atributo2: ColorApp.VerdePrincipal),
                    width: constraints.maxWidth * 0.45,
                    height: 1.5,
                  ),
                  Text(
                    diaDaSemanaSoQueEmNumeros,
                    style: estiloTexto(15,
                        cor: retorno(
                            atributo1: ColorApp.Branco,
                            atributo2: ColorApp.VerdePrincipal),
                        peso: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
