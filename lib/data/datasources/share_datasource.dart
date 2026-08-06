import 'dart:ui';

abstract class ShareDatasource {
  Future<void> shareFiles(List<String> paths, {Rect? sharePositionOrigin});
}
