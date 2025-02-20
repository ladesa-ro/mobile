import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/Icones.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/dias.dart';
import '../../core/utils/estilos.dart';
import '../../core/utils/responsividade.dart';
import '../../core/utils/tamanhos.dart';
import '../widgets_globais/appbar.dart';
import '../widgets_globais/calendario.dart';
import 'widgets/quadrados_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    var appBar = CustomAppBar(
      height: 7.h,
      titulo: DatasFormatadas.primeiroAUltimoDia,
      subtitulo: DatasFormatadas.obterDiaFormatado(),
      alunoProfessor: true,
    );

    double tamanho =
        TamanhoTela.height(context, appBarSize: appBar.preferredSize.height);
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          SizedBox(height: tamanho * 0.03),
          //botão que ira aparecer na tela com o calendário
          Container(
            padding: Tamanhos.margem(context),
            child: ElevatedButton(
              style: Tamanhos.estiloBotao(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const MiniCalendario(
                      showDialog: true,
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icones.CalendarVazio,
                    size: 3.h,
                    color: ColorsTemaClaro.branco,
                  ),
                  const Spacer(),
                  Text(
                    'Calendário ${now.year}',
                    style: estiloTexto(15,
                        cor: ColorsTemaClaro.brancoTexto,
                        peso: FontWeight.bold),
                  ),
                  const Spacer(),
                  Iconify(
                    Icones.SetaBaixo,
                    size: 4.h,
                    color: ColorsTemaClaro.branco,
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
          ),
          //botoes com os dias da semana
          SizedBox(height: tamanho * 0.03),

          Expanded(
            child: const QuadradosHome(),
          ),
        ],
      ),
    );
  }
}
