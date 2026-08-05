/// All `easy_localization` keys used across the app, mirroring the
/// structure of `assets/translations/en.json`.
///
/// Use these instead of raw string literals, e.g. `AppTranslationKeys.emptyTitle.tr()`
/// — keeps key typos from surfacing at runtime as untranslated raw text.
class AppTranslationKeys {
  // common
  static const appName = 'common.appName';

  // documents.filters
  static const filterAll = 'documents.filters.all';
  static const filterSigned = 'documents.filters.signed';
  static const filterUnsigned = 'documents.filters.unsigned';

  // documents.empty
  static const emptyTitle = 'documents.empty.title';
  static const emptySubtitle = 'documents.empty.subtitle';

  // documents.sources
  static const sourceFiles = 'documents.sources.files';
  static const sourcePhotos = 'documents.sources.photos';
  static const sourceScanner = 'documents.sources.scanner';

  // documents (root)
  static const documentsSearch = 'documents.search';
  static const documentsAddDocument = 'documents.addDocument';

  // menu
  static const menuSelect = 'menu.select';
  static const menuAddDocument = 'menu.addDocument';
}
