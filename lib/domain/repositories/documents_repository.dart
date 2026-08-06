import 'package:signica/domain/entities/document_entity.dart';

abstract class DocumentsRepository {
  Future<DocumentEntity?> importFromFiles();
  Future<DocumentEntity?> importFromScanner();
  Future<DocumentEntity?> importFromPhotos();
  Stream<List<DocumentEntity>> watchDocuments();
  Future<void> clearAllDocuments();
}
