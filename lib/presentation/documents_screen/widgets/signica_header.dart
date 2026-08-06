import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/assets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/glass.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';

class SignicaHeader extends StatefulWidget implements PreferredSizeWidget {
  const SignicaHeader({
    super.key,
    required this.onAddDocument,
    required this.onClearAll,
    required this.onEnterSelectionMode,
    required this.onExitSelectionMode,
    required this.onToggleSelectAll,
    this.isSelectionMode = false,
    this.selectedCount = 0,
  });

  final VoidCallback onAddDocument;
  final VoidCallback onClearAll;
  final VoidCallback onEnterSelectionMode;
  final VoidCallback onExitSelectionMode;
  final VoidCallback onToggleSelectAll;
  final bool isSelectionMode;
  final int selectedCount;

  @override
  Size get preferredSize => const Size.fromHeight(66);

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
        onClearAll: widget.onClearAll,
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
        height: 66,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
              const SizedBox(width: 12),
              widget.isSelectionMode
                  ? GlassButton(
                      glowColor: AppColors.white.withValues(alpha: 0.1),
                      icon: const Icon(CupertinoIcons.xmark),
                      iconColor: Colors.white,
                      iconSize: 20,
                      width: 38,
                      height: 38,
                      shape: LiquidRoundedRectangle(borderRadius: 19),
                      onTap: widget.onExitSelectionMode,
                    )
                  : CompositedTransformTarget(
                      link: _menuLink,
                      child: GlassButton(
                        glowColor: AppColors.white.withValues(alpha: 0.1),
                        icon: const Icon(Icons.more_horiz),
                        iconColor: Colors.white,
                        width: 38,
                        height: 38,
                        shape: LiquidRoundedRectangle(borderRadius: 16),
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
        const SizedBox(width: 10),
        Text(
          AppTranslationKeys.appName.tr(),
          style: AppTextTheme.logoLabelStyle,
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
        glowColor: AppColors.white.withValues(alpha: 0.1),
        shape: const LiquidRoundedRectangle(borderRadius: 999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextTheme.logoLabelStyle.copyWith(
              fontSize: 14,
              height: 18 / 14,
              fontWeight: FontWeight.w700,
            ),
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
    required this.onClearAll,
  });

  final LayerLink layerLink;
  final VoidCallback onDismissed;
  final VoidCallback onSelect;
  final VoidCallback onAddDocument;
  final VoidCallback onClearAll;

  @override
  State<_HeaderMenuOverlay> createState() => _HeaderMenuOverlayState();
}

class _HeaderMenuOverlayState extends State<_HeaderMenuOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 160),
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
                onClearAll: () async {
                  await _dismiss();
                  widget.onClearAll();
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
    required this.onClearAll,
  });

  final VoidCallback onSelect;
  final VoidCallback onAddDocument;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: 220,
      allowElevation: true,
      useOwnLayer: true,
      settings: AppGlass.settings(
        glassColor: Colors.white.withValues(alpha: 0.75),
        frost: 16,
        whitenStrength: 0.2,
        shadowElevation: 3,
      ),
      shape: LiquidRoundedRectangle(borderRadius: 30),
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _HeaderMenuTile(
              label: AppTranslationKeys.menuSelect.tr(),
              icon: const Icon(
                CupertinoIcons.checkmark_circle,
                size: 20,
                color: Colors.black,
              ),
              onTap: onSelect,
            ),
            _HeaderMenuTile(
              label: AppTranslationKeys.menuAddDocument.tr(),
              icon: const _FilledCircleIcon(icon: CupertinoIcons.add),
              onTap: onAddDocument,
            ),
            const _HeaderMenuDivider(),
            _HeaderMenuTile(
              label: AppTranslationKeys.menuClearAll.tr(),
              icon: const Icon(
                CupertinoIcons.trash,
                size: 20,
                color: CupertinoColors.destructiveRed,
              ),
              isDestructive: true,
              onTap: onClearAll,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderMenuDivider extends StatelessWidget {
  const _HeaderMenuDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
      child: Container(height: 1, color: Colors.black.withValues(alpha: 0.08)),
    );
  }
}

class _HeaderMenuTile extends StatelessWidget {
  const _HeaderMenuTile({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  height: 20 / 17,
                  letterSpacing: -0.43,
                  color: isDestructive
                      ? CupertinoColors.destructiveRed
                      : Colors.black,
                ),
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
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 12, color: Colors.white),
    );
  }
}
