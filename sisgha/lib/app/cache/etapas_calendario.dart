import 'package:flutter/widgets.dart';
import 'package:sisgha/app/domain/model/etapas.dart';
import 'package:sisgha/app/views/professor/calendario/calendario.dart';

class EtapasCalendario with ChangeNotifier {
  Map<DateTime, List<Etapas>> etapasCalendario = {};

  adicionarEtapasCalendario(List<Etapas> lista) {
    for (var etapa in lista) {
      final inicio = normalizarData(etapa.dataInicio);
      final fim = normalizarData(etapa.dataTermino);

      for (DateTime dia = inicio;
          !dia.isAfter(fim);
          dia = dia.add(const Duration(days: 1))) {
        if (!etapasCalendario.containsKey(dia)) {
          etapasCalendario[dia] = [];
        }

        etapasCalendario[dia]!.add(etapa);
      }
    }
  }
}
