import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/widgets/modal_calendario.dart';
import 'package:sisgha/widgets/widget_botao.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/estilos.dart';
import '../../../core/utils/icones.dart';
import '../../../core/utils/padroes.dart';
import '../../../widgets/widgets_home/quadrados_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    double tamanho = Padroes.calcularAlturaAppBar(context, appBarSize: 7.h);
    final tema = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: Padroes.margem(),
        child: Column(
          children: [
            SizedBox(height: tamanho * 0.03), // ja ta certo
            // Inicio do botão de calendário
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
            //fim do botão de calendário
            SizedBox(height: tamanho * 0.03), // ja ta certo
            Expanded(
              child: const QuadradosHome(),
            ),
          ],
        ),
      ),
    );
  }
}
