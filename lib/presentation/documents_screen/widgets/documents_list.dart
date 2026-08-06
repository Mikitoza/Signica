import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/domain/entities/document_entity.dart';
import 'package:signica/presentation/const/assets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/dimensions.dart';
import 'package:signica/presentation/const/glass.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';

class DocumentsList extends StatelessWidget {
  const DocumentsList({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.onPickFiles,
    required this.onPickScanner,
    required this.onPickPhotos,
    this.documents = const [],
    this.hasDocuments = false,
    this.isImporting = false,
    this.isSelectionMode = false,
    this.selectedIds = const {},
    this.onSelectionToggled,
    this.onSignatureToggled,
    this.onDocumentLongPress,
  });

  final int selectedFilter;
  final ValueChanged<int> onFilterSelected;
  final bool hasDocuments;
  final List<DocumentEntity> documents;
  final bool isImporting;
  final VoidCallback onPickFiles;
  final VoidCallback onPickScanner;
  final VoidCallback onPickPhotos;
  final bool isSelectionMode;
  final Set<int> selectedIds;
  final ValueChanged<int>? onSelectionToggled;
  final ValueChanged<int>? onSignatureToggled;
  final void Function(DocumentEntity document, Rect anchor)?
  onDocumentLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + AppSizes.headerHeight,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(AppRadii.board),
        ),
        child: Column(
          children: [
            Padding(
              padding: AppInsets.segmentedControl,
              child: GlassSegmentedControl(
                segments: [
                  GlassSegment(label: AppTranslationKeys.filterAll.tr()),
                  GlassSegment(label: AppTranslationKeys.filterSigned.tr()),
                  GlassSegment(label: AppTranslationKeys.filterUnsigned.tr()),
                ],
                backgroundColor: AppColors.segmentBackground,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppGaps.s,
                  vertical: AppGaps.xs,
                ),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                indicatorColor: AppColors.white,
                selectedIndex: selectedFilter,
                onSegmentSelected: onFilterSelected,
                height: AppSizes.segmentControlHeight,
                useOwnLayer: true,
                selectedTextStyle: AppTextTheme.segmentLabelStyle,
                unselectedTextStyle: AppTextTheme.segmentLabelStyle,
              ),
            ),
            Expanded(
              child: _DocumentsContent(
                documents: documents,
                hasDocuments: hasDocuments,
                isImporting: isImporting,
                onPickFiles: onPickFiles,
                onPickScanner: onPickScanner,
                onPickPhotos: onPickPhotos,
                isSelectionMode: isSelectionMode,
                selectedIds: selectedIds,
                onSelectionToggled: onSelectionToggled,
                onSignatureToggled: onSignatureToggled,
                onDocumentLongPress: onDocumentLongPress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentsContent extends StatelessWidget {
  const _DocumentsContent({
    required this.documents,
    required this.hasDocuments,
    required this.isImporting,
    required this.onPickFiles,
    required this.onPickScanner,
    required this.onPickPhotos,
    required this.isSelectionMode,
    required this.selectedIds,
    required this.onSelectionToggled,
    required this.onSignatureToggled,
    required this.onDocumentLongPress,
  });

  final List<DocumentEntity> documents;
  final bool hasDocuments;
  final bool isImporting;
  final VoidCallback onPickFiles;
  final VoidCallback onPickScanner;
  final VoidCallback onPickPhotos;
  final bool isSelectionMode;
  final Set<int> selectedIds;
  final ValueChanged<int>? onSelectionToggled;
  final ValueChanged<int>? onSignatureToggled;
  final void Function(DocumentEntity document, Rect anchor)?
  onDocumentLongPress;

  @override
  Widget build(BuildContext context) {
    if (!hasDocuments) {
      return EmptyDocumentsState(
        isImporting: isImporting,
        onPickFiles: onPickFiles,
        onPickScanner: onPickScanner,
        onPickPhotos: onPickPhotos,
      );
    }

    if (documents.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppInsets.screenHorizontal,
          ),
          child: Text(
            AppTranslationKeys.documentsNoResults.tr(),
            textAlign: TextAlign.center,
            style: AppTextTheme.smallTextStyle,
          ),
        ),
      );
    }

    return DocumentsGrid(
      documents: documents,
      isSelectionMode: isSelectionMode,
      selectedIds: selectedIds,
      onSelectionToggled: onSelectionToggled,
      onSignatureToggled: onSignatureToggled,
      onLongPress: onDocumentLongPress,
    );
  }
}

class EmptyDocumentsState extends StatelessWidget {
  const EmptyDocumentsState({
    super.key,
    required this.onPickFiles,
    required this.onPickScanner,
    required this.onPickPhotos,
    this.isImporting = false,
  });

  final bool isImporting;
  final VoidCallback onPickFiles;
  final VoidCallback onPickScanner;
  final VoidCallback onPickPhotos;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.screenHorizontal,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: AppInsets.emptyStateTop),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight:
                          constraints.maxHeight *
                          AppRatios.emptyIllustrationHeight,
                      maxWidth: constraints.maxWidth,
                    ),
                    child: Image.asset(
                      AppAssets.documentPreview,
                      fit: BoxFit.contain,
                    ),
                  ),
                  AppGaps.gapL,
                  Text(
                    AppTranslationKeys.emptyTitle.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextTheme.emptyTitleStyle,
                  ),
                  AppGaps.gapXs,
                  Text(
                    AppTranslationKeys.emptySubtitle.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextTheme.smallTextStyle,
                  ),
                  AppGaps.gapXl,
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppGaps.m,
                    runSpacing: AppGaps.m,
                    children: [
                      SourcePill(
                        iconAsset: AppAssets.filesIcon,
                        label: AppTranslationKeys.sourceFiles.tr(),
                        enabled: !isImporting,
                        onTap: onPickFiles,
                      ),
                      SourcePill(
                        iconAsset: AppAssets.photoIcon,
                        label: AppTranslationKeys.sourcePhotos.tr(),
                        enabled: !isImporting,
                        onTap: onPickPhotos,
                      ),
                      SourcePill(
                        iconAsset: AppAssets.cameraIcon,
                        label: AppTranslationKeys.sourceScanner.tr(),
                        enabled: !isImporting,
                        onTap: onPickScanner,
                      ),
                    ],
                  ),
                  if (isImporting) ...[
                    AppGaps.gapXl,
                    const CupertinoActivityIndicator(),
                  ],
                  const SizedBox(height: AppInsets.gridBottom),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SourcePill extends StatelessWidget {
  const SourcePill({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.onTap,
    this.enabled = true,
  });

  final String iconAsset;
  final String label;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : AppOpacities.disabledPill,
      child: GlassButton.custom(
        onTap: onTap,
        enabled: enabled,
        label: label,
        shape: const LiquidRoundedRectangle(borderRadius: AppRadii.pill),
        style: GlassButtonStyle.prominent,
        useOwnLayer: true,
        settings: AppGlass.settings(glassColor: AppColors.glassWhite),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppGaps.xl,
            vertical: AppGaps.m,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                iconAsset,
                width: AppSizes.sourceIcon,
                height: AppSizes.sourceIcon,
              ),
              AppGaps.hGapS,
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextTheme.sourcePillStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentsGrid extends StatelessWidget {
  const DocumentsGrid({
    super.key,
    required this.documents,
    this.isSelectionMode = false,
    this.selectedIds = const {},
    this.onSelectionToggled,
    this.onSignatureToggled,
    this.onLongPress,
  });

  final List<DocumentEntity> documents;
  final bool isSelectionMode;
  final Set<int> selectedIds;
  final ValueChanged<int>? onSelectionToggled;
  final ValueChanged<int>? onSignatureToggled;
  final void Function(DocumentEntity document, Rect anchor)? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: AppInsets.grid,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: AppGrid.maxTileExtent,
        crossAxisSpacing: AppGrid.crossSpacing,
        mainAxisSpacing: AppGrid.mainSpacing,
        childAspectRatio: AppGrid.tileAspectRatio,
      ),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        return DocumentTile(
          document: document,
          isSelectionMode: isSelectionMode,
          isSelected: selectedIds.contains(document.id),
          onTap: () {
            if (isSelectionMode) {
              onSelectionToggled?.call(document.id);
            } else {
              onSignatureToggled?.call(document.id);
            }
          },
          onLongPress: isSelectionMode || onLongPress == null
              ? null
              : (rect) => onLongPress!(document, rect),
        );
      },
    );
  }
}

class DocumentTile extends StatelessWidget {
  const DocumentTile({
    super.key,
    required this.document,
    this.onTap,
    this.onLongPress,
    this.isSelectionMode = false,
    this.isSelected = false,
  });

  final DocumentEntity document;
  final VoidCallback? onTap;
  final ValueChanged<Rect>? onLongPress;
  final bool isSelectionMode;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final tile = _DocumentTileBody(
      document: document,
      isSelectionMode: isSelectionMode,
      isSelected: isSelected,
    );
    if (onTap == null && onLongPress == null) return tile;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onLongPress: onLongPress == null
          ? null
          : () {
              final rect = _globalRect(context);
              if (rect != null) onLongPress!(rect);
            },
      child: tile,
    );
  }

  Rect? _globalRect(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
  }
}

class _DocumentTileBody extends StatelessWidget {
  const _DocumentTileBody({
    required this.document,
    required this.isSelectionMode,
    required this.isSelected,
  });

  final DocumentEntity document;
  final bool isSelectionMode;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(child: _DocumentThumbnail(document: document)),
              if (document.isSigned)
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: AppSizes.signedBadgeOverhang,
                  child: Center(child: _SignedBadge()),
                ),
              if (isSelectionMode)
                Positioned.fill(
                  child: Center(child: _SelectionBadge(isSelected: isSelected)),
                ),
            ],
          ),
        ),
        AppGaps.gapS,
        Text(
          document.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextTheme.documentTitleStyle,
        ),
        AppGaps.gapXxs,
        Text(
          _formatDate(document.createdAt),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextTheme.documentDateStyle,
        ),
      ],
    );
  }
}

class _SignedBadge extends StatelessWidget {
  const _SignedBadge();

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: AppSizes.signedBadge,
      height: AppSizes.signedBadge,
      useOwnLayer: true,
      shape: const LiquidRoundedRectangle(borderRadius: AppRadii.signedBadge),
      settings: AppGlass.settings(
        refraction: 0,
        depth: 20,
        dispersion: 50,
        frost: 25,
        lightIntensity: 80,
        glassColor: AppColors.signedBadgeGlass,
      ),
      child: Center(
        child: SvgPicture.asset(
          AppAssets.signedIcon,
          width: AppSizes.signedIconWidth,
          height: AppSizes.signedIconHeight,
        ),
      ),
    );
  }
}

class _SelectionBadge extends StatelessWidget {
  const _SelectionBadge({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final badge = AnimatedContainer(
      duration: AppDurations.badge,
      curve: Curves.easeOut,
      width: AppSizes.selectionFill + AppSizes.selectionBorder * 2,
      height: AppSizes.selectionFill + AppSizes.selectionBorder * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.selectionGreen : AppColors.transparent,
        border: Border.all(
          color: AppColors.white,
          width: AppSizes.selectionBorder,
        ),
        boxShadow: isSelected
            ? const [
                BoxShadow(
                  color: AppColors.badgeShadow,
                  blurRadius: AppShadows.badgeBlur,
                  offset: AppShadows.badgeOffset,
                ),
              ]
            : null,
      ),
      child: isSelected
          ? const Icon(
              CupertinoIcons.checkmark_alt,
              size: AppSizes.selectionCheck,
              color: AppColors.white,
            )
          : null,
    );

    if (isSelected) return badge;

    return CustomPaint(
      painter: const _RingShadowPainter(
        strokeWidth: AppSizes.selectionBorder,
        color: AppColors.badgeShadow,
        blurRadius: AppShadows.badgeBlur,
        offset: AppShadows.badgeOffset,
      ),
      child: badge,
    );
  }
}

class _RingShadowPainter extends CustomPainter {
  const _RingShadowPainter({
    required this.strokeWidth,
    required this.color,
    required this.blurRadius,
    required this.offset,
  });

  final double strokeWidth;
  final Color color;
  final double blurRadius;
  final Offset offset;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        Shadow.convertRadiusToSigma(blurRadius),
      );
    final radius = (size.shortestSide - strokeWidth) / 2;
    canvas.drawCircle(size.center(offset), radius, paint);
  }

  @override
  bool shouldRepaint(_RingShadowPainter oldDelegate) =>
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.color != color ||
      oldDelegate.blurRadius != blurRadius ||
      oldDelegate.offset != offset;
}

class _DocumentThumbnail extends StatelessWidget {
  const _DocumentThumbnail({required this.document});

  final DocumentEntity document;

  @override
  Widget build(BuildContext context) {
    final firstPagePath = document.firstPageImagePath;
    if (firstPagePath == null) {
      return const _ThumbnailPage(
        elevated: true,
        child: Icon(CupertinoIcons.doc_text),
      );
    }

    final lastPagePath = document.lastPageImagePath;
    if (lastPagePath == null) {
      return _ThumbnailPage(
        elevated: true,
        child: _PreviewImage(path: firstPagePath),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final offset = constraints.maxWidth * AppRatios.backPageOffset;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: offset,
              right: -offset,
              top: -offset,
              bottom: offset,
              child: _ThumbnailPage(child: _PreviewImage(path: lastPagePath)),
            ),
            Positioned.fill(
              child: Transform.rotate(
                angle: AppRatios.frontPageTilt,
                child: _ThumbnailPage(
                  elevated: true,
                  child: _PreviewImage(path: firstPagePath),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PreviewImage extends StatelessWidget {
  const _PreviewImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Center(child: Icon(CupertinoIcons.doc_text)),
    );
  }
}

class _ThumbnailPage extends StatelessWidget {
  const _ThumbnailPage({required this.child, this.elevated = false});

  final Widget child;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.page),
        border: Border.all(color: AppColors.pageBorder),
        boxShadow: elevated
            ? const [
                BoxShadow(
                  color: AppColors.pageShadow,
                  blurRadius: AppShadows.pageBlur,
                  offset: AppShadows.pageOffset,
                ),
              ]
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

String _formatDate(DateTime date) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return '${twoDigits(date.day)}.${twoDigits(date.month)}.${date.year}';
}
