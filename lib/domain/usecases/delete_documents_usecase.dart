import 'package:injectable/injectable.dart';
import 'package:signica/domain/repositories/documents_repository.dart';

@injectable
class DeleteDocumentsUseCase {
  const DeleteDocumentsUseCase(this._repository);

  final DocumentsRepository _repository;

  Future<void> call(List<int> ids) => _repository.deleteDocuments(ids);
}
