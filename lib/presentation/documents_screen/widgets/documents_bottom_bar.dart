import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/glass.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';

const double _controlSize = 48;

LiquidGlassSettings _lightGlass() => AppGlass.settings(
  refraction: 29,
  depth: 17,
  dispersion: 50,
  frost: 10,
  lightIntensity: 80,
  glassColor: AppColors.white.withValues(alpha: 0.5),
);

class DocumentsBottomBar extends StatelessWidget {
  const DocumentsBottomBar({
    super.key,
    required this.onSearchOpen,
    required this.onSearchClose,
    required this.onSearchQueryChanged,
    required this.onAddDocument,
    required this.onDeleteSelected,
    required this.onShareSelected,
    this.isSelectionMode = false,
    this.hasSelection = false,
    this.isSearching = false,
  });

  final VoidCallback onSearchOpen;
  final VoidCallback onSearchClose;
  final ValueChanged<String> onSearchQueryChanged;
  final VoidCallback onAddDocument;
  final VoidCallback onDeleteSelected;
  final ValueChanged<Rect?> onShareSelected;
  final bool isSelectionMode;
  final bool hasSelection;
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: switch ((isSelectionMode, isSearching)) {
          (true, _) => _SelectionActions(
            enabled: hasSelection,
            onDelete: onDeleteSelected,
            onShare: onShareSelected,
          ),
          (false, true) => _SearchActions(
            onQueryChanged: onSearchQueryChanged,
            onClose: onSearchClose,
          ),
          (false, false) => _BrowseActions(
            onSearchOpen: onSearchOpen,
            onAddDocument: onAddDocument,
          ),
        },
      ),
    );
  }
}

class _BrowseActions extends StatelessWidget {
  const _BrowseActions({
    required this.onSearchOpen,
    required this.onAddDocument,
  });

  final VoidCallback onSearchOpen;
  final VoidCallback onAddDocument;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _RoundGlassButton(
          icon: CupertinoIcons.search,
          semanticLabel: AppTranslationKeys.documentsSearch.tr(),
          onPressed: onSearchOpen,
        ),
        const Spacer(),
        _AddDocumentButton(onTap: onAddDocument),
      ],
    );
  }
}

class _SearchActions extends StatelessWidget {
  const _SearchActions({required this.onQueryChanged, required this.onClose});

  final ValueChanged<String> onQueryChanged;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _SearchField(onChanged: onQueryChanged)),
          const SizedBox(width: 12),
          _RoundGlassButton(
            icon: CupertinoIcons.xmark,
            semanticLabel: AppTranslationKeys.cancel.tr(),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

class _RoundGlassButton extends StatelessWidget {
  const _RoundGlassButton({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GlassIconButton(
      icon: Icon(icon, color: AppColors.black),
      size: _controlSize,
      iconSize: 26,
      useOwnLayer: true,
      settings: _lightGlass(),
      onPressed: onPressed,
      semanticLabel: semanticLabel,
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      useOwnLayer: true,
      shape: const LiquidRoundedRectangle(borderRadius: 999),
      settings: _lightGlass(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(CupertinoIcons.search, size: 24, color: AppColors.black),
          const SizedBox(width: 12),
          Expanded(
            child: CupertinoTextField(
              controller: _controller,
              onChanged: widget.onChanged,
              autofocus: true,
              placeholder: AppTranslationKeys.documentsSearchPlaceholder.tr(),
              placeholderStyle: AppTextTheme.logoLabelStyle.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: AppColors.blackTextColor.withValues(alpha: 0.4),
                height: 1,
              ),
              style: AppTextTheme.logoLabelStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                height: 1,
              ),
              cursorColor: AppColors.accentGreen,
              decoration: const BoxDecoration(),
              padding: EdgeInsets.zero,
              textInputAction: TextInputAction.search,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionActions extends StatelessWidget {
  const _SelectionActions({
    required this.enabled,
    required this.onDelete,
    required this.onShare,
  });

  final bool enabled;
  final VoidCallback onDelete;
  final ValueChanged<Rect?> onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Opacity(
          opacity: enabled ? 1 : 0.4,
          child: GlassIconButton(
            icon: const Icon(
              CupertinoIcons.delete,
              color: CupertinoColors.destructiveRed,
            ),
            size: _controlSize,
            iconSize: 26,
            useOwnLayer: true,
            settings: _lightGlass(),
            onPressed: enabled ? onDelete : null,
            semanticLabel: AppTranslationKeys.selectionDelete.tr(),
          ),
        ),
        const Spacer(),
        Opacity(
          opacity: enabled ? 1 : 0.4,
          child: Builder(
            builder: (buttonContext) => GlassIconButton(
              icon: const Icon(
                CupertinoIcons.share,
                color: AppColors.blackTextColor,
              ),
              size: _controlSize,
              iconSize: 26,
              useOwnLayer: true,
              settings: _lightGlass(),
              onPressed: enabled
                  ? () => onShare(_originOf(buttonContext))
                  : null,
              semanticLabel: AppTranslationKeys.selectionShare.tr(),
            ),
          ),
        ),
      ],
    );
  }

  Rect? _originOf(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
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
      height: 61,
      shape: const LiquidRoundedRectangle(borderRadius: 999),
      style: GlassButtonStyle.prominent,
      useOwnLayer: true,
      settings: AppGlass.settings(
        refraction: 29,
        depth: 17,
        dispersion: 50,
        frost: 10,
        lightIntensity: 80,
        glassColor: AppColors.accentGreen.withValues(alpha: 0.95),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 25,
              height: 25,
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
            const SizedBox(width: 8),
            Text(
              AppTranslationKeys.documentsAddDocument.tr(),
              style: AppTextTheme.logoLabelStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.greyTextColor,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
