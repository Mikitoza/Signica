import 'package:equatable/equatable.dart';
import 'package:signica/domain/entities/document_entity.dart';

class DocumentsState extends Equatable {
  const DocumentsState({
    this.documents = const [],
    this.selectedFilter = 0,
    this.isImporting = false,
    this.errorMessage,
  });

  final List<DocumentEntity> documents;
  final int selectedFilter;
  final bool isImporting;
  final String? errorMessage;

  DocumentsState copyWith({
    List<DocumentEntity>? documents,
    int? selectedFilter,
    bool? isImporting,
    String? errorMessage,
  }) {
    return DocumentsState(
      documents: documents ?? this.documents,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isImporting: isImporting ?? this.isImporting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    documents,
    selectedFilter,
    isImporting,
    errorMessage,
  ];
}
