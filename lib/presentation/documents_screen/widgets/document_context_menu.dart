import 'dart:math' as math;
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/domain/entities/document_entity.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/dimensions.dart';
import 'package:signica/presentation/const/glass.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';
import 'package:signica/presentation/documents_screen/widgets/documents_list.dart';

Future<void> showDocumentContextMenu(
  BuildContext context, {
  required DocumentEntity document,
  required Rect anchor,
  required VoidCallback onPrint,
  required ValueChanged<Rect?> onShare,
  required VoidCallback onDelete,
}) {
  return Navigator.of(context, rootNavigator: true).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: null,
      fullscreenDialog: true,
      transitionDuration: AppDurations.contextMenuIn,
      reverseTransitionDuration: AppDurations.contextMenuOut,
      pageBuilder: (routeContext, animation, _) => _DocumentContextMenuLayer(
        document: document,
        anchor: anchor,
        animation: animation,
        onPrint: onPrint,
        onShare: onShare,
        onDelete: onDelete,
      ),
    ),
  );
}

class _DocumentContextMenuLayer extends StatelessWidget {
  const _DocumentContextMenuLayer({
    required this.document,
    required this.anchor,
    required this.animation,
    required this.onPrint,
    required this.onShare,
    required this.onDelete,
  });

  final DocumentEntity document;
  final Rect anchor;
  final Animation<double> animation;
  final VoidCallback onPrint;
  final ValueChanged<Rect?> onShare;
  final VoidCallback onDelete;

  static const _gap = AppGaps.m;

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    void dismissThen(VoidCallback action) {
      Navigator.of(context).pop();
      action();
    }

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: AnimatedBuilder(
              animation: curved,
              builder: (context, _) => BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: AppBlurs.contextMenuBackdrop * curved.value,
                  sigmaY: AppBlurs.contextMenuBackdrop * curved.value,
                ),
                child: ColoredBox(
                  color: AppColors.contextMenuScrim.withValues(
                    alpha: AppColors.contextMenuScrim.a * curved.value,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fromRect(
          rect: anchor,
          child: IgnorePointer(
            child: ScaleTransition(
              scale: Tween(
                begin: 1.0,
                end: AppRatios.contextMenuLift,
              ).animate(curved),
              child: DocumentTile(document: document),
            ),
          ),
        ),
        Positioned.fill(
          child: CustomSingleChildLayout(
            delegate: _MenuLayoutDelegate(anchor: anchor, gap: _gap),
            child: FadeTransition(
              opacity: curved,
              child: ScaleTransition(
                scale: Tween(begin: 0.92, end: 1.0).animate(curved),
                alignment: Alignment.topCenter,
                child: _ContextMenuCard(
                  // Never wider than the screen allows.
                  width: math.min(
                    AppSizes.contextMenuWidth,
                    MediaQuery.sizeOf(context).width -
                        AppInsets.screenHorizontal * 2,
                  ),
                  onPrint: () => dismissThen(onPrint),
                  onShare: (origin) => dismissThen(() => onShare(origin)),
                  onDelete: () => dismissThen(onDelete),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuLayoutDelegate extends SingleChildLayoutDelegate {
  const _MenuLayoutDelegate({required this.anchor, required this.gap});

  final Rect anchor;
  final double gap;

  static const _screenPadding = AppInsets.overlayEdge;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final belowTop = anchor.bottom + gap;
    final fitsBelow =
        belowTop + childSize.height <= size.height - _screenPadding;
    final top = fitsBelow
        ? belowTop
        : (anchor.top - gap - childSize.height).clamp(
            _screenPadding,
            size.height - _screenPadding - childSize.height,
          );

    final left = (anchor.center.dx - childSize.width / 2).clamp(
      _screenPadding,
      size.width - _screenPadding - childSize.width,
    );
    return Offset(left, top);
  }

  @override
  bool shouldRelayout(_MenuLayoutDelegate oldDelegate) =>
      oldDelegate.anchor != anchor || oldDelegate.gap != gap;
}

class _ContextMenuCard extends StatelessWidget {
  const _ContextMenuCard({
    required this.width,
    required this.onPrint,
    required this.onShare,
    required this.onDelete,
  });

  final double width;
  final VoidCallback onPrint;
  final ValueChanged<Rect?> onShare;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: width,
      allowElevation: true,
      useOwnLayer: true,
      settings: AppGlass.panel(
        glassColor: AppColors.glassWhiteStrong,
        shadowElevation: 1.5,
      ),
      shape: const LiquidRoundedRectangle(borderRadius: AppRadii.menuCard),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _StackedAction(
                    icon: CupertinoIcons.printer_fill,
                    label: AppTranslationKeys.actionPrint.tr(),
                    onTap: onPrint,
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (buttonContext) => _StackedAction(
                      icon: CupertinoIcons.share,
                      label: AppTranslationKeys.actionShare.tr(),
                      onTap: () => onShare(_globalRect(buttonContext)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: AppInsets.contextDivider,
            child: Container(
              height: AppSizes.dividerThickness,
              color: AppColors.divider,
            ),
          ),
          _DeleteAction(onTap: onDelete),
        ],
      ),
    );
  }

  Rect? _globalRect(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
  }
}

class _StackedAction extends StatelessWidget {
  const _StackedAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppGaps.s,
          AppGaps.xl,
          AppGaps.s,
          AppGaps.l,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSizes.contextActionIcon,
              color: AppColors.black,
            ),
            AppGaps.gapS,
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextTheme.actionTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteAction extends StatelessWidget {
  const _DeleteAction({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppGaps.xxl,
          AppGaps.l,
          AppGaps.xxl,
          AppGaps.xl,
        ),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.trash,
              size: AppSizes.contextDeleteIcon,
              color: AppColors.actionRed,
            ),
            AppGaps.hGapL,
            Flexible(
              child: Text(
                AppTranslationKeys.actionDelete.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextTheme.menuTileDestructiveStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
