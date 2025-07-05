import 'package:flutter/widgets.dart';
import 'package:sisgha/app/cache/etapas_calendario.dart';
import 'package:sisgha/app/domain/model/eventos.dart';

class ListaEventos with ChangeNotifier {
  final Map<DateTime, List<Eventos>> teste = {};

  adicionarEventos() {
    final etapasCalendario = EtapasCalendario();

    for (var etapa in etapasCalendario.listEtapas) {
      if (teste.containsKey(etapa.dataInicio)) {
        teste[etapa.dataInicio] = [];
      }
      teste[etapa.dataInicio]!.add(Eventos(
          titulo: 'Inicio Etapa ${etapa.numero}',
          inicio: etapa.dataInicio.toString(),
          termino: etapa.dataTermino.toString(),
          tempo: etapa.dataInicio.difference(DateTime.now()).toString(),
          local: 'jipa'));
    }
  }
}
