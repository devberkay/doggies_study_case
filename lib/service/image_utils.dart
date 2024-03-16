import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageUtils {
  static Future<void> cacheImageFromNetwork(String imgUrl) async {
    var response = await http.get(Uri.parse(imgUrl));
    if (response.statusCode == 200) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String fileName = path.basename(imgUrl);
      File file = File('$tempPath/$fileName');
      await file.writeAsBytes(response.bodyBytes);
      await file.exists().then((isThere) {
        isThere
            ? debugPrint('Image saved to $tempPath/$fileName')
            : debugPrint('Failed to save image');
      });
    } else {
      debugPrint(
          'Failed to download image: Server responded with status code ${response.statusCode}');
      throw HttpException(response.statusCode.toString());
    }
  }
}
