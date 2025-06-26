import 'package:flutter/widgets.dart';
import 'package:sisgha/app/domain/model/eventos.dart';

class ListaEventos with ChangeNotifier {
  final Map<DateTime, List<Eventos>> teste = {
    DateTime(2025, 6, 28): [
      Eventos(
          titulo: "Evento 1",
          inicio: "01/04",
          termino: "01/05",
          tempo: "daqui 5 dias",
          local: "OPO"),
    ],
    DateTime(2025, 6, 26): [
      Eventos(
          titulo: "Evento 2",
          inicio: "02/04",
          termino: "02/05",
          tempo: "daqui 38 dias",
          local: "Jipa"),
    ],
    DateTime(2025, 6, 27): [
      Eventos(
          titulo: "Evento 3",
          inicio: "01/06",
          termino: "01/07",
          tempo: "daqui 7 dias",
          local: "Jipa"),
    ],
  };
}
