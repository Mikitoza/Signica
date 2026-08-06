import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:signica/data/datasources/pdf_builder_datasource.dart';

@LazySingleton(as: PdfBuilderDatasource)
class PdfBuilderDatasourceImpl implements PdfBuilderDatasource {
  @override
  Future<String> buildFromImages(List<String> imagePaths) async {
    final document = pw.Document();
    for (final imagePath in imagePaths) {
      final bytes = await File(imagePath).readAsBytes();
      final image = pw.MemoryImage(bytes);
      document.addPage(
        pw.Page(
          build: (context) =>
              pw.Center(child: pw.Image(image, fit: pw.BoxFit.contain)),
        ),
      );
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'document_${DateTime.now().microsecondsSinceEpoch}.pdf';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(await document.save());
    return file.path;
  }
}
