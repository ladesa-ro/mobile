class Cursos {
  final String id;
  final String nome;

  Cursos({
    required this.id,
    required this.nome,
  });

  factory Cursos.fromJson(Map<String, dynamic> json) => Cursos(
        id: json['id'],
        nome: json['nome'],
      );
}
