import 'package:flutter/material.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/widgets/button_edit_perfil.dart';
import 'package:sisgha/app/widgets/progressIndicator.dart';

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
              return Container(
                  height: 200,
                  width: TamanhoTela.horizontal(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: ColorApp.Branco),
                              height: 105,
                              width: 105,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                  "https://luna.sisgha.com/api/usuarios/$id/imagem/perfil",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 65,
                            left: 65,
                            child: BuildButtonEditPerfil(
                                ColorApp.Preto, ColorApp.Branco, context),
                          )
                        ],
                      )
                    ],
                  )

                  //   title: Text(snapshot.data!["nome"]),
                  //   subtitle: Text(snapshot.data!["email"]),
                  //   trailing:
                  //       Text("Matricula: \n${snapshot.data!["matriculaSiape"]}"),

                  );
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
