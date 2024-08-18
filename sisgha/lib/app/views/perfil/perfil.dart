import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhotela.dart';
import 'package:sisgha/app/model/userModel.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/botton_sheat.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/button_style_edit.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/circle_avatar.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/navegacao_switch.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widgets_perfil.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> alturaNavSwitch = ValueNotifier<double>(900);
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
                      // ignore: use_build_context_synchronously
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
                        top: 10,
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
                //até aqui ta perfeito

                ValueListenableBuilder<double>(
                  valueListenable: alturaNavSwitch,
                  builder: (context, altura, child) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: altura,
                      width: TamanhoTela.horizontal(context),
                      child: NavSwitch(alturaNotifier: alturaNavSwitch),
                    );
                  },
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
