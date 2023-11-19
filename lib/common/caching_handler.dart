import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachingHandler {
  final defaultCacheManager = DefaultCacheManager();

  Future<String> cacheImage(String imageUrl) async {
    if ((await defaultCacheManager.getFileFromCache(imageUrl))?.file == null) {
      // Download image data
      Uint8List imageBytes =
          (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
              .buffer
              .asUint8List();

      // Put the image to the cache
      await defaultCacheManager.putFile(
        imageUrl,
        imageBytes,
        fileExtension: "png",
      );
    }

    return imageUrl;
  }
}
