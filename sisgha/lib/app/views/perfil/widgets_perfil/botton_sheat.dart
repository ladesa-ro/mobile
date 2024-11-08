import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/bottonstyle_bottonsheat.dart';

Future bottomSheat(BuildContext context, Function(File) onImageSelected) {
  final ImagePicker imagePicker = ImagePicker();

  Future<void> _capturarFoto() async {
    final XFile? imagem =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (imagem != null) {
      onImageSelected(File(imagem.path));
      Navigator.pop(context);
    }
  }

  Future<void> _selecionarFoto() async {
    final XFile? imagem =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (imagem != null) {
      onImageSelected(File(imagem.path));
      Navigator.pop(context);
    }
  }

  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 300,
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 30),
              width: 70,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: ColorApp.VerdeCinza,
              ),
            ),
            Text(
              'Editar foto de perfil',
              style:
                  estiloTexto(16, cor: ColorApp.Preto, peso: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Escolha uma foto, imagem ou',
              style: estiloTexto(16,
                  cor: ColorApp.VerdeCinza, peso: FontWeight.w500),
            ),
            Text(
              'arquivo .jpeg ou .png de 500x500',
              style: estiloTexto(16,
                  cor: ColorApp.VerdeCinza, peso: FontWeight.w500),
            ),
            const Spacer(),
            ElevatedButton(
              style: botaoButtonSheat(),
              onPressed: _capturarFoto,
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 60),
                  Icon(Icons.no_photography),
                  SizedBox(width: 20),
                  Text('Capturar foto'),
                ],
              ),
            ),
            ElevatedButton(
              style: botaoButtonSheat(),
              onPressed: _selecionarFoto,
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 60),
                  Icon(Icons.photo),
                  SizedBox(width: 20),
                  Text('Selecionar foto'),
                ],
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      );
    },
  );
}
