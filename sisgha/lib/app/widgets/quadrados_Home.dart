import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
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
    _quadradoSelecionado = DateTime.now().weekday - 1;
    _tabController = TabController(
        length: 6, vsync: this, initialIndex: _quadradoSelecionado);
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
    int index = 0;
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            //acredito que da para limpar essa parte do codigo com o tabbar teme mas nao tentei nao

            splashFactory: NoSplash.splashFactory,
            labelPadding: const EdgeInsets.all(7),
            unselectedLabelStyle: estiloTexto(15,
                cor: ColorApp.VerdeCinza, peso: FontWeight.w600),
            indicator: const BoxDecoration(),
            dividerHeight: 0,
            labelStyle:
                estiloTexto(15, cor: ColorApp.Branco, peso: FontWeight.bold),
            controller: _tabController,
            tabs: [
              _contruindoInterface(index++),
              _contruindoInterface(index++),
              _contruindoInterface(index++),
              _contruindoInterface(index++),
              _contruindoInterface(index++),
              _contruindoInterface(index),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
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
                ),
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
    DateTime date = now.add(Duration(days: index - now.weekday + 1));
    final diaDaSemanaSoQueEmNumeros = DateFormat('dd').format(date);

    bool qualselecionado = _quadradoSelecionado == index;
    return Container(
      decoration: BoxDecoration(
          color: qualselecionado ? ColorApp.VerdeEscuro : null,
          border: Border.all(
              color: ColorApp.VerdeEscuro,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      width: 50,
      height: TamanhoTela.vertical(context) > 810 ? 75 : 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(diasDaSemana[index]),
          Container(
            color: qualselecionado ? ColorApp.Branco : ColorApp.VerdeCinza,
            width: 30,
            height: 1.5,
          ),
          Text(diaDaSemanaSoQueEmNumeros)
        ],
      ),
    );
  }
}
