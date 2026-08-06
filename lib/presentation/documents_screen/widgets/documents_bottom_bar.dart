import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/dimensions.dart';
import 'package:signica/presentation/const/glass.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';

LiquidGlassSettings _barGlass(Color glassColor) => AppGlass.settings(
  refraction: 29,
  depth: 17,
  dispersion: 50,
  frost: 10,
  lightIntensity: 80,
  glassColor: glassColor,
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
        padding: AppInsets.bottomBar,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _RoundGlassButton(
          icon: CupertinoIcons.search,
          semanticLabel: AppTranslationKeys.documentsSearch.tr(),
          onPressed: onSearchOpen,
        ),
        Flexible(child: _AddDocumentButton(onTap: onAddDocument)),
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
          AppGaps.hGapM,
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
    this.iconColor = AppColors.black,
    this.enabled = true,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback onPressed;
  final Color iconColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : AppOpacities.disabledControl,
      child: GlassIconButton(
        icon: Icon(icon, color: iconColor),
        size: AppSizes.barControl,
        iconSize: AppSizes.barControlIcon,
        useOwnLayer: true,
        settings: _barGlass(AppColors.glassWhiteSoft),
        onPressed: enabled ? onPressed : null,
        semanticLabel: semanticLabel,
      ),
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
      shape: const LiquidRoundedRectangle(borderRadius: AppRadii.pill),
      settings: _barGlass(AppColors.glassWhiteSoft),
      padding: const EdgeInsets.symmetric(horizontal: AppGaps.m),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.search,
            size: AppSizes.sourceIcon,
            color: AppColors.black,
          ),
          AppGaps.hGapM,
          Expanded(
            child: CupertinoTextField(
              controller: _controller,
              onChanged: widget.onChanged,
              autofocus: true,
              placeholder: AppTranslationKeys.documentsSearchPlaceholder.tr(),
              placeholderStyle: AppTextTheme.searchPlaceholderStyle,
              style: AppTextTheme.searchFieldStyle,
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
        _RoundGlassButton(
          icon: CupertinoIcons.delete,
          iconColor: AppColors.actionRed,
          enabled: enabled,
          onPressed: onDelete,
          semanticLabel: AppTranslationKeys.selectionDelete.tr(),
        ),
        const Spacer(),
        Builder(
          builder: (buttonContext) => _RoundGlassButton(
            icon: CupertinoIcons.share,
            iconColor: AppColors.blackTextColor,
            enabled: enabled,
            onPressed: () => onShare(_originOf(buttonContext)),
            semanticLabel: AppTranslationKeys.selectionShare.tr(),
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
      height: AppSizes.addDocumentHeight,
      shape: const LiquidRoundedRectangle(borderRadius: AppRadii.pill),
      style: GlassButtonStyle.prominent,
      useOwnLayer: true,
      settings: _barGlass(AppColors.addDocumentGlass),
      child: Padding(
        padding: AppInsets.addDocumentButton,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSizes.addDocumentIcon,
              height: AppSizes.addDocumentIcon,
              decoration: const BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.add,
                size: AppSizes.filledCircleGlyph,
                color: AppColors.white,
              ),
            ),
            AppGaps.hGapS,
            Flexible(
              child: Text(
                AppTranslationKeys.documentsAddDocument.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextTheme.addDocumentStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
