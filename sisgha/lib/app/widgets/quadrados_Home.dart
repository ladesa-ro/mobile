import 'dart:async';

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

    _quadradoSelecionado =
        DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday - 1;

    _tabController = TabController(
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: TabBar(
              splashFactory: NoSplash.splashFactory,
              labelPadding: const EdgeInsets.all(7),
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
    DateTime date = now.add(Duration(days: index - now.weekday + 1));
    final diaDaSemanaSoQueEmNumeros = DateFormat('dd').format(date);

    bool qualselecionado = _quadradoSelecionado == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: qualselecionado
          ? const EdgeInsets.only(bottom: 10)
          : const EdgeInsets.all(0),
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
          Text(
            diasDaSemana[index],
            style: qualselecionado
                ? estiloTexto(15, cor: ColorApp.Branco, peso: FontWeight.bold)
                : estiloTexto(15,
                    cor: ColorApp.VerdeCinza, peso: FontWeight.w600),
          ),
          Container(
            color: qualselecionado ? ColorApp.Branco : ColorApp.VerdeCinza,
            width: 30,
            height: 1.5,
          ),
          Text(
            diaDaSemanaSoQueEmNumeros,
            style: qualselecionado
                ? estiloTexto(15, cor: ColorApp.Branco, peso: FontWeight.bold)
                : estiloTexto(15,
                    cor: ColorApp.VerdeCinza, peso: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
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
    
    // Definição simplificada de _quadradoSelecionado com base no dia da semana atual
    _quadradoSelecionado = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday - 1;

    // Inicialização do TabController
    _tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: _quadradoSelecionado,
    );

    // Listener do TabController para atualização do estado quando a tab selecionada muda
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: TabBar(
              splashFactory: NoSplash.splashFactory,
              labelPadding: const EdgeInsets.all(7),
              indicator: const BoxDecoration(),
              dividerHeight: 0,
              controller: _tabController,
              tabs: List.generate(6, _construirInterface), // Utilização de _construirInterface para gerar as tabs
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir cada tab do TabBar
  Widget _construirInterface(int index) {
    const List<String> diasDaSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'];

    DateTime now = DateTime.now();
    DateTime date = now.add(Duration(days: index - now.weekday + 1));
    String diaNumerico = DateFormat('dd').format(date);

    bool selecionado = _quadradoSelecionado == index;
    Color corTexto = selecionado ? ColorApp.Branco : ColorApp.VerdeCinza;
    FontWeight pesoTexto = selecionado ? FontWeight.bold : FontWeight.w600;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: selecionado ? const EdgeInsets.only(bottom: 10) : EdgeInsets.zero, // Ajuste na margem conforme seleção
      decoration: BoxDecoration(
        color: selecionado ? ColorApp.VerdeEscuro : null, // Cor de fundo conforme seleção
        border: Border.all(
          color: ColorApp.VerdeEscuro,
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      width: 50,
      height: TamanhoTela.vertical(context) > 810 ? 75 : 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            diasDaSemana[index],
            style: estiloTexto(15, cor: corTexto, peso: pesoTexto),
          ),
          Container(
            color: corTexto,
            width: 30,
            height: 1.5,
          ),
          Text(
            diaNumerico,
            style: estiloTexto(15, cor: corTexto, peso: pesoTexto),
          ),
        ],
      ),
    );
  }
}
*/