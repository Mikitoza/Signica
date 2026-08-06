import 'dart:ui';

import 'package:signica/domain/entities/document_entity.dart';

abstract class DocumentsRepository {
  Future<DocumentEntity?> importFromFiles();
  Future<DocumentEntity?> importFromScanner();
  Future<DocumentEntity?> importFromPhotos();
  Stream<List<DocumentEntity>> watchDocuments();
  Future<void> clearAllDocuments();
  Future<void> deleteDocuments(List<int> ids);
  Future<void> setDocumentSigned(int id, {required bool isSigned});
  Future<void> printDocument(int id);
  Future<void> shareDocuments(List<int> ids, {Rect? sharePositionOrigin});
}
