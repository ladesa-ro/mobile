import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/app/domain/model/etapas.dart';
import 'package:sisgha/app/domain/model/mostrar_no_calendario.dart';
import 'package:sisgha/app/views/professor/calendario/calendario.dart';

import '../domain/model/eventos.dart';

class CalendarioFuncionalidades with ChangeNotifier {
  Map<DateTime, List<Eventos>> eventosCalendario = {};
  Map<DateTime, List<Etapas>> etapasCalendario = {};
  Map<DateTime, List<MostrarNoCalendario>> tudoJunto = {};

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

  juntarEventosEtapas(List<Etapas> listaEtapas) {
    final formatador = DateFormat('dd/MM/yyyy');

    for (var etapa in listaEtapas) {
      final inicio = normalizarData(etapa.dataInicio);
      final fim = normalizarData(etapa.dataTermino);

      int totalDias = fim.difference(inicio).inDays;

      for (int i = 0; i <= totalDias; i++) {
        final dia = inicio.add(Duration(days: i));

        if (!tudoJunto.containsKey(dia)) {
          tudoJunto[dia] = [];
        }

        String titulo;
        if (i == 0) {
          titulo = '${etapa.numero}° Etapa - Início';
        } else if (i == totalDias) {
          titulo = '${etapa.numero}° Etapa - Fim';
        } else {
          titulo = '${etapa.numero}° Etapa';
        }

        tudoJunto[dia]!.add(
          MostrarNoCalendario(
            titulo: titulo,
            dataInicio: formatador.format(inicio),
            dataTermino: formatador.format(fim),
            cor: etapa.cor,
            tempo: dia.difference(DateTime.now()).inDays.toString(),
            local: 'Local',
          ),
        );
      }
    }
  }
}
