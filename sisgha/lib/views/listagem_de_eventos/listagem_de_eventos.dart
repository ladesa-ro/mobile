import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/utils/estilos.dart';
import 'package:sisgha/domain/model/mostrar_no_calendario.dart';
import 'package:sisgha/viewmodels/calendario_funcionalidades.dart';
import 'package:sizer/sizer.dart';
import 'widgets_listagem_eventos/cabecario_listagem_de_eventos.dart';
import 'widgets_listagem_eventos/campo_de_pesquisa.dart';

class ListagemDeEventos extends StatefulWidget {
  const ListagemDeEventos({super.key});

  @override
  State<ListagemDeEventos> createState() => _ListagemDeEventosState();
}

class _ListagemDeEventosState extends State<ListagemDeEventos> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    return FractionallySizedBox(
      heightFactor: 0.7,
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: tema.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.sp)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cabecarioListagemDeEventos(context, tema),
            SizedBox(height: 2.h),
            campoDePesquisa(context, tema),
            Expanded(
              child: Consumer<CalendarioFuncionalidades>(
                  builder: (context, provCalFun, child) {
                var cont = provCalFun.filtroDePesquisa.length;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: ScrollbarTheme(
                      data: ScrollbarThemeData(
                        crossAxisMargin: 0,
                        mainAxisMargin: 0,
                        thumbVisibility: MaterialStateProperty.all(true),
                        trackVisibility: MaterialStateProperty.all(true),
                        thickness: MaterialStateProperty.all(1.5.w),
                        radius: const Radius.circular(100000),
                        thumbColor: MaterialStateProperty.all(
                            tema.primaryContainer), // 🎨 cor da barra
                        trackColor: MaterialStateProperty.all(
                            tema.secondaryContainer.withAlpha(100)),
                      ),
                      child: Scrollbar(
                        controller: scrollController,
                        child: ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.only(right: 5.w),
                          itemCount: cont,
                          itemBuilder: (context, index) {
                            return builderCard(
                                provCalFun.filtroDePesquisa[index], tema);
                          },
                        ),
                      )),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

Widget builderCard(MostrarNoCalendario item, ColorScheme tema) {
  return Container(
    margin: EdgeInsets.only(bottom: 2.h),
    padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
    decoration: BoxDecoration(
        border: Border.all(color: tema.onSecondary),
        borderRadius: BorderRadius.circular(15.sp)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            containerBolinha(item.cor),
            SizedBox(width: 2.w),
            buildTitle(item.titulo, tema)
          ],
        ),
        SizedBox(height: 1.h),
        Text(item.dataInicio),
        Text(item.dataTermino ?? "Sem previsão de encerramento"),
        SizedBox(height: 1.h),
        Text(item.tempo ?? "Sem previsão")
      ],
    ),
  );
}

Widget buildTitle(String titulo, ColorScheme tema) {
  titulo = titulo.replaceAll(r' - Fim', '').replaceAll(r' - Início', '');
  return Text(
    titulo,
    style: estiloTexto(16, peso: FontWeight.bold, cor: tema.primary),
  );
}

Widget containerBolinha(Color cor) {
  return Container(
    decoration:
        BoxDecoration(color: cor, borderRadius: BorderRadius.circular(15)),
    height: 15.sp,
    width: 15.sp,
  );
}
