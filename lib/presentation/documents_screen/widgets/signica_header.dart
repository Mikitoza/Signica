import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/assets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/dimensions.dart';
import 'package:signica/presentation/const/glass.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';

class SignicaHeader extends StatefulWidget implements PreferredSizeWidget {
  const SignicaHeader({
    super.key,
    required this.onAddDocument,
    required this.onEnterSelectionMode,
    required this.onExitSelectionMode,
    required this.onToggleSelectAll,
    this.isSelectionMode = false,
    this.selectedCount = 0,
  });

  final VoidCallback onAddDocument;
  final VoidCallback onEnterSelectionMode;
  final VoidCallback onExitSelectionMode;
  final VoidCallback onToggleSelectAll;
  final bool isSelectionMode;
  final int selectedCount;

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.headerHeight);

  @override
  State<SignicaHeader> createState() => _SignicaHeaderState();
}

class _SignicaHeaderState extends State<SignicaHeader> {
  final LayerLink _menuLink = LayerLink();
  OverlayEntry? _menuEntry;

  void _toggleMenu() {
    if (_menuEntry != null) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => _HeaderMenuOverlay(
        layerLink: _menuLink,
        onDismissed: _closeMenu,
        onSelect: widget.onEnterSelectionMode,
        onAddDocument: widget.onAddDocument,
      ),
    );
    _menuEntry = entry;
    overlay.insert(entry);
  }

  void _closeMenu() {
    _menuEntry?.remove();
    _menuEntry = null;
  }

  @override
  void dispose() {
    _menuEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: AppSizes.headerHeight,
        child: Padding(
          padding: AppInsets.header,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: widget.isSelectionMode
                    ? _SelectAllButton(
                        selectedCount: widget.selectedCount,
                        onTap: widget.onToggleSelectAll,
                      )
                    : const _AppLogo(),
              ),
              AppGaps.hGapM,
              widget.isSelectionMode
                  ? GlassButton(
                      glowColor: AppColors.buttonGlow,
                      icon: const Icon(CupertinoIcons.xmark),
                      iconColor: AppColors.white,
                      iconSize: AppSizes.menuIcon,
                      width: AppSizes.headerButton,
                      height: AppSizes.headerButton,
                      shape: const LiquidRoundedRectangle(
                        borderRadius: AppRadii.pill,
                      ),
                      onTap: widget.onExitSelectionMode,
                    )
                  : CompositedTransformTarget(
                      link: _menuLink,
                      child: GlassButton(
                        glowColor: AppColors.buttonGlow,
                        icon: const Icon(CupertinoIcons.ellipsis),
                        iconColor: AppColors.white,
                        width: AppSizes.headerButton,
                        height: AppSizes.headerButton,
                        shape: const LiquidRoundedRectangle(
                          borderRadius: AppRadii.control,
                        ),
                        onTap: _toggleMenu,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppLogo extends StatelessWidget {
  const _AppLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppAssets.logo),
        AppGaps.hGapS,
        Flexible(
          child: Text(
            AppTranslationKeys.appName.tr(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextTheme.logoLabelStyle,
          ),
        ),
      ],
    );
  }
}

class _SelectAllButton extends StatelessWidget {
  const _SelectAllButton({required this.selectedCount, required this.onTap});

  final int selectedCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = selectedCount > 0
        ? AppTranslationKeys.selectionDeselectAll.tr(
            namedArgs: {'count': '$selectedCount'},
          )
        : AppTranslationKeys.selectionSelectAll.tr();

    return Align(
      alignment: Alignment.centerLeft,
      child: GlassButton.custom(
        onTap: onTap,
        label: label,
        glowColor: AppColors.buttonGlow,
        shape: const LiquidRoundedRectangle(borderRadius: AppRadii.pill),
        child: Padding(
          padding: AppInsets.selectAllButton,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextTheme.selectAllStyle,
          ),
        ),
      ),
    );
  }
}

class _HeaderMenuOverlay extends StatefulWidget {
  const _HeaderMenuOverlay({
    required this.layerLink,
    required this.onDismissed,
    required this.onSelect,
    required this.onAddDocument,
  });

  final LayerLink layerLink;
  final VoidCallback onDismissed;
  final VoidCallback onSelect;
  final VoidCallback onAddDocument;

  @override
  State<_HeaderMenuOverlay> createState() => _HeaderMenuOverlayState();
}

class _HeaderMenuOverlayState extends State<_HeaderMenuOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.menu,
  )..forward();

  Future<void> _dismiss() async {
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _dismiss,
          ),
        ),
        CompositedTransformFollower(
          link: widget.layerLink,
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          offset: const Offset(0, 4),
          child: FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween(begin: 0.9, end: 1.0).animate(curved),
              alignment: Alignment.topRight,
              child: _HeaderMenuCard(
                onSelect: () async {
                  await _dismiss();
                  widget.onSelect();
                },
                onAddDocument: () async {
                  await _dismiss();
                  widget.onAddDocument();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderMenuCard extends StatelessWidget {
  const _HeaderMenuCard({
    required this.onSelect,
    required this.onAddDocument,
  });

  final VoidCallback onSelect;
  final VoidCallback onAddDocument;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: AppSizes.menuCardWidth,
      allowElevation: true,
      useOwnLayer: true,
      settings: AppGlass.panel(
        glassColor: AppColors.menuCardGlass,
        whitenStrength: 0.2,
        shadowElevation: 1.5,
      ),
      shape: const LiquidRoundedRectangle(borderRadius: AppRadii.menuCard),
      padding: const EdgeInsets.symmetric(vertical: AppGaps.xxs),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _HeaderMenuTile(
              label: AppTranslationKeys.menuSelect.tr(),
              icon: const Icon(
                CupertinoIcons.checkmark_circle,
                size: AppSizes.menuIcon,
                color: AppColors.black,
              ),
              onTap: onSelect,
            ),
            _HeaderMenuTile(
              label: AppTranslationKeys.menuAddDocument.tr(),
              icon: const _FilledCircleIcon(icon: CupertinoIcons.add),
              onTap: onAddDocument,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderMenuTile extends StatelessWidget {
  const _HeaderMenuTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: AppInsets.menuTile,
        child: Row(
          children: [
            icon,
            AppGaps.hGapL,
            Expanded(
              child: Text(
                label,
                style:AppTextTheme.menuTileStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilledCircleIcon extends StatelessWidget {
  const _FilledCircleIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.menuIcon,
      height: AppSizes.menuIcon,
      decoration: const BoxDecoration(
        color: AppColors.black,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: AppSizes.filledCircleGlyph - 2,
        color: AppColors.white,
      ),
    );
  }
}
