import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widget_sair.dart';

class WidgetDisponibilidade extends StatefulWidget {
  const WidgetDisponibilidade({super.key});

  @override
  State<WidgetDisponibilidade> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WidgetDisponibilidade> {
  List<String> dias = [
    'Segunda-Feira',
    'Terça-Feira',
    'Quarta-Feira',
    'Quinta-Feira',
    'Sexta-Feira'
  ];

  int diaIndex = 0;

  void _proximoDia() {
    setState(() {
      if (diaIndex < dias.length - 1) {
        diaIndex++;
      }
    });
  }

  void _diaAnterior() {
    setState(() {
      if (diaIndex > 0) {
        diaIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 25),
          Container(
            decoration: BoxDecoration(
              color: ColorApp.VerdePrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            width: constraints.maxWidth,
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _diaAnterior,
                  icon: const Icon(
                    Icons.arrow_left,
                    size: 40,
                    color: ColorApp.Branco,
                  ),
                ),
                const Spacer(),
                Text(
                  dias[diaIndex],
                  style: estiloTexto(15,
                      cor: ColorApp.Branco, peso: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: _proximoDia,
                  icon: const Icon(
                    Icons.arrow_right,
                    size: 40,
                    color: ColorApp.Branco,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          _buildHorario(constraints.maxWidth, '$diaIndex', [
            '07:30 - 08:20',
            '08:20 - 09:10',
            '09:10 - 10:00',
            '10:20 - 11:10',
            '11:10 - 12:00',
          ]),
          _buildHorario(constraints.maxWidth, 'Vespertino', [
            '13:00 - 13:50',
            '13:50 - 14:40',
            '14:40 - 15:30',
            '15:50 - 16:40',
            '16:40 - 17:30',
          ]),
          _buildHorario(constraints.maxWidth, 'Noturno', [
            '19:00 - 19:50',
            '19:50 - 20:40',
            '20:40 - 21:30',
            '21:50 - 22:40',
            '22:40 - 23:30',
          ]),
        ],
      ),
    );
  }

  Widget _buildHorario(double width, String periodo, List<String> horarios) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      height: 200,
      width: width,
      decoration: decoration(),
      child: Row(
        children: [
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: horarios
                .map((horario) => Text(horario, style: estilo()))
                .toList(),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                periodo,
                style: estiloTexto(18,
                    cor: ColorApp.VerdePrincipal, peso: FontWeight.bold),
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: ColorApp.CorFundoDisponibilidade,
    );
  }

  TextStyle estilo() {
    return estiloTexto(17, cor: ColorApp.VerdePrincipal, peso: FontWeight.bold);
  }
}
