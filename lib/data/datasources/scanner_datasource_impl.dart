import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:injectable/injectable.dart';
import 'package:signica/data/datasources/scanner_datasource.dart';

@LazySingleton(as: ScannerDatasource)
class ScannerDatasourceImpl implements ScannerDatasource {
  @override
  Future<List<String>> scan() async {
    final pages = await CunningDocumentScanner.getPictures(
      scannerSource: ScannerSource.camera,
    );
    return pages ?? const [];
  }
}
