import 'package:flutter/material.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/imagens.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/views/inicio/boasvindas.dart';
import 'package:sisgha/app/widgets/builder_perfil.dart';
import 'package:sisgha/app/widgets/button_edit_perfil.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(TamanhoTela.horizontal(context), 180),
          child: Stack(
            children: [
              Positioned(
                height: 175,
                width: TamanhoTela.horizontal(context),
                child: Image.asset(
                  alignment: Alignment.bottomCenter,
                  ImageApp.imgTeste,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10,
                top: 15,
                //widget do botao que edita o fundo e a imagem
                child: BuildButtonEditPerfil(const Color.fromARGB(47, 0, 0, 0),
                    ColorApp.Branco, context),
              ),
              //constroi a imagem do perfil
              const FutureBuilderPerfil(),
            ],
          ),
        ),
        body: ListView(
          children: [
            IconButton(
              onPressed: () async {
                bool saiu = await sair();
                if (saiu) {
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BoasVindasPage(),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.logout_rounded,
                size: 40,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ));
  }
}
