// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sisgha/core/utils/padroes.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/estilos.dart';
import 'estilos_perfil.dart';

Future bottomSheat(BuildContext context, Function(File) onImageSelected) {
  final ImagePicker imagePicker = ImagePicker();
  final tema = Theme.of(context).colorScheme;

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
    backgroundColor: tema.surface,
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: Padroes.margem().right),
        padding: Padroes.margem(),
        width: 100.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 3 + 0.5.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: tema.primaryContainer,
                  ),
                ),
                SizedBox(width: Padroes.margem().left),
                Align(
                  child: Text(
                    'Editar foto',
                    style: estiloTexto(17,
                        cor: tema.primary, peso: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              'Escolha um arquivo .jpeg ou .png de 500x1000, ou tire uma foto',
              style: estiloTexto(16, cor: tema.tertiary, peso: FontWeight.bold),
            ),
            SizedBox(height: 2.h),
            ElevatedButton(
              style: botaoButtonSheat(),
              onPressed: () => _capturarFoto(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: tema.secondaryFixed,
                    size: 22.sp,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Capturar foto',
                    style: estiloTexto(
                      16,
                      cor: tema.secondary,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: botaoButtonSheat(),
              onPressed: () => _selecionarFoto(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.photo,
                    color: tema.secondaryFixed,
                    size: 22.sp,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Selecionar foto',
                    style: estiloTexto(
                      16,
                      cor: tema.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
