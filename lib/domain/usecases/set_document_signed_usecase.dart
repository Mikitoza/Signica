import 'package:injectable/injectable.dart';
import 'package:signica/domain/repositories/documents_repository.dart';

@injectable
class SetDocumentSignedUseCase {
  const SetDocumentSignedUseCase(this._repository);

  final DocumentsRepository _repository;

  Future<void> call(int id, {required bool isSigned}) =>
      _repository.setDocumentSigned(id, isSigned: isSigned);
}
