import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    return FractionallySizedBox(
      heightFactor: 0.7,
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: tema.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cabecarioListagemDeEventos(context, tema),
            SizedBox(height: 2.h),
            campoDePesquisa(context, tema),
            Expanded(
              child: Scrollbar(child: Consumer<CalendarioFuncionalidades>(
                  builder: (context, provCalFun, child) {
                var cont = provCalFun.listaDeTudo.length;
                return ListView.builder(
                  itemCount: cont,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text(provCalFun.filtroDePesquisa[index].titulo),
                    );
                  },
                );
              })),
            )
          ],
        ),
      ),
    );
  }
}
