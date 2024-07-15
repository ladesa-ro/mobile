import 'dart:convert';
import 'dart:typed_data';

class UserModel {
  final String id;
  final String nome;
  final String email;
  final Uint8List? imgCapa;
  final Uint8List? imgPerfil;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.imgCapa,
    required this.imgPerfil,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      imgCapa:
          json['imagemCapa'] != null ? base64Decode(json['imagemCapa']) : null,
      imgPerfil: json['imagemPerfil'] != null
          ? base64Decode(json['imagemPerfil'])
          : null);
}
