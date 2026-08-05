import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/assets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';
import 'package:signica/presentation/documents_screen/models/document_item.dart';

class DocumentsList extends StatelessWidget {
  const DocumentsList({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    this.documents = const [],
  });

  final int selectedFilter;
  final ValueChanged<int> onFilterSelected;
  final List<DocumentItem> documents;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 20),
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

          Expanded(child: const EmptyDocumentsState()),
        ],
      ),
    );
  }
}

class EmptyDocumentsState extends StatelessWidget {
  const EmptyDocumentsState({super.key});

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
              onTap: () {},
            ),
            const SizedBox(width: 12),
            SourcePill(
              iconAsset: AppAssets.photoIcon,
              label: AppTranslationKeys.sourcePhotos.tr(),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        SourcePill(
          iconAsset: AppAssets.cameraIcon,
          label: AppTranslationKeys.sourceScanner.tr(),
          onTap: () {},
        ),
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
  });

  final String iconAsset;
  final String label;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
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
            Image.asset(iconAsset, width: 32, height: 32),
            const SizedBox(width: 12),
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
    );
  }
}
