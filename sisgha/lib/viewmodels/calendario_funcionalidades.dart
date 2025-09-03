import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sisgha/domain/model/etapas.dart';
import 'package:sisgha/domain/model/mostrar_no_calendario.dart';

import '../domain/model/eventos.dart';
import '../views/professor/calendario/calendario.dart';

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

  adicionarEventosCalendario(List<Eventos> lista) {
    for (var evento in lista) {
      final inicio = normalizarData(evento.dataInicio);
      final fim = normalizarData(evento.dataTermino);

      for (DateTime dia = inicio;
          !dia.isAfter(fim);
          dia = dia.add(const Duration(days: 1))) {
        if (!eventosCalendario.containsKey(dia)) {
          eventosCalendario[dia] = [];
        }

        eventosCalendario[dia]!.add(evento);
      }
    }

    notifyListeners();
  }

  juntarEventosEtapas(List<Etapas> listaEtapas, List<Eventos> listaEventos) {
    final formatador = DateFormat('dd/MM/yyyy');

    void adicionarAoCalendario({
      required DateTime inicio,
      required DateTime fim,
      required Color cor,
      required String Function(int i, int totalDias) tituloBuilder,
    }) {
      final totalDias = fim.difference(inicio).inDays;
      for (int i = 0; i <= totalDias; i++) {
        final dia = inicio.add(Duration(days: i));
        tudoJunto.putIfAbsent(dia, () => []).add(
              MostrarNoCalendario(
                titulo: tituloBuilder(i, totalDias),
                dataInicio: formatador.format(inicio),
                dataTermino: formatador.format(fim),
                cor: cor,
                tempo: verificarTempo(inicio, fim),
                local: 'Local',
              ),
            );
      }
    }

    // eventos
    for (var evento in listaEventos) {
      final inicio = normalizarData(evento.dataInicio);
      final fim = normalizarData(evento.dataTermino);

      adicionarAoCalendario(
        inicio: inicio,
        fim: fim,
        cor: evento.cor,
        tituloBuilder: (i, totalDias) {
          if (i == 0) return '${evento.nome} - Início';
          if (i == totalDias) return '${evento.nome} - Fim';
          return evento.nome;
        },
      );
    }

    // etapas
    for (var etapa in listaEtapas) {
      final inicio = normalizarData(etapa.dataInicio);
      final fim = normalizarData(etapa.dataTermino);

      adicionarAoCalendario(
        inicio: inicio,
        fim: fim,
        cor: etapa.cor,
        tituloBuilder: (i, totalDias) {
          if (i == 0) return '${etapa.numero}° Etapa - Início';
          if (i == totalDias) return '${etapa.numero}° Etapa - Fim';
          return '${etapa.numero}° Etapa';
        },
      );
    }
  }
}

String verificarTempo(DateTime inicio, DateTime fim) {
  final hoje = DateTime.now();
  final diasAteInicio = inicio.difference(hoje).inDays;

  // Ainda não começou
  if (hoje.isBefore(inicio)) {
    return 'Faltam $diasAteInicio dia${diasAteInicio == 1 ? '' : 's'}';
  }

  // Está acontecendo (hoje está entre inicio e fim, inclusive)
  if ((hoje.isAtSameMomentAs(inicio) || hoje.isAfter(inicio)) &&
      hoje.isBefore(fim.add(const Duration(days: 1)))) {
    return 'Acontecendo';
  }

  // Já terminou
  if (hoje.isAfter(fim)) {
    return 'Encerrado';
  }

  return 'ERROR';
}
