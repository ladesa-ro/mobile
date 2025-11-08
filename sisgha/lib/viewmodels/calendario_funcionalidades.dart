import 'package:sisgha/core/utils/padroes.dart';
import 'package:uuid/uuid.dart';
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
  DateTime? mesAtual;
  List<MostrarNoCalendario> eventosVisiveis = []; // vai mostrar no card
  DateTime? diaSelecionado;
  List<MostrarNoCalendario> listaDeTudo = [];

  List<MostrarNoCalendario> filtroDePesquisa = [];

// 🔹 Pega todos os eventos do mês
  void atualizarEventosDoMes(DateTime mes) {
    mesAtual = mes;

    eventosVisiveis = [
      for (var entry in tudoJunto.entries)
        if (entry.key.month == mes.month && entry.key.year == mes.year)
          ...entry.value
    ];

    eventosVisiveis.sort((a, b) => a.dataReal.compareTo(b.dataReal));

    diaSelecionado = null;
    notifyListeners();
  }

// 🔹 Pega só os eventos do dia
  void filtrarEventosDoDia(DateTime dia) {
    diaSelecionado = dia;
    final chave = normalizarData(dia);
    eventosVisiveis = tudoJunto[chave] ?? [];
    notifyListeners();
  }

  final uuid = Uuid();
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

  juntarEventosEtapas(List<Etapas> listaEtapas, List<Eventos> listaEventos) {
    final formatadorDia = DateFormat('dd/MM');
    final formatadorHoras = DateFormat('HH:ss');

    void adicionarAoCalendario({
      required String idConjunto,
      required DateTime inicio,
      required DateTime fim,
      required Color cor,
      required String Function(int i, int totalDias) tituloBuilder,
    }) {
      final totalDias = fim.difference(inicio).inDays;
      for (int i = 0; i <= totalDias; i++) {
        print(
            'Salvando evento em: ${normalizarData(inicio.add(Duration(days: i)))}');

        final dia =
            normalizarData(inicio.add(Duration(days: i))); // <-- 👈 aqui
        tudoJunto.putIfAbsent(dia, () => []).add(
              MostrarNoCalendario(
                id: idConjunto,
                titulo: tituloBuilder(i, totalDias),
                dataReal: inicio.add(Duration(days: i)), // <-- aqui
                dataInicio:
                    'Início: ${formatadorDia.format(inicio)} às ${formatadorHoras.format(inicio)}',
                dataTermino:
                    'Término: ${formatadorDia.format(fim)} às ${formatadorHoras.format(fim)}',
                cor: cor,
                tempo: verificarTempo(inicio, fim),
              ),
            );
      }
    }

    // eventos
    for (var evento in listaEventos) {
      final inicio = normalizarData(evento.dataInicio);
      final fim = normalizarData(evento.dataTermino);
      final idConjunto = uuid.v4();

      adicionarAoCalendario(
        idConjunto: idConjunto,
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
      final idConjunto = uuid.v4();

      adicionarAoCalendario(
        idConjunto: idConjunto,
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
    listaDeTudo = formatarLista();
    filtroDePesquisa = listaDeTudo;
  }

  List<MostrarNoCalendario> formatarLista() {
    var lista = tudoJunto.values.expand((lista) => lista).toList();
    final mapaUnico = <String, MostrarNoCalendario>{};

    for (var item in lista) {
      mapaUnico[item.id] = item;
    }

    return mapaUnico.values.toList();
  }

//função filtrar
  void aplicarFiltro(String? value) {
    if (value == null || value.isEmpty) {
      filtroDePesquisa = listaDeTudo;
    } else {
      filtroDePesquisa = filtroDePesquisa.where((item) {
        String titulo = Padroes.removerPalavras(item.titulo);

        return titulo.toUpperCase().contains(value.toUpperCase());
      }).toList();
    }

    notifyListeners();
  }
}

// verifica se vai começar, já começou ou se ja terminou
String verificarTempo(DateTime inicio, DateTime fim) {
  final hoje = DateTime.now();
  final diasAteInicio = inicio.difference(hoje).inDays;

  // Ainda não começou
  if (hoje.isBefore(inicio)) {
    return 'Começa em $diasAteInicio dia${diasAteInicio == 1 ? '' : 's'}';
  }

  // Está acontecendo (hoje está entre inicio e fim, inclusive)
  if ((hoje.isAtSameMomentAs(inicio) || hoje.isAfter(inicio)) &&
      hoje.isBefore(fim.add(const Duration(days: 1)))) {
    return 'Em Andamento';
  }

  // Já terminou
  if (hoje.isAfter(fim)) {
    return 'Encerrado';
  }

  return 'ERROR';
}
