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
      final inicio = etapa.dataInicio;
      final fim = etapa.dataTermino;
      // Evento no dia de início
      if (!tudoJunto.containsKey(inicio)) {
        tudoJunto[inicio] = [];
      }
      tudoJunto[inicio]!.add(
        MostrarNoCalendario(
          titulo: '${etapa.numero}° Etapa - Início',
          dataInicio: formatador.format(inicio),
          dataTermino: formatador.format(fim),
          cor: etapa.cor,
          tempo: inicio.difference(DateTime.now()).inDays.toString(),
          local: 'Local',
        ),
      );

      // Evento no dia de término
      if (!tudoJunto.containsKey(fim)) {
        tudoJunto[fim] = [];
      }
      tudoJunto[fim]!.add(
        MostrarNoCalendario(
          titulo: '${etapa.numero}° Etapa - Fim',
          dataInicio: formatador.format(inicio),
          dataTermino: formatador.format(fim),
          cor: etapa.cor,
          tempo: fim.difference(DateTime.now()).inDays.toString(),
          local: 'Local',
        ),
      );
    }
  }

  // adicionarEventos(
  //      List<Eventos> lista
  //     ) {
  //   final formatador = DateFormat('dd/MM/yyyy');
  //   for (var etapa in lista) {
  //     if (!listaEventos.containsKey(etapa.dataInicio)) {
  //       listaEventos[etapa.dataInicio] = [];
  //     }
  //     listaEventos[etapa.dataInicio]!.add(
  //       Eventos(
  //         titulo: 'Inicio Etapa ${etapa.numero}',
  //         inicio: formatador.format(etapa.dataInicio),
  //         termino: formatador.format(etapa.dataTermino),
  //         tempo: etapa.dataInicio.difference(DateTime.now()).inDays.toString(),
  //         local: 'jipa',
  //         cor: etapa.cor,
  //       ),
  //     );
  //   }

  //   return;
  // }


  
}
