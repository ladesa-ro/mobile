import 'package:sisgha/app/domain/model/turmas.dart';

class TesteTurma {
  static final TesteTurma _instancia = TesteTurma._();
  TesteTurma._(); // Construtor privado

  factory TesteTurma() =>
      _instancia; // Construtor público (sempre retorna a mesma instância)

  List<Turma> turmas = [];

  void PegarTurmas(List<Turma> pegarTurmas) {
    turmas = pegarTurmas;
  }
}
