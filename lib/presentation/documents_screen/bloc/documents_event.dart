import 'dart:ui';

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

/// The bottom bar's search button turns into a field in place.
class DocumentsSearchOpened extends DocumentsEvent {
  const DocumentsSearchOpened();
}

class DocumentsSearchClosed extends DocumentsEvent {
  const DocumentsSearchClosed();
}

class DocumentsSearchQueryChanged extends DocumentsEvent {
  const DocumentsSearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

/// A plain tap on a document flips it between signed and unsigned.
class DocumentSignatureToggled extends DocumentsEvent {
  const DocumentSignatureToggled(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

/// Single-document actions, raised from the long-press context menu.
class DocumentPrintRequested extends DocumentsEvent {
  const DocumentPrintRequested(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class DocumentShareRequested extends DocumentsEvent {
  const DocumentShareRequested(this.id, {this.sharePositionOrigin});

  final int id;
  final Rect? sharePositionOrigin;

  @override
  List<Object?> get props => [id, sharePositionOrigin];
}

class DocumentDeleteRequested extends DocumentsEvent {
  const DocumentDeleteRequested(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

class DocumentsSelectionModeEntered extends DocumentsEvent {
  const DocumentsSelectionModeEntered();
}

class DocumentsSelectionModeExited extends DocumentsEvent {
  const DocumentsSelectionModeExited();
}

class DocumentSelectionToggled extends DocumentsEvent {
  const DocumentSelectionToggled(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

/// Selects every document, or clears the selection when all are already
/// selected.
class DocumentsSelectAllToggled extends DocumentsEvent {
  const DocumentsSelectAllToggled();
}

class DocumentsDeleteSelectedRequested extends DocumentsEvent {
  const DocumentsDeleteSelectedRequested();
}

class DocumentsShareSelectedRequested extends DocumentsEvent {
  const DocumentsShareSelectedRequested({this.sharePositionOrigin});

  final Rect? sharePositionOrigin;

  @override
  List<Object?> get props => [sharePositionOrigin];
}
