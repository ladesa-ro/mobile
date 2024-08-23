import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/api/repository.dart'; // Certifique-se de que os métodos para enviar imagens estejam aqui
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhotela.dart';
import 'package:sisgha/app/model/userModel.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/botton_sheat.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/button_style_edit.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/circle_avatar.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/navegacao_switch.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widgets_perfil.dart';
import 'package:sisgha/app/widgets/erro_connect.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  File? imagemCapa;
  File? imagemPerfil;

  Future<void> _atualizarImagemPerfil(File imagem) async {
    bool sucesso = await atualizarImagemPerfil(imagem, context);
    if (sucesso) {
      setState(() {
        imagemPerfil = imagem;
      });
    } else {
      // Exibir erro se falhar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErroConnect();
        },
      );
    }
  }

  Future<void> _atualizarImagemCapa(File imagem) async {
    bool sucesso = await atualizarImagemCapa(imagem, context);
    print("${sucesso}");
    if (sucesso) {
      setState(() {
        imagemCapa = imagem;
      });
    } else {
      // Exibir erro se falhar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErroConnect();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> alturaNavSwitch = ValueNotifier<double>(900);
    return FutureBuilder<UserModel>(
      future: buscarUser(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Erro ao carregar usuário: ${snapshot.error}");
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
                      // Capa
                      Positioned(
                        child: SizedBox(
                          height: 175,
                          width: TamanhoTela.horizontal(context),
                          child: imagemCapa != null
                              ? Image.file(
                                  imagemCapa!,
                                  fit: BoxFit.cover,
                                  alignment: AlignmentDirectional.bottomCenter,
                                )
                              : Image.network(
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
                          onPressed: () =>
                              bottomSheat(context, _atualizarImagemCapa),
                        ),
                      ),
                      // Avatar
                      Positioned(
                        bottom: 0,
                        child: circleAvatar(
                          context,
                          imagemPerfil != null
                              ? imagemPerfil!.path
                              : "https://dev.ladesa.com.br/api/usuarios/${user.id}/imagem/perfil",
                          _atualizarImagemPerfil,
                        ),
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
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

Widget circleAvatar(
    BuildContext context, String link, Function(File) atualizarImagemPerfil) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(100),
    ),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          child: SizedBox(
            width: 90,
            height: 90,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 126, 126, 126),
              backgroundImage: link.startsWith('http')
                  ? NetworkImage(link) as ImageProvider
                  : FileImage(File(link)),
            ),
          ),
        ),
        Positioned(
          left: 53,
          top: 53,
          child: SizedBox(
            child: ElevatedButton(
              style: buttonStyleEdit(ColorApp.Preto),
              onPressed: () => bottomSheat(context, atualizarImagemPerfil),
              child: const Iconify(
                Icones.Lapiz,
                size: 14,
                color: ColorApp.Branco,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
