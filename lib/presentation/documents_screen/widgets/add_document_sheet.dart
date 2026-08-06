import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/assets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/glass.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';

Future<void> showAddDocumentSheet(
  BuildContext context, {
  required VoidCallback onPickFiles,
  required VoidCallback onPickPhotos,
  required VoidCallback onPickScanner,
}) {
  return Navigator.of(context, rootNavigator: true).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: null,
      transitionDuration: const Duration(milliseconds: 220),
      reverseTransitionDuration: const Duration(milliseconds: 160),
      pageBuilder: (routeContext, animation, _) => AddDocumentSheet(
        animation: animation,
        onPickFiles: onPickFiles,
        onPickPhotos: onPickPhotos,
        onPickScanner: onPickScanner,
      ),
    ),
  );
}

class AddDocumentSheet extends StatelessWidget {
  const AddDocumentSheet({
    super.key,
    required this.animation,
    required this.onPickFiles,
    required this.onPickPhotos,
    required this.onPickScanner,
  });

  final Animation<double> animation;
  final VoidCallback onPickFiles;
  final VoidCallback onPickPhotos;
  final VoidCallback onPickScanner;

  static const _headerHeight = 66.0;
  static const _boardRadius = 36.0;

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    final boardTop = MediaQuery.paddingOf(context).top + _headerHeight;

    void dismissThen(VoidCallback action) {
      Navigator.of(context).pop();
      action();
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: Stack(
        children: [
          Positioned(
            top: boardTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_boardRadius),
              child: AnimatedBuilder(
                animation: curved,
                builder: (context, _) => BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 20 * curved.value,
                    sigmaY: 20 * curved.value,
                  ),
                  child: ColoredBox(
                    color: AppColors.white.withValues(
                      alpha: 0.2 * curved.value,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0, 0.08),
                  end: Offset.zero,
                ).animate(curved),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 16, 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IntrinsicWidth(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _SourcePill(
                                  iconAsset: AppAssets.filesIcon,
                                  label: AppTranslationKeys.sourceFiles.tr(),
                                  onTap: () => dismissThen(onPickFiles),
                                ),
                                const SizedBox(height: 14),
                                _SourcePill(
                                  iconAsset: AppAssets.photoIcon,
                                  label: AppTranslationKeys.sourcePhotos.tr(),
                                  onTap: () => dismissThen(onPickPhotos),
                                ),
                                const SizedBox(height: 14),
                                _SourcePill(
                                  iconAsset: AppAssets.cameraIcon,
                                  label: AppTranslationKeys.sourceScanner.tr(),
                                  onTap: () => dismissThen(onPickScanner),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              AppTranslationKeys.documentsAddDocumentFrom.tr(),
                              textAlign: TextAlign.right,
                              style: AppTextTheme.logoLabelStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(width: 12),
                            GlassIconButton(
                              icon: const Icon(
                                CupertinoIcons.xmark,
                                color: AppColors.black,
                              ),
                              size: 62,
                              iconSize: 24,
                              useOwnLayer: true,
                              settings: AppGlass.settings(
                                glassColor: AppColors.white.withValues(
                                  alpha: 0.85,
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SourcePill extends StatelessWidget {
  const _SourcePill({
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
      height: 50,
      shape: const LiquidRoundedRectangle(borderRadius: 999),
      style: GlassButtonStyle.prominent,
      useOwnLayer: true,
      settings: AppGlass.settings(
        glassColor: AppColors.white.withValues(alpha: 0.85),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Image.asset(iconAsset, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextTheme.logoLabelStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.blackTextColor,
                fontSize: 16,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
