// ignore_for_file: avoid_print

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Cache {
  static final CacheManager _cacheManager = CacheManager(Config(
    'cache',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 10,
  ));

  static Future<File> baixarImagem(String urlImagem) async {
    try {
      final arquivo = await _cacheManager.downloadFile(urlImagem);
      return arquivo.file;
    } catch (e) {
      throw Exception('erro: $e');
    }
  }

  static Future<void> limparCache() async {
    await _cacheManager.emptyCache();
    final directory = await getTemporaryDirectory();
    final cacheDir = Directory('${directory.path}/cache');
    if (await cacheDir.exists()) {
      cacheDir.deleteSync(recursive: true);
    } else {
      print('Diretório de cache não encontrado.');
    }
  }

  static Future<void> substituirArquivoNoCache(
      String url, File novoArquivo) async {
    final bytes = await novoArquivo.readAsBytes();

    await _cacheManager.putFile(
      url,
      bytes,
      fileExtension: novoArquivo.path.split('.').last,
    );

    print('Arquivo no cache substituído com sucesso.');
  }
}
