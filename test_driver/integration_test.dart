import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (name, bytes, [args]) async {
      // Save outside build/ so flutter clean doesn't wipe captures.
      final outDir = Directory('dist/store-screenshots');
      if (!outDir.existsSync()) {
        outDir.createSync(recursive: true);
      }
      final file = File('${outDir.path}/$name.png');
      await file.writeAsBytes(bytes);
      return true;
    },
  );
}
