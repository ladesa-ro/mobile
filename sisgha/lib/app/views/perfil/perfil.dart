import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/data/providers/dados_professor.dart';
import 'package:sisgha/app/views/perfil/widgets/botton_sheat.dart';
import 'package:sisgha/app/views/perfil/widgets/estilos_perfil.dart';
import 'package:sisgha/app/views/perfil/widgets/componente_navegacao.dart';
import 'package:sisgha/app/views/perfil/widgets/widget_sair.dart';
import 'package:sisgha/app/views/perfil/widgets/dados_professor.dart';

import '../../core/utils/responsividade.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DadosProfessor>(context);
    double tamanho = TamanhoTela.height(context);

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
                Positioned(
                  child: SizedBox(
                    height: tamanho * 0.2,
                    width: TamanhoTela.horizontal(context),
                    child: Image.file(provider.fotoCapaPerfil,
                        fit: BoxFit.cover,
                        alignment: AlignmentDirectional.bottomCenter),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: ElevatedButton(
                    style: buttonStyleEdit(ColorsTemaClaro.vermelhoFraco),
                    onPressed: () async {
                      widgetQuit(context);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icones.Sair,
                          color: ColorsTemaClaro.branco,
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
                    style:
                        buttonStyleEdit(const Color.fromRGBO(60, 60, 60, 0.1)),
                    child: const Iconify(
                      Icones.Lapiz,
                      size: 10,
                      color: ColorsTemaClaro.branco,
                    ),
                    onPressed: () => bottomSheat(
                        context,
                        (File imagem) => provider.atualizarImagemCapaProvider(
                            context, imagem)),
                  ),
                ),
                // Avatar
                Positioned(
                  bottom: 0,
                  child: circleAvatar(
                    context,
                    provider.fotoImagemPerfil,
                    (File imagem) =>
                        provider.atualizarImagemPerfilProvider(context, imagem),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: tamanho * 0.02),
          dadosUsuario(
              context,
              provider.professor.nome,
              provider.professor.email,
              provider.professor.matricula,
              tamanho * 0.005),
          SizedBox(height: tamanho * 0.03),
          SizedBox(
            height: tamanho * 0.7,
            child: NavSwitch(),
          ),
        ],
      ),
    );
  }
}

Widget circleAvatar(BuildContext context, dynamic imagem,
    Function(File) atualizarImagemPerfil) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: ColorsTemaClaro.branco,
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
                backgroundColor: ColorsTemaClaro.cinza,
                backgroundImage: FileImage(imagem)),
          ),
        ),
        Positioned(
          left: 63,
          top: 63,
          child: SizedBox(
            child: ElevatedButton(
              style: buttonStyleEdit(ColorsTemaClaro.preto),
              onPressed: () => bottomSheat(context, atualizarImagemPerfil),
              child: const Iconify(
                Icones.Lapiz,
                size: 10,
                color: ColorsTemaClaro.branco,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
