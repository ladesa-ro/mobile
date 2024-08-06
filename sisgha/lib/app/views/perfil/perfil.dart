import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/model/userModel.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/botton_sheat.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/button_style_edit.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/circle_avatar.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/navegacao_switch.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widget_sair.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widgets_perfil.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: buscarUser(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Erro ao carregar Usuário"),
                OutlinedButton(
                  onPressed: () async {
                    if (await sair()) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/primeiraTela",
                        (route) => false,
                      );
                    }
                  },
                  child: const Text("Fazer Login Novamente"),
                )
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            UserModel user = snapshot.data!;
            return Scaffold(
              body: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    width: TamanhoTela.horizontal(context),
                    height: 210,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Positioned(
                          child: SizedBox(
                            height: 175,
                            width: TamanhoTela.horizontal(context),
                            //aqui muda a imagem de fundo
                            child: Image.network(
                              "https://dev.ladesa.com.br/api/usuarios/${user.id}/imagem/capa",
                              fit: BoxFit.cover,
                              alignment: AlignmentDirectional.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 10,
                          child: ElevatedButton(
                            style: buttonStyleEdit(ColorApp.Branco),
                            child: const Iconify(
                              Icones.Lapiz,
                              size: 14,
                              color: ColorApp.Preto,
                            ),
                            onPressed: () => {
                              bottomSheat(context),
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: circleAvatar(context,
                              "https://dev.ladesa.com.br/api/usuarios/${user.id}/imagem/perfil"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: dadosUsuario(context, user.nome, user.email),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: TamanhoTela.horizontal(context) * 0.050),
                    child: Column(
                      children: [
                        formulario(
                            textoFlutuante: 'Nome', informacoes: user.nome),
                        const SizedBox(
                          height: 5,
                        ),
                        formulario(
                            textoFlutuante: 'Email', informacoes: user.email),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            formularioLinha(
                                textoFlutuante: 'Matricula',
                                informacoes: user.matricula,
                                context: context),
                            const Spacer(),
                            formularioLinha(
                                textoFlutuante: 'Função',
                                informacoes: 'Professor',
                                context: context),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 400,
                    child: NavSwitch(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widgetQuit(context),
                    ],
                  ),
                  SizedBox(
                    height: TamanhoTela.horizontal(context) * 0.15,
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              value: 100,
            ),
          );
        });
  }
}
