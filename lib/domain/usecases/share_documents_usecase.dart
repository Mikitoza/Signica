import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:signica/domain/repositories/documents_repository.dart';

@injectable
class ShareDocumentsUseCase {
  const ShareDocumentsUseCase(this._repository);

  final DocumentsRepository _repository;

  Future<void> call(List<int> ids, {Rect? sharePositionOrigin}) =>
      _repository.shareDocuments(ids, sharePositionOrigin: sharePositionOrigin);
}
