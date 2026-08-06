import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:signica/data/datasources/share_datasource.dart';

@LazySingleton(as: ShareDatasource)
class ShareDatasourceImpl implements ShareDatasource {
  @override
  Future<void> shareFiles(
    List<String> paths, {
    Rect? sharePositionOrigin,
  }) async {
    if (paths.isEmpty) return;

    await SharePlus.instance.share(
      ShareParams(
        files: paths.map((path) => XFile(path)).toList(),
        sharePositionOrigin: sharePositionOrigin,
      ),
    );
  }
}
