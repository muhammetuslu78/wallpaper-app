import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_app/components/detail_icon.dart';

class WallpaperDetailView extends StatelessWidget {
  final String? detailWallpaper;

  WallpaperDetailView({required this.detailWallpaper});

  String defaultImg = 'https://mfiles.alphacoders.com/222/222888.jpg';

  late String? url = detailWallpaper;

  /*Future<void> setOnHomeScreen(String url) async {
    var filePath = await cacheWallpaper(url);
    await _setwallpaper(filePath.path);
  }

  Future<void> _setwallpaper(String path) async {
    await WallpaperManagerFlutter()
        .setwallpaperfromFile(path, WallpaperManagerFlutter.HOME_SCREEN);
  }

  Future<File> cacheWallpaper(String url) async {
    var file = await DefaultCacheManager().getSingleFile(detailWallpaper!);
    return file;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(detailWallpaper ?? defaultImg,
                  fit: BoxFit.cover)),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DetailIcon(
                    detailWallpaper: detailWallpaper,
                    onPress: () async {
                      await GallerySaver.saveImage(detailWallpaper!,
                          toDcim: true);
                    },
                    icon: Icons.download_rounded),
                DetailIcon(
                    detailWallpaper: detailWallpaper,
                    onPress: () async {
                      int location = WallpaperManager.BOTH_SCREEN;
                      var file = await DefaultCacheManager()
                          .getSingleFile(detailWallpaper!);
                      bool result = await WallpaperManager.setWallpaperFromFile(
                          file.path, location);
                    },
                    icon: Icons.add_to_queue_outlined),
                DetailIcon(
                    detailWallpaper: detailWallpaper,
                    onPress: () async {
                      print(detailWallpaper);
                      final uri = Uri.parse(detailWallpaper!);
                      final res = await http.get(uri);
                      final bytes = res.bodyBytes;

                      final temp = await getTemporaryDirectory();
                      final path = '${temp.path}/image.png';
                      File(path).writeAsBytesSync(bytes);

                      await Share.shareFiles([path]);
                    },
                    icon: Icons.share)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*class DetailIcon extends StatelessWidget {
  const DetailIcon({
    Key? key,
    required this.detailWallpaper,
  }) : super(key: key);

  final String? detailWallpaper;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.download_rounded,
        color: Colors.white,
      ),
      onPressed: () async {
        // final tempDir = await getTe
        await GallerySaver.saveImage(detailWallpaper!,
            toDcim: true);
      },
    );
  }
}


IconButton(
                  icon: Icon(Icons.add_to_queue_outlined),
                  onPressed: () async {
                    int location = WallpaperManager.BOTH_SCREEN;
                    var file = await DefaultCacheManager()
                        .getSingleFile(detailWallpaper!);
                    bool result = await WallpaperManager.setWallpaperFromFile(
                        file.path, location);

                    /*var file = (await DefaultCacheManager()
                        .getSingleFile(detailWallpaper!));

                    await WallpaperManagerFlutter()
                        .setwallpaperfromFile(file, location);*/

                    print('task done');
                  },
                )

 IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    final uri = Uri.parse(detailWallpaper!);
                    final res = await http.get(uri);
                    final bytes = res.bodyBytes;

                    final temp = await getTemporaryDirectory();
                    final path = '${temp.path}/image.png';
                    File(path).writeAsBytesSync(bytes);

                    await Share.shareFiles([path]);
                  },
                ),
*/
