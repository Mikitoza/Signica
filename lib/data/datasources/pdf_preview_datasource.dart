class PdfPreviewPaths {
  const PdfPreviewPaths({required this.firstPagePath, this.lastPagePath});

  final String firstPagePath;
  final String? lastPagePath;
}

abstract class PdfPreviewDatasource {
  Future<PdfPreviewPaths> renderPreviews(String pdfPath);
}
