import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';

class DocumentsBottomBar extends StatelessWidget {
  const DocumentsBottomBar({
    super.key,
    required this.onSearch,
    required this.onAddDocument,
  });

  final VoidCallback onSearch;
  final VoidCallback onAddDocument;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Row(
          children: [
            GlassIconButton(
              icon: const Icon(CupertinoIcons.search, color: AppColors.white),
              size: 48,
              useOwnLayer: true,
              onPressed: onSearch,
              semanticLabel: AppTranslationKeys.documentsSearch.tr(),
            ),
            const Spacer(),
            _AddDocumentButton(onTap: onAddDocument),
          ],
        ),
      ),
    );
  }
}

class _AddDocumentButton extends StatelessWidget {
  const _AddDocumentButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassButton.custom(
      onTap: onTap,
      label: AppTranslationKeys.documentsAddDocument.tr(),
      shape: const LiquidRoundedRectangle(borderRadius: 999),
      style: GlassButtonStyle.prominent,
      useOwnLayer: true,
      settings: LiquidGlassSettings(
        glassColor: AppColors.accentGreen.withValues(alpha: 0.95),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.add,
                size: 14,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              AppTranslationKeys.documentsAddDocument.tr(),
              style: AppTextTheme.logoLabelStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
