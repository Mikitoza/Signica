import 'dart:io';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/domain/entities/document_entity.dart';
import 'package:signica/presentation/const/assets.dart';
import 'package:signica/presentation/const/colors.dart';
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
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 66),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 16,
                bottom: 20,
              ),
              child: GlassSegmentedControl(
                segments: [
                  GlassSegment(label: AppTranslationKeys.filterAll.tr()),
                  GlassSegment(label: AppTranslationKeys.filterSigned.tr()),
                  GlassSegment(label: AppTranslationKeys.filterUnsigned.tr()),
                ],
                backgroundColor: AppColors.segmentBackgroundColor.withValues(
                  alpha: 0.12,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                indicatorColor: AppColors.white,
                selectedIndex: selectedFilter,
                onSegmentSelected: onFilterSelected,
                height: 36,
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
        child: Text(
          AppTranslationKeys.documentsNoResults.tr(),
          style: AppTextTheme.smallTextStyle,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 46),
        Image.asset(AppAssets.documentPreview, fit: BoxFit.cover),
        const SizedBox(height: 18),
        Text(
          AppTranslationKeys.emptyTitle.tr(),
          style: AppTextTheme.logoLabelStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.greyTextColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          AppTranslationKeys.emptySubtitle.tr(),
          style: AppTextTheme.smallTextStyle,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SourcePill(
              iconAsset: AppAssets.filesIcon,
              label: AppTranslationKeys.sourceFiles.tr(),
              enabled: !isImporting,
              onTap: onPickFiles,
            ),
            const SizedBox(width: 12),
            SourcePill(
              iconAsset: AppAssets.photoIcon,
              label: AppTranslationKeys.sourcePhotos.tr(),
              enabled: !isImporting,
              onTap: onPickPhotos,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SourcePill(
          iconAsset: AppAssets.cameraIcon,
          label: AppTranslationKeys.sourceScanner.tr(),
          enabled: !isImporting,
          onTap: onPickScanner,
        ),
        if (isImporting) ...[
          const SizedBox(height: 20),
          const CupertinoActivityIndicator(),
        ],
      ],
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
      opacity: enabled ? 1 : 0.5,
      child: GlassButton.custom(
        onTap: onTap,
        enabled: enabled,
        label: label,
        shape: const LiquidRoundedRectangle(borderRadius: 999),
        style: GlassButtonStyle.prominent,
        useOwnLayer: true,
        settings: AppGlass.settings(
          glassColor: AppColors.white.withValues(alpha: 0.85),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(iconAsset, width: 24, height: 24),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextTheme.logoLabelStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackTextColor,
                  fontSize: 20,
                  height: 1,
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
      padding: const EdgeInsets.fromLTRB(36, 4, 36, 100),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 32,
        mainAxisSpacing: 40,
        childAspectRatio: 0.67,
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
                  bottom: -6,
                  child: Center(child: _SignedBadge()),
                ),
              if (isSelectionMode)
                Positioned.fill(
                  child: Center(child: _SelectionBadge(isSelected: isSelected)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          document.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextTheme.logoLabelStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.blackTextColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _formatDate(document.createdAt),
          style: AppTextTheme.smallTextStyle.copyWith(fontSize: 12),
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
      width: 42,
      height: 42,
      useOwnLayer: true,
      shape: const LiquidRoundedRectangle(borderRadius: 20),
      settings: AppGlass.settings(
        refraction: 0,
        depth: 20,
        dispersion: 50,
        frost: 25,
        lightIntensity: 80,
        glassColor: AppColors.white.withValues(alpha: 0.75),
      ),
      child: Center(
        child: SvgPicture.asset(AppAssets.signedIcon, width: 24, height: 23),
      ),
    );
  }
}

class _SelectionBadge extends StatelessWidget {
  const _SelectionBadge({required this.isSelected});

  final bool isSelected;

  static const _fillDiameter = 36.0;
  static const _borderWidth = 3.0;
  static const _shadowColor = Color(0x99000000);
  static const _shadowBlur = 2.0;
  static const _shadowOffset = Offset(0, 1);

  @override
  Widget build(BuildContext context) {
    final badge = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      width: _fillDiameter + _borderWidth * 2,
      height: _fillDiameter + _borderWidth * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.selectionGreen : Colors.transparent,
        border: Border.all(color: AppColors.white, width: _borderWidth),
        // A BoxShadow is cast by the whole circle. That is right once the badge
        // is filled, but on an unselected one it would darken the transparent
        // middle — hence the ring-only painter below.
        boxShadow: isSelected
            ? const [
                BoxShadow(
                  color: _shadowColor,
                  blurRadius: _shadowBlur,
                  offset: _shadowOffset,
                ),
              ]
            : null,
      ),
      child: isSelected
          ? const Icon(
              CupertinoIcons.checkmark_alt,
              size: 26,
              color: AppColors.white,
            )
          : null,
    );

    if (isSelected) return badge;

    return CustomPaint(
      painter: const _RingShadowPainter(
        strokeWidth: _borderWidth,
        color: _shadowColor,
        blurRadius: _shadowBlur,
        offset: _shadowOffset,
      ),
      child: badge,
    );
  }
}

/// Casts the badge's drop shadow from the ring alone, so an unselected badge
/// reads against a white page without tinting its transparent middle.
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

    // The border sits inside the box, so the ring's centre line is half a
    // stroke in from the edge.
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

  static const _frontPageTilt = 3 * math.pi / 180;

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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 8,
          right: -8,
          top: -8,
          bottom: 8,
          child: _ThumbnailPage(child: _PreviewImage(path: lastPagePath)),
        ),
        Positioned.fill(
          child: Transform.rotate(
            angle: _frontPageTilt,
            child: _ThumbnailPage(
              elevated: true,
              child: _PreviewImage(path: firstPagePath),
            ),
          ),
        ),
      ],
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
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE3E3E6)),
        boxShadow: elevated
            ? const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 12,
                  offset: Offset(0, 6),
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
