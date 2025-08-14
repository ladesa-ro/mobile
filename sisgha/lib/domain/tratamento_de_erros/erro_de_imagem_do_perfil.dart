import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sisgha/core/utils/imagens.dart';

Future<File> imagemDeErro() async {
  final byteData = await rootBundle.load(ImageApp.imgTeste);

  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/imager_Erro.jpeg');

  await file.writeAsBytes(
    byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
  );

  return file;
}
