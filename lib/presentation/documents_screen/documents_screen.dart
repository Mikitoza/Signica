import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/injection/injector.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/translation_keys.dart';
import 'package:signica/presentation/documents_screen/bloc/documents_bloc.dart';
import 'package:signica/presentation/documents_screen/bloc/documents_event.dart';
import 'package:signica/presentation/documents_screen/bloc/documents_state.dart';
import 'package:signica/presentation/documents_screen/widgets/add_document_sheet.dart';
import 'package:signica/presentation/documents_screen/widgets/document_context_menu.dart';
import 'package:signica/presentation/documents_screen/widgets/documents_bottom_bar.dart';
import 'package:signica/presentation/documents_screen/widgets/documents_list.dart';
import 'package:signica/presentation/documents_screen/widgets/signica_header.dart';

@RoutePage()
class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<DocumentsBloc>()..add(const DocumentsSubscriptionRequested()),
      child: BlocListener<DocumentsBloc, DocumentsState>(
        listenWhen: (previous, current) =>
            current.errorMessage != null &&
            current.errorMessage != previous.errorMessage,
        listener: (context, state) {
          GlassToast.show(
            context,
            message: state.errorMessage!,
            type: GlassToastType.error,
          );
        },
        child: Builder(
          builder: (context) {
            final bloc = context.read<DocumentsBloc>();

            void openAddDocumentSheet() => showAddDocumentSheet(
              context,
              onPickFiles: () =>
                  bloc.add(const DocumentsImportFromFilesRequested()),
              onPickPhotos: () =>
                  bloc.add(const DocumentsImportFromPhotosRequested()),
              onPickScanner: () =>
                  bloc.add(const DocumentsImportFromScannerRequested()),
            );

            return BlocBuilder<DocumentsBloc, DocumentsState>(
              builder: (context, state) {
                return GlassScaffold(
                  backgroundColor: AppColors.backgroundColor,
                  extendBody: true,
                  appBar: SignicaHeader(
                    onAddDocument: openAddDocumentSheet,
                    onClearAll: () => _confirmClearAll(context, bloc),
                    onEnterSelectionMode: () =>
                        bloc.add(const DocumentsSelectionModeEntered()),
                    onExitSelectionMode: () =>
                        bloc.add(const DocumentsSelectionModeExited()),
                    onToggleSelectAll: () =>
                        bloc.add(const DocumentsSelectAllToggled()),
                    isSelectionMode: state.isSelectionMode,
                    selectedCount: state.selectedCount,
                  ),
                  bottomBar: DocumentsBottomBar(
                    onSearchOpen: () => bloc.add(const DocumentsSearchOpened()),
                    onSearchClose: () =>
                        bloc.add(const DocumentsSearchClosed()),
                    onSearchQueryChanged: (query) =>
                        bloc.add(DocumentsSearchQueryChanged(query)),
                    isSearching: state.isSearching,
                    onAddDocument: openAddDocumentSheet,
                    onDeleteSelected: () =>
                        _confirmDeleteSelected(context, bloc),
                    onShareSelected: (origin) => bloc.add(
                      DocumentsShareSelectedRequested(
                        sharePositionOrigin: origin,
                      ),
                    ),
                    isSelectionMode: state.isSelectionMode,
                    hasSelection: state.hasSelection,
                  ),
                  body: SafeArea(
                    bottom: false,
                    child: DocumentsList(
                      documents: state.visibleDocuments,
                      hasDocuments: state.documents.isNotEmpty,
                      selectedFilter: state.selectedFilter,
                      onFilterSelected: (index) =>
                          bloc.add(DocumentsFilterSelected(index)),
                      isImporting: state.isImporting,
                      onPickFiles: () =>
                          bloc.add(const DocumentsImportFromFilesRequested()),
                      onPickScanner: () =>
                          bloc.add(const DocumentsImportFromScannerRequested()),
                      onPickPhotos: () =>
                          bloc.add(const DocumentsImportFromPhotosRequested()),
                      isSelectionMode: state.isSelectionMode,
                      selectedIds: state.selectedIds,
                      onSelectionToggled: (id) =>
                          bloc.add(DocumentSelectionToggled(id)),
                      onSignatureToggled: (id) =>
                          bloc.add(DocumentSignatureToggled(id)),
                      onDocumentLongPress: (document, anchor) =>
                          showDocumentContextMenu(
                            context,
                            document: document,
                            anchor: anchor,
                            onPrint: () =>
                                bloc.add(DocumentPrintRequested(document.id)),
                            onShare: (origin) => bloc.add(
                              DocumentShareRequested(
                                document.id,
                                sharePositionOrigin: origin,
                              ),
                            ),
                            onDelete: () =>
                                bloc.add(DocumentDeleteRequested(document.id)),
                          ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Future<void> _confirmDeleteSelected(
  BuildContext context,
  DocumentsBloc bloc,
) async {
  await GlassDialog.show<void>(
    context: context,
    title: AppTranslationKeys.selectionDeleteConfirmTitle.tr(),
    message: AppTranslationKeys.selectionDeleteConfirmMessage.tr(),
    actions: [
      GlassDialogAction(
        label: AppTranslationKeys.cancel.tr(),
        onPressed: () => Navigator.of(context).pop(),
      ),
      GlassDialogAction(
        label: AppTranslationKeys.selectionDeleteConfirmAction.tr(),
        isDestructive: true,
        onPressed: () {
          Navigator.of(context).pop();
          bloc.add(const DocumentsDeleteSelectedRequested());
        },
      ),
    ],
  );
}

Future<void> _confirmClearAll(BuildContext context, DocumentsBloc bloc) async {
  await GlassDialog.show<void>(
    context: context,
    title: AppTranslationKeys.menuClearAllConfirmTitle.tr(),
    message: AppTranslationKeys.menuClearAllConfirmMessage.tr(),
    actions: [
      GlassDialogAction(
        label: AppTranslationKeys.cancel.tr(),
        onPressed: () => Navigator.of(context).pop(),
      ),
      GlassDialogAction(
        label: AppTranslationKeys.menuClearAllConfirmAction.tr(),
        isDestructive: true,
        onPressed: () {
          Navigator.of(context).pop();
          bloc.add(const DocumentsClearAllRequested());
        },
      ),
    ],
  );
}
