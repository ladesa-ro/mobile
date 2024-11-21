import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/widgets/appBar.dart';
import 'package:sisgha/app/widgets/mini_calend.dart';
import 'package:sisgha/app/widgets/quadrados_Home.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sizer/sizer.dart';

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
    );

    double tamanho =
        TamanhoTela.height(context, appBarSize: appBar.preferredSize.height);
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          SizedBox(
            height: tamanho * 0.03,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            height: tamanho * 0.09,
            //botão que ira aparecer na tala com o calendario
            child: ElevatedButton(
              style: estiloBotao(context, 0, 10, 0, 10),
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
                    color: ColorApp.Branco,
                  ),
                  const Spacer(),
                  Text(
                    'Calendário ${now.year}',
                    style: estiloTexto(15,
                        cor: ColorApp.BrancoTexto, peso: FontWeight.bold),
                  ),
                  const Spacer(),
                  Iconify(
                    Icones.SetaBaixo,
                    size: 4.h,
                    color: ColorApp.Branco,
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: tamanho * 0.03,
          ),
          //botoes com os dias da semana
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: const QuadradosHome(),
            ),
          ),
        ],
      ),
    );
  }
}
