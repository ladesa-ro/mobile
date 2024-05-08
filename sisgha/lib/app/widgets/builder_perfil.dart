import 'package:flutter/material.dart';
import 'package:sisgha/app/api/repository.dart';

class FutureBuilderPerfil extends StatefulWidget {
  const FutureBuilderPerfil({super.key});

  @override
  State<FutureBuilderPerfil> createState() => _FutureBuilderPerfilState();
}

class _FutureBuilderPerfilState extends State<FutureBuilderPerfil> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: buscarUser(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Erro ao carregar Usuário"),
          );
        }
        if (snapshot.hasData) {
          return FutureBuilder<String?>(
            future: pegarId(),
            builder: (context, idSnapshot) {
              if (idSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (idSnapshot.hasError || idSnapshot.data == null) {
                return const Center(
                  child: Text("Erro ao obter ID do usuário"),
                );
              }
              var id = idSnapshot.data!;
              return Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      "https://luna.sisgha.com/api/usuarios/$id/imagem/perfil",
                    ),
                  ),
                  title: Text(snapshot.data!["nome"]),
                  subtitle: Text(snapshot.data!["email"]),
                  trailing:
                      Text("Matricula: \n${snapshot.data!["matriculaSiape"]}"),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
