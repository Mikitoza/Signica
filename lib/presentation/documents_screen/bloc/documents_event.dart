import 'package:equatable/equatable.dart';

sealed class DocumentsEvent extends Equatable {
  const DocumentsEvent();

  @override
  List<Object?> get props => [];
}

class DocumentsSubscriptionRequested extends DocumentsEvent {
  const DocumentsSubscriptionRequested();
}

class DocumentsFilterSelected extends DocumentsEvent {
  const DocumentsFilterSelected(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class DocumentsImportFromFilesRequested extends DocumentsEvent {
  const DocumentsImportFromFilesRequested();
}

class DocumentsImportFromScannerRequested extends DocumentsEvent {
  const DocumentsImportFromScannerRequested();
}

class DocumentsImportFromPhotosRequested extends DocumentsEvent {
  const DocumentsImportFromPhotosRequested();
}

class DocumentsClearAllRequested extends DocumentsEvent {
  const DocumentsClearAllRequested();
}
