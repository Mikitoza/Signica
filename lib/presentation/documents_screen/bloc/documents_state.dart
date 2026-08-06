import 'package:equatable/equatable.dart';
import 'package:signica/domain/entities/document_entity.dart';

class DocumentsState extends Equatable {
  const DocumentsState({
    this.documents = const [],
    this.selectedFilter = 0,
    this.isImporting = false,
    this.isSelectionMode = false,
    this.selectedIds = const {},
    this.isSearching = false,
    this.searchQuery = '',
    this.errorMessage,
  });

  final List<DocumentEntity> documents;
  final int selectedFilter;
  final bool isImporting;
  final bool isSelectionMode;
  final Set<int> selectedIds;
  final bool isSearching;
  final String searchQuery;
  final String? errorMessage;

  /// Documents left after the All / Signed / Unsigned control and the search
  /// query.
  List<DocumentEntity> get visibleDocuments {
    final query = searchQuery.trim().toLowerCase();
    return documents.where((document) {
      final matchesFilter = switch (selectedFilter) {
        1 => document.isSigned,
        2 => !document.isSigned,
        _ => true,
      };
      if (!matchesFilter) return false;
      if (query.isEmpty) return true;
      return document.title.toLowerCase().contains(query);
    }).toList();
  }

  int get selectedCount => selectedIds.length;

  bool get hasSelection => selectedIds.isNotEmpty;

  DocumentsState copyWith({
    List<DocumentEntity>? documents,
    int? selectedFilter,
    bool? isImporting,
    bool? isSelectionMode,
    Set<int>? selectedIds,
    bool? isSearching,
    String? searchQuery,
    String? errorMessage,
  }) {
    return DocumentsState(
      documents: documents ?? this.documents,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isImporting: isImporting ?? this.isImporting,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedIds: selectedIds ?? this.selectedIds,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    documents,
    selectedFilter,
    isImporting,
    isSelectionMode,
    selectedIds,
    isSearching,
    searchQuery,
    errorMessage,
  ];
}
