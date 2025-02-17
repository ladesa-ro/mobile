import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sisgha/app/views/home/home_alunos/widgests/quandrados_home_alunos.dart';
import 'package:sisgha/app/views/widgets_globais/appbar_alunos.dart';
import 'package:sizer/sizer.dart';
//ainda tenho que mudar pra ficar de acordo com o dos alunos ...
import '../../../core/utils/Icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/dias.dart';
import '../../../core/utils/estilos.dart';
import '../../../core/utils/responsividade.dart';
import '../../../core/utils/tamanhos.dart';
import '../../widgets_globais/calendario.dart';

class HomeAlunos extends StatefulWidget {
  const HomeAlunos({super.key});

  @override
  State<HomeAlunos> createState() => _HomeState();
}

class _HomeState extends State<HomeAlunos> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    var appBar = CustomAppBarAluno(
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
                        cor: ColorsTemaClaro.brancoTexto, peso: FontWeight.bold),
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
            child: const QuandradosHomeAlunos(),
          ),
        ],
      ),
      
    );
  }
}
