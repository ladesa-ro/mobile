import 'package:flutter/material.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhotela.dart';
import 'package:sisgha/app/model/userModel.dart';

class FutureBuilderPerfil extends StatefulWidget {
  const FutureBuilderPerfil({super.key});

  @override
  State<FutureBuilderPerfil> createState() => _FutureBuilderPerfilState();
}

class _FutureBuilderPerfilState extends State<FutureBuilderPerfil> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: buscarUser(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Erro ao carregar Usuário"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          UserModel user = snapshot.data!;
          return SizedBox(
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
                          color: ColorApp.Branco,
                        ),
                        height: 105,
                        width: 105,
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                            "https://luna.sisgha.com/api/usuarios/imagem/perfil",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            value: 100,
          ),
        );
      },
    );
  }
}
