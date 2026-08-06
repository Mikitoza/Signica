import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:signica/data/datasources/files_picker_datasource.dart';
import 'package:signica/data/datasources/pdf_builder_datasource.dart';
import 'package:signica/data/datasources/pdf_preview_datasource.dart';
import 'package:signica/data/datasources/photos_picker_datasource.dart';
import 'package:signica/data/datasources/scanner_datasource.dart';
import 'package:signica/data/local_datasource/local_datasource.dart';
import 'package:signica/domain/entities/document_entity.dart';
import 'package:signica/domain/repositories/documents_repository.dart';

@LazySingleton(as: DocumentsRepository)
class DocumentsRepositoryImpl implements DocumentsRepository {
  DocumentsRepositoryImpl({
    required this._filesPickerDatasource,
    required this._scannerDatasource,
    required this._photosPickerDatasource,
    required this._pdfBuilderDatasource,
    required this._pdfPreviewDatasource,
    required this._localDatasource,
  });

  final FilesPickerDatasource _filesPickerDatasource;
  final ScannerDatasource _scannerDatasource;
  final PhotosPickerDatasource _photosPickerDatasource;
  final PdfBuilderDatasource _pdfBuilderDatasource;
  final PdfPreviewDatasource _pdfPreviewDatasource;
  final LocalDatasource _localDatasource;

  @override
  Future<DocumentEntity?> importFromFiles() async {
    final pickedPath = await _filesPickerDatasource.pickPdf();
    if (pickedPath == null) return null;

    final savedPath = await _persistPdf(pickedPath);
    return _saveDocument(savedPath);
  }

  @override
  Future<DocumentEntity?> importFromScanner() async {
    final imagePaths = await _scannerDatasource.scan();
    if (imagePaths.isEmpty) return null;

    final pdfPath = await _pdfBuilderDatasource.buildFromImages(imagePaths);
    return _saveDocument(pdfPath);
  }

  @override
  Future<DocumentEntity?> importFromPhotos() async {
    final imagePaths = await _photosPickerDatasource.pickImages();
    if (imagePaths.isEmpty) return null;

    final pdfPath = await _pdfBuilderDatasource.buildFromImages(imagePaths);
    return _saveDocument(pdfPath);
  }

  @override
  Stream<List<DocumentEntity>> watchDocuments() =>
      _localDatasource.watchDocuments();

  @override
  Future<void> clearAllDocuments() async {
    final documents = await _localDatasource.getAllDocuments();
    for (final document in documents) {
      await _deleteFileIfExists(document.filePath);
      await _deleteFileIfExists(document.firstPageImagePath);
      await _deleteFileIfExists(document.lastPageImagePath);
    }
    await _localDatasource.clearAllDocuments();
  }

  Future<void> _deleteFileIfExists(String? path) async {
    if (path == null) return;
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<DocumentEntity> _saveDocument(String filePath) async {
    final title = p.basenameWithoutExtension(filePath);
    String? firstPageImagePath;
    String? lastPageImagePath;
    try {
      final previews = await _pdfPreviewDatasource.renderPreviews(filePath);
      firstPageImagePath = previews.firstPagePath;
      lastPageImagePath = previews.lastPagePath;
    } catch (_) {
    }

    return _localDatasource.insertDocument(
      title: title,
      filePath: filePath,
      firstPageImagePath: firstPageImagePath,
      lastPageImagePath: lastPageImagePath,
    );
  }

  Future<String> _persistPdf(String sourcePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        'document_${DateTime.now().microsecondsSinceEpoch}${p.extension(sourcePath)}';
    final destination = await File(
      sourcePath,
    ).copy('${directory.path}/$fileName');
    return destination.path;
  }
}
