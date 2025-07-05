import 'package:flutter/widgets.dart';
import 'package:sisgha/app/domain/api/repository.dart';
import 'package:sisgha/app/domain/model/etapas.dart';

class EtapasCalendario with ChangeNotifier {
  List<Etapas> listEtapas = [];

  adicionarEtapas() async {
    listEtapas = await Repository.buscarEtapas();
    notifyListeners();
  }
}
