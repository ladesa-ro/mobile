import 'package:sisgha/app/domain/model/etapas.dart';

import '../api/repository.dart';
import '../model/eventos.dart';

class Listas {
  List<Etapas> listaEtapas = [];
  List<Eventos> listaEventos = [];

  adicionarEtapas() async {
    listaEtapas = await Repository.buscarEtapas();
  }

  adicionarEventos() async {
    listaEventos = await Repository.buscarEventos();
  }
}

// adicionarEventos(); exemplo de chamada
