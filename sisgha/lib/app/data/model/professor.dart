class Professor {
  final String matricula;
  final String nome;
  final String email;
  final String id;

  Professor({
    required this.matricula,
    required this.nome,
    required this.email,
    required this.id,
  });

  factory Professor.fromJson(Map<String, dynamic> json) => Professor(
      matricula: json['matriculaSiape'] ?? 'Desconhecido',
      nome: json['nome'] ?? 'Desconhecido',
      email: json['email'] ?? 'desconhecido@example.com',
      id: json['id'] ?? '00000');
}
