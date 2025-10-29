import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sisgha/widgets/modal_calendario.dart';
import 'package:sisgha/widgets/widget_botao.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/utils/dias.dart';
import '../../core/utils/estilos.dart';
import '../../core/utils/icones.dart';
import '../../core/utils/padroes.dart';
import '../../widgets/calendario.dart';
import '../../widgets/widgets_home/quadrados_home.dart';

class HomeAlunos extends StatefulWidget {
  const HomeAlunos({super.key});

  @override
  State<HomeAlunos> createState() => _HomeAlunosState();
}

class _HomeAlunosState extends State<HomeAlunos> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    double tamanho = Padroes.calcularAlturaAppBar(context, appBarSize: 7.h);
    DateTime now = DateTime.now();

    final tema = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: Padroes.margem(),
        child: Column(
          children: [
            SizedBox(height: tamanho * 0.03),
            SizedBox(
              height: 6.5.h,
              child: componenteBotao(
                tema: tema,
                onFuncion: () {
                  showDialog(
                      context: context,
                      builder: (context) => ModalCalendario());
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Icon(
                      Icones.calendario,
                      size: 3.h,
                      color: tema.primaryFixed,
                    ),
                    const Spacer(),
                    Text(
                      'Calendário ${now.year}',
                      style: estiloTexto(15,
                          cor: tema.inversePrimary, peso: FontWeight.bold),
                    ),
                    const Spacer(),
                    Iconify(
                      Icones.setaBaixo,
                      size: 4.h,
                      color: tema.primaryFixed,
                    ),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: tamanho * 0.03),
            Expanded(child: const QuadradosHome()),
          ],
        ),
      ),
    );
  }
}
