import 'package:injectable/injectable.dart';
import 'package:signica/domain/repositories/documents_repository.dart';

@injectable
class PrintDocumentUseCase {
  const PrintDocumentUseCase(this._repository);

  final DocumentsRepository _repository;

  Future<void> call(int id) => _repository.printDocument(id);
}
