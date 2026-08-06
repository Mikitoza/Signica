import 'package:signica/domain/entities/document_entity.dart';

abstract class LocalDatasource {
  Future<DocumentEntity> insertDocument({
    required String title,
    required String filePath,
    String? firstPageImagePath,
    String? lastPageImagePath,
  });

  Stream<List<DocumentEntity>> watchDocuments();

  Future<List<DocumentEntity>> getAllDocuments();

  Future<List<DocumentEntity>> getDocumentsByIds(List<int> ids);

  Future<void> deleteDocuments(List<int> ids);

  Future<void> setSigned(int id, bool isSigned);

  Future<void> clearAllDocuments();
}
