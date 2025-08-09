class Professor {
  String matricula;
  String nome;
  String email;
  String id;

  Professor({
    required this.matricula,
    required this.nome,
    required this.email,
    required this.id,
  });
  factory Professor.empty() =>
      Professor(matricula: '', nome: '', email: '', id: '');
  factory Professor.fromJson(Map<String, dynamic> json) => Professor(
      matricula: json['matriculaSiape'] ?? 'Desconhecido',
      nome: json['nome'] ?? 'Desconhecido',
      email: json['email'] ?? 'desconhecido@example.com',
      id: json['id'] ?? '00000');
}
