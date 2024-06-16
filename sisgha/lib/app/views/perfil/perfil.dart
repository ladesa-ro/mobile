import 'package:flutter/material.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/views/inicio/boasvindas.dart';
import 'package:sisgha/app/widgets/builder_perfil.dart';
import 'package:sisgha/app/widgets/button_edit_perfil.dart';
import 'package:sisgha/app/widgets/teste.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(TamanhoTela.horizontal(context), 175),
          child: Stack(
            children: [
              Positioned(
                height: 150,
                width: TamanhoTela.horizontal(context),
                child: Image.asset(
                  'img/gtr.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //widget do botao que edita o fundo e a imagem
                  BuildButtonEditPerfil(ColorApp.Branco, ColorApp.Preto),
                ],
              ),
              //constroi a imagem do perfil
              const FutureBuilderPerfil(),
            ],
          ),
        ),
        body: ListView(
          children: [
            /*é possivel fazer só uma requisição pra puchar de tudo o que nois prescizamos de uma vez?
            exemplo, abaixo tem a classe teste, ela fais a mesma requisição da classe FutureBuilderPerfil, a 
            diferença é que no teste ta sendo contruido a interface com o nome e o email e o FutureBuilderPerfil 
            a interface da imgem redondinha, entao eu pensei assim, existe um jeito de antes de construir a tela Perfil
            ele fazer essas requisições todas de uma vez, armazenar os resultados e depois quando prescisar so puxar 
            os resultados armazenados? mas eu nao sei direito como funciona. qualquer coisa so me falar              
            */
            const Teste(),
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
