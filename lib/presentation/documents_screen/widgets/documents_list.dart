import 'dart:io';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/domain/entities/document_entity.dart';
import 'package:signica/presentation/const/assets.dart';
import 'package:signica/presentation/const/colors.dart';
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
    this.isImporting = false,
  });

  final int selectedFilter;
  final ValueChanged<int> onFilterSelected;
  final List<DocumentEntity> documents;
  final bool isImporting;
  final VoidCallback onPickFiles;
  final VoidCallback onPickScanner;
  final VoidCallback onPickPhotos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 66,
      ),
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
              child: documents.isEmpty
                  ? EmptyDocumentsState(
                      isImporting: isImporting,
                      onPickFiles: onPickFiles,
                      onPickScanner: onPickScanner,
                      onPickPhotos: onPickPhotos,
                    )
                  : DocumentsGrid(documents: documents),
            ),
          ],
        ),
      ),
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
        settings: LiquidGlassSettings.figma(
          refraction: 80,
          depth: 20,
          dispersion: 50,
          frost: 24,
          lightAngle: -45 * math.pi / 180,
          lightIntensity: 80,
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
  const DocumentsGrid({super.key, required this.documents});

  final List<DocumentEntity> documents;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 24,
        childAspectRatio: 0.67,
      ),
      itemCount: documents.length,
      itemBuilder: (context, index) =>
          _DocumentGridTile(document: documents[index]),
    );
  }
}

class _DocumentGridTile extends StatelessWidget {
  const _DocumentGridTile({required this.document});

  final DocumentEntity document;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _DocumentThumbnail(document: document)),
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

class _DocumentThumbnail extends StatelessWidget {
  const _DocumentThumbnail({required this.document});

  final DocumentEntity document;

  @override
  Widget build(BuildContext context) {
    final firstPagePath = document.firstPageImagePath;
    if (firstPagePath == null) {
      return const _ThumbnailPage(child: Icon(CupertinoIcons.doc_text));
    }

    final lastPagePath = document.lastPageImagePath;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (lastPagePath != null)
          Positioned(
            left: 8,
            right: -8,
            top: -8,
            bottom: 8,
            child: _ThumbnailPage(child: _PreviewImage(path: lastPagePath)),
          ),
        Positioned.fill(
          child: _ThumbnailPage(
            elevated: true,
            child: _PreviewImage(path: firstPagePath),
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
