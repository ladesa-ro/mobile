class Turma {
  final String id;
  final String periodo;

  Turma({required this.id, required this.periodo});

  factory Turma.fromJson(Map<String, dynamic> json) {
    return Turma(
      id: json['id'],
      periodo: json['periodo'],
    );
  }
}
