import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:io';

class Cache {
  static final CacheManager _cacheManager = CacheManager(Config(
    'cache',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 50,
  ));

  // Método para baixar e armazenar a imagem
  static Future<File> baixarImagem(String urlImagem) async {
    try {
      // Baixa ou retorna o arquivo do cache
      final arquivo = await _cacheManager.downloadFile(urlImagem);
      print(
          '---------------------------------------------------------------------------------');
      print('Imagem salva em cache: ${arquivo.file.path}');
      return arquivo.file;
    } catch (e) {
      print(
          '---------------------------------------------------------------------------------');
      print('Erro ao baixar a imagem: $e');
      throw Exception();
    }
  }

  // Método para limpar o cache (opcional)
  static Future<void> limparCache() async {
    await _cacheManager.emptyCache();
    print(
        '---------------------------------------------------------------------------------');
    print('Cache limpo!');
  }
}
