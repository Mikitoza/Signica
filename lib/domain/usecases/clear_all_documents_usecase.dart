import 'package:injectable/injectable.dart';
import 'package:signica/domain/repositories/documents_repository.dart';

@injectable
class ClearAllDocumentsUseCase {
  const ClearAllDocumentsUseCase(this._repository);

  final DocumentsRepository _repository;

  Future<void> call() => _repository.clearAllDocuments();
}
