import 'package:injectable/injectable.dart';
import 'package:signica/domain/entities/document_entity.dart';
import 'package:signica/domain/repositories/documents_repository.dart';

@injectable
class ImportPdfFromFilesUseCase {
  const ImportPdfFromFilesUseCase(this._repository);

  final DocumentsRepository _repository;

  Future<DocumentEntity?> call() => _repository.importFromFiles();
}
