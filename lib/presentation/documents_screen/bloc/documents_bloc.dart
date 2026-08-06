import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:signica/domain/entities/document_entity.dart';
import 'package:signica/domain/usecases/clear_all_documents_usecase.dart';
import 'package:signica/domain/usecases/import_document_from_photos_usecase.dart';
import 'package:signica/domain/usecases/import_document_from_scanner_usecase.dart';
import 'package:signica/domain/usecases/import_pdf_from_files_usecase.dart';
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
  }

  final ImportPdfFromFilesUseCase _importPdfFromFiles;
  final ImportDocumentFromScannerUseCase _importDocumentFromScanner;
  final ImportDocumentFromPhotosUseCase _importDocumentFromPhotos;
  final WatchDocumentsUseCase _watchDocuments;
  final ClearAllDocumentsUseCase _clearAllDocuments;

  Future<void> _onSubscriptionRequested(
    DocumentsSubscriptionRequested event,
    Emitter<DocumentsState> emit,
  ) {
    return emit.forEach<List<DocumentEntity>>(
      _watchDocuments(),
      onData: (documents) => state.copyWith(documents: documents),
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
}
