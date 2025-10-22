// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import '../../repository/repository.dart';
import '../../viewmodels/calendario_funcionalidades.dart';
import '../../viewmodels/dados_professor.dart';
import '../../viewmodels/escolha_horarios_alunos.dart';
import 'listas_eventos_e_etapas.dart';
import 'verificar_dados_armazenados.dart';

Future<bool> inicicarProvidersGerais({
  required EscolhaHorariosAlunos horariosAlunos,
  required DadosProfessor dadosProfessor,
  required CalendarioFuncionalidades calendario,
}) async {
  try {
    // espera 7 segundos
    await Future.delayed(const Duration(seconds: 7));

    //=----------------------------TURMAS DOS PROFESSORES-------------------------------=
    await horariosAlunos.pucharOpcoes();
    await Repository.testeBuscarTurmas();
    await Repository.testeBuscarDisciplinas();

    //=-----------------------------CALENDÁRIO------------------------------------------=
    final listas = Listas();
    await listas.adicionarEtapas();
    await listas.adicionarEventos();
    await calendario.adicionarEtapasCalendario(listas.listaEtapas);
    await calendario.juntarEventosEtapas(
        listas.listaEtapas, listas.listaEventos);

    //=-----------------------------DADOS DOS PROFESSORES-------------------------------=
    if (await verificarDadosBaixados()) {
      return true; // tudo certo
    } else {
      return false; // precisa ir para login
    }
  } on TimeoutException {
    throw Exception("Tempo esgotado ao iniciar providers");
  } catch (e) {
    throw Exception("Erro ao iniciar providers: $e");
  }
}
