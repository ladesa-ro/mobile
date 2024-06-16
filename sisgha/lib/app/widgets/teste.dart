import 'package:flutter/material.dart';
import 'package:sisgha/app/api/repository.dart';

import 'package:sisgha/app/widgets/progressIndicator.dart';

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _Teste();
}

class _Teste extends State<Teste> {
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
                  child: Progressindicator(
                    tamanho: 100,
                  ),
                );
              }
              if (idSnapshot.hasError || idSnapshot.data == null) {
                return const Center(
                  child: Text("Erro ao obter ID do usuário"),
                );
              }
              var id = idSnapshot.data!;
              //se funcionar, mostra isso:
              // ignore: sized_box_for_whitespace
              return Center(
                child: Column(
                  children: [
                    Text(
                      'Professor(a) ${snapshot.data!["nome"]}',
                    ),
                    Text(snapshot.data!["email"])
                  ],
                ),
              );

              //   title: Text(snapshot.data!["nome"]),
              //   subtitle: Text(snapshot.data!["email"]),
              //   trailing:
              //       Text("Matricula: \n${snapshot.data!["matriculaSiape"]}"),
            },
          );
        }
        return const Center(
          child: Progressindicator(
            tamanho: 100,
          ),
        );
      },
    );
  }
}
