import 'package:sisgha/app/domain/model/disciplinas.dart';

class TesteDisciplinas {
  static final TesteDisciplinas _instancia = TesteDisciplinas._();
  TesteDisciplinas._(); // Construtor privado

  factory TesteDisciplinas() => _instancia; // Construtor público (sempre retorna a mesma instância)

  List<Disciplina> turmas = [];

  void PegarTurmas(List<Disciplina> pegarTurmas) {
    turmas = pegarTurmas;
  }
}