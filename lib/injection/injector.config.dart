// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:signica/data/datasources/files_picker_datasource.dart' as _i589;
import 'package:signica/data/datasources/files_picker_datasource_impl.dart'
    as _i817;
import 'package:signica/data/datasources/pdf_builder_datasource.dart' as _i513;
import 'package:signica/data/datasources/pdf_builder_datasource_impl.dart'
    as _i485;
import 'package:signica/data/datasources/pdf_preview_datasource.dart' as _i623;
import 'package:signica/data/datasources/pdf_preview_datasource_impl.dart'
    as _i509;
import 'package:signica/data/datasources/photos_picker_datasource.dart' as _i4;
import 'package:signica/data/datasources/photos_picker_datasource_impl.dart'
    as _i792;
import 'package:signica/data/datasources/print_datasource.dart' as _i539;
import 'package:signica/data/datasources/print_datasource_impl.dart' as _i647;
import 'package:signica/data/datasources/scanner_datasource.dart' as _i21;
import 'package:signica/data/datasources/scanner_datasource_impl.dart' as _i477;
import 'package:signica/data/datasources/share_datasource.dart' as _i550;
import 'package:signica/data/datasources/share_datasource_impl.dart' as _i1035;
import 'package:signica/data/local_datasource/database/app_database.dart'
    as _i723;
import 'package:signica/data/local_datasource/local_datasource.dart' as _i884;
import 'package:signica/data/local_datasource/local_datasource_impl.dart'
    as _i92;
import 'package:signica/data/repository/repository_impl.dart' as _i61;
import 'package:signica/domain/repositories/documents_repository.dart' as _i574;
import 'package:signica/domain/usecases/clear_all_documents_usecase.dart'
    as _i400;
import 'package:signica/domain/usecases/delete_documents_usecase.dart' as _i604;
import 'package:signica/domain/usecases/import_document_from_photos_usecase.dart'
    as _i648;
import 'package:signica/domain/usecases/import_document_from_scanner_usecase.dart'
    as _i464;
import 'package:signica/domain/usecases/import_pdf_from_files_usecase.dart'
    as _i885;
import 'package:signica/domain/usecases/print_document_usecase.dart' as _i808;
import 'package:signica/domain/usecases/set_document_signed_usecase.dart'
    as _i916;
import 'package:signica/domain/usecases/share_documents_usecase.dart' as _i585;
import 'package:signica/domain/usecases/watch_documents_usecase.dart' as _i948;
import 'package:signica/presentation/documents_screen/bloc/documents_bloc.dart'
    as _i381;
import 'package:signica/presentation/router/app_router.dart' as _i198;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i723.AppDatabase>(() => _i723.AppDatabase());
    gh.lazySingleton<_i198.AppRouter>(() => _i198.AppRouter());
    gh.lazySingleton<_i4.PhotosPickerDatasource>(
      () => _i792.PhotosPickerDatasourceImpl(),
    );
    gh.lazySingleton<_i550.ShareDatasource>(() => _i1035.ShareDatasourceImpl());
    gh.lazySingleton<_i884.LocalDatasource>(
      () => _i92.LocalDatasourceImpl(gh<_i723.AppDatabase>()),
    );
    gh.lazySingleton<_i513.PdfBuilderDatasource>(
      () => _i485.PdfBuilderDatasourceImpl(),
    );
    gh.lazySingleton<_i539.PrintDatasource>(() => _i647.PrintDatasourceImpl());
    gh.lazySingleton<_i21.ScannerDatasource>(
      () => _i477.ScannerDatasourceImpl(),
    );
    gh.lazySingleton<_i589.FilesPickerDatasource>(
      () => _i817.FilesPickerDatasourceImpl(),
    );
    gh.lazySingleton<_i623.PdfPreviewDatasource>(
      () => _i509.PdfPreviewDatasourceImpl(),
    );
    gh.lazySingleton<_i574.DocumentsRepository>(
      () => _i61.DocumentsRepositoryImpl(
        filesPickerDatasource: gh<_i589.FilesPickerDatasource>(),
        scannerDatasource: gh<_i21.ScannerDatasource>(),
        photosPickerDatasource: gh<_i4.PhotosPickerDatasource>(),
        pdfBuilderDatasource: gh<_i513.PdfBuilderDatasource>(),
        pdfPreviewDatasource: gh<_i623.PdfPreviewDatasource>(),
        shareDatasource: gh<_i550.ShareDatasource>(),
        printDatasource: gh<_i539.PrintDatasource>(),
        localDatasource: gh<_i884.LocalDatasource>(),
      ),
    );
    gh.factory<_i400.ClearAllDocumentsUseCase>(
      () => _i400.ClearAllDocumentsUseCase(gh<_i574.DocumentsRepository>()),
    );
    gh.factory<_i604.DeleteDocumentsUseCase>(
      () => _i604.DeleteDocumentsUseCase(gh<_i574.DocumentsRepository>()),
    );
    gh.factory<_i648.ImportDocumentFromPhotosUseCase>(
      () => _i648.ImportDocumentFromPhotosUseCase(
        gh<_i574.DocumentsRepository>(),
      ),
    );
    gh.factory<_i464.ImportDocumentFromScannerUseCase>(
      () => _i464.ImportDocumentFromScannerUseCase(
        gh<_i574.DocumentsRepository>(),
      ),
    );
    gh.factory<_i885.ImportPdfFromFilesUseCase>(
      () => _i885.ImportPdfFromFilesUseCase(gh<_i574.DocumentsRepository>()),
    );
    gh.factory<_i808.PrintDocumentUseCase>(
      () => _i808.PrintDocumentUseCase(gh<_i574.DocumentsRepository>()),
    );
    gh.factory<_i916.SetDocumentSignedUseCase>(
      () => _i916.SetDocumentSignedUseCase(gh<_i574.DocumentsRepository>()),
    );
    gh.factory<_i585.ShareDocumentsUseCase>(
      () => _i585.ShareDocumentsUseCase(gh<_i574.DocumentsRepository>()),
    );
    gh.factory<_i948.WatchDocumentsUseCase>(
      () => _i948.WatchDocumentsUseCase(gh<_i574.DocumentsRepository>()),
    );
    gh.factory<_i381.DocumentsBloc>(
      () => _i381.DocumentsBloc(
        importPdfFromFiles: gh<_i885.ImportPdfFromFilesUseCase>(),
        importDocumentFromScanner: gh<_i464.ImportDocumentFromScannerUseCase>(),
        importDocumentFromPhotos: gh<_i648.ImportDocumentFromPhotosUseCase>(),
        watchDocuments: gh<_i948.WatchDocumentsUseCase>(),
        clearAllDocuments: gh<_i400.ClearAllDocumentsUseCase>(),
        deleteDocuments: gh<_i604.DeleteDocumentsUseCase>(),
        shareDocuments: gh<_i585.ShareDocumentsUseCase>(),
        setDocumentSigned: gh<_i916.SetDocumentSignedUseCase>(),
        printDocument: gh<_i808.PrintDocumentUseCase>(),
      ),
    );
    return this;
  }
}
