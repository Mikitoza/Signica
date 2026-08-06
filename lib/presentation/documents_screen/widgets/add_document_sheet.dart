import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/assets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';

Future<void> showAddDocumentSheet(
  BuildContext context, {
  required VoidCallback onPickFiles,
  required VoidCallback onPickPhotos,
  required VoidCallback onPickScanner,
}) {
  return GlassModalSheet.show(
    context: context,
    detents: const {GlassSheetDetent.medium},
    initialState: GlassSheetState.half,
    halfSize: 330,
    showDragIndicator: true,
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
    builder: (sheetContext) => AddDocumentSheet(
      onPickFiles: () {
        Navigator.of(sheetContext).pop();
        onPickFiles();
      },
      onPickPhotos: () {
        Navigator.of(sheetContext).pop();
        onPickPhotos();
      },
      onPickScanner: () {
        Navigator.of(sheetContext).pop();
        onPickScanner();
      },
    ),
  );
}

class AddDocumentSheet extends StatelessWidget {
  const AddDocumentSheet({
    super.key,
    required this.onPickFiles,
    required this.onPickPhotos,
    required this.onPickScanner,
  });

  final VoidCallback onPickFiles;
  final VoidCallback onPickPhotos;
  final VoidCallback onPickScanner;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SourceRow(
          iconAsset: AppAssets.filesIcon,
          label: AppTranslationKeys.sourceFiles.tr(),
          onTap: onPickFiles,
        ),
        const SizedBox(height: 12),
        _SourceRow(
          iconAsset: AppAssets.photoIcon,
          label: AppTranslationKeys.sourcePhotos.tr(),
          onTap: onPickPhotos,
        ),
        const SizedBox(height: 12),
        _SourceRow(
          iconAsset: AppAssets.cameraIcon,
          label: AppTranslationKeys.sourceScanner.tr(),
          onTap: onPickScanner,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              AppTranslationKeys.documentsAddDocumentFrom.tr(),
              style: AppTextTheme.logoLabelStyle.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            const Spacer(),
            GlassIconButton(
              icon: const Icon(CupertinoIcons.xmark, color: AppColors.black),
              size: 36,
              iconSize: 16,
              useOwnLayer: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ],
    );
  }
}

class _SourceRow extends StatelessWidget {
  const _SourceRow({
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
      width: double.infinity,
      height: 56,
      shape: const LiquidRoundedRectangle(borderRadius: 28),
      style: GlassButtonStyle.prominent,
      useOwnLayer: true,
      settings: LiquidGlassSettings(
        glassColor: AppColors.white.withValues(alpha: 0.85),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Image.asset(iconAsset, width: 28, height: 28),
            const SizedBox(width: 14),
            Text(
              label,
              style: AppTextTheme.logoLabelStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.blackTextColor,
                fontSize: 17,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
