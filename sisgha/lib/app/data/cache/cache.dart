// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sisgha/app/views/components/widget_erro.dart';

class Cache {
  static final CacheManager _cacheManager = CacheManager(Config(
    'cache',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 10,
  ));

  static Future<dynamic> baixarImagem(BuildContext ctx, urlImagem) async {
    try {
      final arquivo = await _cacheManager.downloadFile(urlImagem);
      return arquivo.file;
    } catch (e) {
      showDialog(
          context: ctx,
          builder: (context) => dialogoDeErro(context, "Erro ao Limpar cache"));
    }
  }

  static Future<void> limparCache(BuildContext ctx) async {
    await _cacheManager.emptyCache();
    final directory = await getTemporaryDirectory();
    final cacheDir = Directory('${directory.path}/cache');
    if (await cacheDir.exists()) {
      cacheDir.deleteSync(recursive: true);
    } else {
      showDialog(
          context: ctx,
          builder: (context) => dialogoDeErro(context, "Erro ao Limpar cache"));
    }
  }

  static Future<void> substituirArquivoNoCache(
      BuildContext ctx, String url, File novoArquivo) async {
    final bytes = await novoArquivo.readAsBytes();

    await _cacheManager.putFile(
      url,
      bytes,
      fileExtension: novoArquivo.path.split('.').last,
    );

    showDialog(
        context: ctx,
        builder: (context) => dialogoDeErro(context, "Erro ao substitu cache"));
  }
}
