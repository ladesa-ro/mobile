import 'cursos.dart';
import 'disciplinas.dart';
import 'turmas.dart';

class DadosEnsino {
  final Disciplina disciplina;
  final List<CursoComTurmas> cursos;

  DadosEnsino({
    required this.disciplina,
    required this.cursos,
  });
}

class CursoComTurmas {
  final Cursos curso;
  final List<Turma> turmas;

  CursoComTurmas({
    required this.curso,
    required this.turmas,
  });
}
