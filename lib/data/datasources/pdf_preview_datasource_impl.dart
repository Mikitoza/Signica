import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:signica/data/datasources/pdf_preview_datasource.dart';

@LazySingleton(as: PdfPreviewDatasource)
class PdfPreviewDatasourceImpl implements PdfPreviewDatasource {
  static const double _targetWidth = 480;

  @override
  Future<PdfPreviewPaths> renderPreviews(String pdfPath) async {
    final document = await PdfDocument.openFile(pdfPath);
    try {
      final firstPagePath = await _renderPage(
        document,
        pageNumber: 1,
        pdfPath: pdfPath,
        suffix: 'first',
      );

      String? lastPagePath;
      if (document.pagesCount > 1) {
        lastPagePath = await _renderPage(
          document,
          pageNumber: document.pagesCount,
          pdfPath: pdfPath,
          suffix: 'last',
        );
      }

      return PdfPreviewPaths(
        firstPagePath: firstPagePath,
        lastPagePath: lastPagePath,
      );
    } finally {
      await document.close();
    }
  }

  Future<String> _renderPage(
    PdfDocument document, {
    required int pageNumber,
    required String pdfPath,
    required String suffix,
  }) async {
    final page = await document.getPage(pageNumber);
    try {
      final scale = _targetWidth / page.width;
      final image = await page.render(
        width: page.width * scale,
        height: page.height * scale,
        format: PdfPageImageFormat.png,
      );
      if (image == null) {
        throw StateError('Failed to render page $pageNumber of $pdfPath');
      }

      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          '${p.basenameWithoutExtension(pdfPath)}_${suffix}_preview.png';
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(image.bytes);
      return file.path;
    } finally {
      await page.close();
    }
  }
}
