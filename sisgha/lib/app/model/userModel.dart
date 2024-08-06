// ignore_for_file: file_names
class UserModel {
  final String matricula;
  final String nome;
  final String email;
  final String id;

  UserModel({
    required this.matricula,
    required this.nome,
    required this.email,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      matricula: json['matriculaSiape'] ?? 'Desconhecido',
      nome: json['nome'] ?? 'Desconhecido',
      email: json['email'] ?? 'desconhecido@example.com',
      id: json['id'] ?? '00000');
}
