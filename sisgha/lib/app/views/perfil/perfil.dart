import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhotela.dart';
import 'package:sisgha/app/model/userModel.dart';
import 'package:sisgha/app/views/home/navegacao.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/botton_sheat.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/button_style_edit.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/navegacao_switch.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widget_sair.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widgets_perfil.dart';
import 'package:sisgha/app/widgets/widget_erro.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

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
      _recarregarDadosUsuario();
    } else {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return dialogoDeErro(context);
        },
      );
    }
  }

  Future<void> _atualizarImagemCapa(File imagem) async {
    bool sucesso = await atualizarImagemCapa(imagem, context);
    if (sucesso) {
      setState(() {
        imagemCapa = imagem;
      });
      _recarregarDadosUsuario();
    } else {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return dialogoDeErro(context);
        },
      );
    }
  }

  Future<void> _recarregarDadosUsuario() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double tamanho = TamanhoTela.height(context);
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
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  width: TamanhoTela.horizontal(context),
                  height: tamanho * 0.25,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      // Capa
                      Positioned(
                        child: SizedBox(
                          height: tamanho * 0.2,
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
                        left: 10,
                        child: ElevatedButton(
                          style: buttonStyleEdit(ColorApp.CorSair),
                          onPressed: () async {
                            widgetQuit(context);
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icones.Sair,
                                color: ColorApp.Branco,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: ElevatedButton(
                          style: buttonStyleEdit(
                              const Color.fromRGBO(60, 60, 60, 0.1)),
                          child: const Iconify(
                            Icones.Lapiz,
                            size: 10,
                            color: ColorApp.Branco,
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
                dadosUsuario(context, user.nome, user.email, user.matricula),
                SizedBox(
                  height: tamanho * 0.01,
                ),
                SizedBox(
                  height: tamanho * 0.74,
                  child: NavSwitch(),
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
            width: 100,
            height: 100,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 126, 126, 126),
              backgroundImage: link.startsWith('http')
                  ? NetworkImage(link) as ImageProvider
                  : FileImage(File(link)),
            ),
          ),
        ),
        Positioned(
          left: 63,
          top: 63,
          child: SizedBox(
            child: ElevatedButton(
              style: buttonStyleEdit(ColorApp.Preto),
              onPressed: () => bottomSheat(context, atualizarImagemPerfil),
              child: const Iconify(
                Icones.Lapiz,
                size: 10,
                color: ColorApp.Branco,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
