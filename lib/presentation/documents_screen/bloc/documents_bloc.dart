import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:signica/domain/entities/document_entity.dart';
import 'package:signica/domain/usecases/clear_all_documents_usecase.dart';
import 'package:signica/domain/usecases/delete_documents_usecase.dart';
import 'package:signica/domain/usecases/import_document_from_photos_usecase.dart';
import 'package:signica/domain/usecases/import_document_from_scanner_usecase.dart';
import 'package:signica/domain/usecases/import_pdf_from_files_usecase.dart';
import 'package:signica/domain/usecases/print_document_usecase.dart';
import 'package:signica/domain/usecases/set_document_signed_usecase.dart';
import 'package:signica/domain/usecases/share_documents_usecase.dart';
import 'package:signica/domain/usecases/watch_documents_usecase.dart';
import 'package:signica/presentation/documents_screen/bloc/documents_event.dart';
import 'package:signica/presentation/documents_screen/bloc/documents_state.dart';

@injectable
class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentsBloc({
    required this._importPdfFromFiles,
    required this._importDocumentFromScanner,
    required this._importDocumentFromPhotos,
    required this._watchDocuments,
    required this._clearAllDocuments,
    required this._deleteDocuments,
    required this._shareDocuments,
    required this._setDocumentSigned,
    required this._printDocument,
  }) : super(const DocumentsState()) {
    on<DocumentsSubscriptionRequested>(_onSubscriptionRequested);
    on<DocumentsFilterSelected>(_onFilterSelected);
    on<DocumentsImportFromFilesRequested>(
      _onImportFromFilesRequested,
      transformer: droppable(),
    );
    on<DocumentsImportFromScannerRequested>(
      _onImportFromScannerRequested,
      transformer: droppable(),
    );
    on<DocumentsImportFromPhotosRequested>(
      _onImportFromPhotosRequested,
      transformer: droppable(),
    );
    on<DocumentsClearAllRequested>(
      _onClearAllRequested,
      transformer: droppable(),
    );
    on<DocumentsSearchOpened>(_onSearchOpened);
    on<DocumentsSearchClosed>(_onSearchClosed);
    on<DocumentsSearchQueryChanged>(_onSearchQueryChanged);
    on<DocumentSignatureToggled>(_onSignatureToggled);
    on<DocumentPrintRequested>(_onPrintRequested, transformer: droppable());
    on<DocumentShareRequested>(_onShareRequested, transformer: droppable());
    on<DocumentDeleteRequested>(_onDeleteRequested, transformer: droppable());
    on<DocumentsSelectionModeEntered>(_onSelectionModeEntered);
    on<DocumentsSelectionModeExited>(_onSelectionModeExited);
    on<DocumentSelectionToggled>(_onSelectionToggled);
    on<DocumentsSelectAllToggled>(_onSelectAllToggled);
    on<DocumentsDeleteSelectedRequested>(
      _onDeleteSelectedRequested,
      transformer: droppable(),
    );
    on<DocumentsShareSelectedRequested>(
      _onShareSelectedRequested,
      transformer: droppable(),
    );
  }

  final ImportPdfFromFilesUseCase _importPdfFromFiles;
  final ImportDocumentFromScannerUseCase _importDocumentFromScanner;
  final ImportDocumentFromPhotosUseCase _importDocumentFromPhotos;
  final WatchDocumentsUseCase _watchDocuments;
  final ClearAllDocumentsUseCase _clearAllDocuments;
  final DeleteDocumentsUseCase _deleteDocuments;
  final ShareDocumentsUseCase _shareDocuments;
  final SetDocumentSignedUseCase _setDocumentSigned;
  final PrintDocumentUseCase _printDocument;

  Future<void> _onSubscriptionRequested(
    DocumentsSubscriptionRequested event,
    Emitter<DocumentsState> emit,
  ) {
    return emit.forEach<List<DocumentEntity>>(
      _watchDocuments(),
      onData: (documents) {
        // Documents can disappear while selection mode is on, so drop ids that
        // no longer exist and leave the mode once nothing is left to act on.
        final availableIds = documents.map((document) => document.id).toSet();
        final selectedIds = state.selectedIds.intersection(availableIds);
        return state.copyWith(
          documents: documents,
          selectedIds: selectedIds,
          isSelectionMode: state.isSelectionMode && documents.isNotEmpty,
        );
      },
    );
  }

  void _onFilterSelected(
    DocumentsFilterSelected event,
    Emitter<DocumentsState> emit,
  ) => emit(state.copyWith(selectedFilter: event.index));

  Future<void> _onImportFromFilesRequested(
    DocumentsImportFromFilesRequested event,
    Emitter<DocumentsState> emit,
  ) => _runImport(emit, _importPdfFromFiles.call);

  Future<void> _onImportFromScannerRequested(
    DocumentsImportFromScannerRequested event,
    Emitter<DocumentsState> emit,
  ) => _runImport(emit, _importDocumentFromScanner.call);

  Future<void> _onImportFromPhotosRequested(
    DocumentsImportFromPhotosRequested event,
    Emitter<DocumentsState> emit,
  ) => _runImport(emit, _importDocumentFromPhotos.call);

  Future<void> _runImport(
    Emitter<DocumentsState> emit,
    Future<DocumentEntity?> Function() importAction,
  ) async {
    emit(state.copyWith(isImporting: true));
    try {
      await importAction();
      emit(state.copyWith(isImporting: false));
    } catch (error) {
      emit(state.copyWith(isImporting: false, errorMessage: error.toString()));
    }
  }

  Future<void> _onClearAllRequested(
    DocumentsClearAllRequested event,
    Emitter<DocumentsState> emit,
  ) async {
    try {
      await _clearAllDocuments();
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  void _onSearchOpened(
    DocumentsSearchOpened event,
    Emitter<DocumentsState> emit,
  ) => emit(state.copyWith(isSearching: true, searchQuery: ''));

  void _onSearchClosed(
    DocumentsSearchClosed event,
    Emitter<DocumentsState> emit,
  ) => emit(state.copyWith(isSearching: false, searchQuery: ''));

  void _onSearchQueryChanged(
    DocumentsSearchQueryChanged event,
    Emitter<DocumentsState> emit,
  ) => emit(state.copyWith(searchQuery: event.query));

  Future<void> _onSignatureToggled(
    DocumentSignatureToggled event,
    Emitter<DocumentsState> emit,
  ) async {
    final matches = state.documents.where(
      (document) => document.id == event.id,
    );
    if (matches.isEmpty) return;
    final document = matches.first;

    try {
      await _setDocumentSigned(document.id, isSigned: !document.isSigned);
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  Future<void> _onPrintRequested(
    DocumentPrintRequested event,
    Emitter<DocumentsState> emit,
  ) async {
    try {
      await _printDocument(event.id);
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  Future<void> _onShareRequested(
    DocumentShareRequested event,
    Emitter<DocumentsState> emit,
  ) async {
    try {
      await _shareDocuments([
        event.id,
      ], sharePositionOrigin: event.sharePositionOrigin);
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  Future<void> _onDeleteRequested(
    DocumentDeleteRequested event,
    Emitter<DocumentsState> emit,
  ) async {
    try {
      await _deleteDocuments([event.id]);
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  void _onSelectionModeEntered(
    DocumentsSelectionModeEntered event,
    Emitter<DocumentsState> emit,
  ) {
    if (state.documents.isEmpty) return;
    emit(state.copyWith(isSelectionMode: true, selectedIds: const {}));
  }

  void _onSelectionModeExited(
    DocumentsSelectionModeExited event,
    Emitter<DocumentsState> emit,
  ) => emit(state.copyWith(isSelectionMode: false, selectedIds: const {}));

  void _onSelectionToggled(
    DocumentSelectionToggled event,
    Emitter<DocumentsState> emit,
  ) {
    final selectedIds = Set<int>.from(state.selectedIds);
    if (!selectedIds.remove(event.id)) {
      selectedIds.add(event.id);
    }
    emit(state.copyWith(selectedIds: selectedIds));
  }

  void _onSelectAllToggled(
    DocumentsSelectAllToggled event,
    Emitter<DocumentsState> emit,
  ) {
    // Anything selected turns the control into "deselect all".
    final selectedIds = state.hasSelection
        ? const <int>{}
        : state.visibleDocuments.map((document) => document.id).toSet();
    emit(state.copyWith(selectedIds: selectedIds));
  }

  Future<void> _onDeleteSelectedRequested(
    DocumentsDeleteSelectedRequested event,
    Emitter<DocumentsState> emit,
  ) async {
    if (state.selectedIds.isEmpty) return;

    final ids = state.selectedIds.toList();
    try {
      await _deleteDocuments(ids);
      emit(state.copyWith(isSelectionMode: false, selectedIds: const {}));
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  Future<void> _onShareSelectedRequested(
    DocumentsShareSelectedRequested event,
    Emitter<DocumentsState> emit,
  ) async {
    if (state.selectedIds.isEmpty) return;

    try {
      await _shareDocuments(
        state.selectedIds.toList(),
        sharePositionOrigin: event.sharePositionOrigin,
      );
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }
}
