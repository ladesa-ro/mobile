import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/domain/model/etapas.dart';
import 'package:sisgha/app/domain/model/eventos.dart';

class ListaEventos with ChangeNotifier {
  Map<DateTime, List<Eventos>> listaEventos = {};

  adicionarEventos(List<Etapas> lista) {
    final formatador = DateFormat('dd/MM/yyyy');
    for (var etapa in lista) {
      if (!listaEventos.containsKey(etapa.dataInicio)) {
        listaEventos[etapa.dataInicio] = [];
      }
      listaEventos[etapa.dataInicio]!.add(
        Eventos(
          titulo: 'Inicio Etapa ${etapa.numero}',
          inicio: formatador.format(etapa.dataInicio),
          termino: formatador.format(etapa.dataTermino),
          tempo: etapa.dataInicio.difference(DateTime.now()).inDays.toString(),
          local: 'jipa',
          cor: etapa.cor,
        ),
      );
    }

    return;
  }
}
