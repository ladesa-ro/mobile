import 'package:flutter/widgets.dart';
import 'package:sisgha/app/domain/model/etapas.dart';
import 'package:sisgha/app/views/professor/calendario/calendario.dart';

class EtapasCalendario with ChangeNotifier {
  Map<DateTime, List<Etapas>> etapasCalendario = {};

  adicionarEtapasCalendario(List<Etapas> lista) {
    for (var etapa in lista) {
      final dataNormalizada = normalizarData(etapa.dataInicio);

      if (!etapasCalendario.containsKey(dataNormalizada)) {
        etapasCalendario[dataNormalizada] = [];
      }

      etapasCalendario[dataNormalizada]!.add(
        Etapas(
          numero: etapa.numero,
          dataInicio: dataNormalizada,
          dataTermino: normalizarData(etapa.dataTermino),
          tempo:
              'Começa em: ${dataNormalizada.difference(DateTime.now()).inDays} dias',
          local: 'jipa',
          cor: etapa.cor,
        ),
      );
    }
  }
}
