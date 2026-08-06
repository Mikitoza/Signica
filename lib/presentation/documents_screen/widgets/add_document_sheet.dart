import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/assets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/dimensions.dart';
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
      transitionDuration: AppDurations.sheetIn,
      reverseTransitionDuration: AppDurations.sheetOut,
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

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    final boardTop = MediaQuery.paddingOf(context).top + AppSizes.headerHeight;

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
              borderRadius: BorderRadius.circular(AppRadii.board),
              child: AnimatedBuilder(
                animation: curved,
                builder: (context, _) => BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: AppBlurs.sheetBackdrop * curved.value,
                    sigmaY: AppBlurs.sheetBackdrop * curved.value,
                  ),
                  child: ColoredBox(
                    color: AppColors.sheetScrim.withValues(
                      alpha: AppColors.sheetScrim.a * curved.value,
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
                    padding: AppInsets.bottomBar,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IntrinsicWidth(
                          child: Padding(
                            padding: const EdgeInsets.only(right: AppGaps.m),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _SourcePill(
                                  iconAsset: AppAssets.filesIcon,
                                  label: AppTranslationKeys.sourceFiles.tr(),
                                  onTap: () => dismissThen(onPickFiles),
                                ),
                                AppGaps.gapM,
                                _SourcePill(
                                  iconAsset: AppAssets.photoIcon,
                                  label: AppTranslationKeys.sourcePhotos.tr(),
                                  onTap: () => dismissThen(onPickPhotos),
                                ),
                                AppGaps.gapM,
                                _SourcePill(
                                  iconAsset: AppAssets.cameraIcon,
                                  label: AppTranslationKeys.sourceScanner.tr(),
                                  onTap: () => dismissThen(onPickScanner),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppGaps.gapM,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                AppTranslationKeys.documentsAddDocumentFrom
                                    .tr(),
                                textAlign: TextAlign.right,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextTheme.sheetTitleStyle,
                              ),
                            ),
                            AppGaps.hGapM,
                            GlassIconButton(
                              icon: const Icon(
                                CupertinoIcons.xmark,
                                color: AppColors.black,
                              ),
                              size: AppSizes.barControl,
                              iconSize: AppSizes.sourceIcon,
                              useOwnLayer: true,
                              settings: AppGlass.settings(
                                glassColor: AppColors.glassWhite,
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
      height: AppSizes.sourcePillHeight,
      shape: const LiquidRoundedRectangle(borderRadius: AppRadii.pill),
      style: GlassButtonStyle.prominent,
      useOwnLayer: true,
      settings: AppGlass.settings(glassColor: AppColors.glassWhite),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppGaps.xl,
          vertical: AppGaps.l,
        ),
        child: Row(
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
                style: AppTextTheme.sheetSourcePillStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
