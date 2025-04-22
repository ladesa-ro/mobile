import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';
import 'package:sisgha/app/providers/dados_professor.dart';
import 'package:sisgha/app/views/professor/perfil/widgets/botton_sheat.dart';
import 'package:sisgha/app/views/professor/perfil/widgets/estilos_perfil.dart';
import 'package:sisgha/app/views/professor/perfil/widgets/componente_navegacao.dart';
import 'package:sisgha/app/domain/logic/deslogar.dart';
import 'package:sisgha/app/views/professor/perfil/widgets/dados_professor.dart';

import '../../../core/utils/responsividade.dart';

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
                    style: buttonStyleEdit(CoresClaras.vermelhoFraco),
                    onPressed: () async {
                      widgetQuit(context);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icones.sair,
                          color: CoresClaras.branco,
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
                      Icones.lapiz,
                      size: 10,
                      color: CoresClaras.branco,
                    ),
                    onPressed: () => bottomSheat(
                        context,
                        (File imagem) =>
                            provider.atualizarImagemCapa(context, imagem)),
                  ),
                ),
                // Avatar
                Positioned(
                  bottom: 0,
                  child: circleAvatar(
                    context,
                    provider.fotoImagemPerfil,
                    (File imagem) =>
                        provider.atualizarImagemPerfil(context, imagem),
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
          Container(
            padding: Tamanhos.margem(),
            height: tamanho * 0.70,
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
      color: CoresClaras.branco,
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
                backgroundColor: CoresClaras.cinza,
                backgroundImage: FileImage(imagem)),
          ),
        ),
        Positioned(
          left: 63,
          top: 63,
          child: SizedBox(
            child: ElevatedButton(
              style: buttonStyleEdit(CoresClaras.preto),
              onPressed: () => bottomSheat(context, atualizarImagemPerfil),
              child: const Iconify(
                Icones.lapiz,
                size: 10,
                color: CoresClaras.branco,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
