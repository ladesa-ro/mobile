import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/icones.dart';
import '../../../core/utils/padroes.dart';
import '../../../domain/logic/deslogar.dart';
import '../../../viewmodels/dados_professor.dart';
import 'widgets/botton_sheat.dart';
import 'widgets/componente_navegacao.dart';
import 'widgets/dados_professor.dart';
import 'widgets/estilos_perfil.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DadosProfessor>(context);
    double tamanho = Padroes.calcularAlturaAppBar(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: Padroes.larguraGeral(),
            height: tamanho * 0.25,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                //Imagem de fundo
                Positioned(
                  child: SizedBox(
                    height: tamanho * 0.2,
                    width: Padroes.larguraGeral(),
                    child: Image.file(provider.fotoCapaPerfil,
                        fit: BoxFit.cover,
                        alignment: AlignmentDirectional.bottomCenter),
                  ),
                ),
                //Botão de sair
                Positioned(
                  top: 10,
                  left: 10,
                  child: SizedBox(
                    width: 30,
                    child: ElevatedButton(
                      style: buttonStyleEdit(
                        CoresClaras.vermelhoFraco,
                      ),
                      onPressed: () async {
                        widgetQuit(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          Icones.sair,
                          color: CoresClaras.branco,
                          size: 10,
                        ),
                      ),
                    ),
                  ),
                ),

                //Botão de editar imagem de capa
                Positioned(
                  top: 10,
                  right: 10,
                  child: SizedBox(
                    width: 30,
                    child: ElevatedButton(
                      style: buttonStyleEdit(
                          Theme.of(context).colorScheme.primary),
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
                ),
                //
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
          //Botões de seleção de abas
          Expanded(
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
      color: Theme.of(context).colorScheme.surface,
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
          left: 70,
          top: 64,
          child: SizedBox(
            width: 30,
            height: 42,
            child: ElevatedButton(
              style: buttonStyleEdit(Theme.of(context).colorScheme.primary),
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
