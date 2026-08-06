import 'package:injectable/injectable.dart';
import 'package:signica/domain/entities/document_entity.dart';
import 'package:signica/domain/repositories/documents_repository.dart';

@injectable
class WatchDocumentsUseCase {
  const WatchDocumentsUseCase(this._repository);

  final DocumentsRepository _repository;

  Stream<List<DocumentEntity>> call() => _repository.watchDocuments();
}
