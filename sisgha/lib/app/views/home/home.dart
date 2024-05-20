import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/widgets/horarios.dart';
import 'package:sisgha/app/widgets/mini_calend.dart';
import 'package:sisgha/app/widgets/quadrados_Home.dart';
import 'package:sisgha/app/views/home/barra_top.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    DateTime now = DateTime.now();

    return Scaffold(
      //aqui mexe no tamnho da barra de cima
      appBar: const CustomAppBar(height: 60),

      body: ListView(
        children: [
          SizedBox(
              height: TamanhoTela.vertical(context) > 810
                  ? TamanhoTela.vertical(context) * 0.04
                  : TamanhoTela.vertical(context) * 0.05),
          Container(
            padding: EdgeInsets.only(
                left: TamanhoTela.horizontal(context) * 0.02,
                top: 0,
                right: TamanhoTela.horizontal(context) * 0.02,
                bottom: 0),
            height: 52,
            child: ElevatedButton(
              style: estiloBotao(context, 0, 10, 0, 10),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const MiniCalendario();
                  },
                );
              },
              //botão que ira aparecer na tala com o calendario
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icons.calendar_month,
                    size: TamanhoTela.vertical(context) > 810 ? 28 : 22,
                    color: ColorApp.Branco,
                  ),
                  const Spacer(),
                  Text(
                    'Calendário ${now.year}',
                    style: estiloTexto(
                        TamanhoTela.vertical(context) > 810 ? 17 : 15,
                        cor: Colors.white,
                        peso: FontWeight.bold),
                  ),
                  const Spacer(),
                  Iconify(
                    Icones.SetaBaixo,
                    color: ColorApp.Branco,
                    size: TamanhoTela.vertical(context) > 810 ? 25 : 20,
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: TamanhoTela.vertical(context) * 0.04,
          ),
          //botoes com os dias da semana

          SizedBox(
            height: TamanhoTela.vertical(context),
            child: QuadradosHome(),
          ),
        ],
      ),
    );
  }
}
