import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/const/text_theme.dart';
import 'package:signica/presentation/const/translation_keys.dart';
import 'package:signica/presentation/documents_screen/bloc/documents_bloc.dart';
import 'package:signica/presentation/documents_screen/bloc/documents_state.dart';
import 'package:signica/presentation/documents_screen/widgets/documents_list.dart';

Future<void> showSearchDocumentsSheet(
  BuildContext context, {
  required DocumentsBloc bloc,
}) {
  return GlassModalSheet.show(
    context: context,
    detents: const {GlassSheetDetent.large},
    initialState: GlassSheetState.full,
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
    builder: (sheetContext) =>
        BlocProvider.value(value: bloc, child: const SearchDocumentsSheet()),
  );
}

class SearchDocumentsSheet extends StatefulWidget {
  const SearchDocumentsSheet({super.key});

  @override
  State<SearchDocumentsSheet> createState() => _SearchDocumentsSheetState();
}

class _SearchDocumentsSheetState extends State<SearchDocumentsSheet> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SearchField(
                controller: _controller,
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            const SizedBox(width: 12),
            GlassIconButton(
              icon: const Icon(CupertinoIcons.xmark, color: AppColors.black),
              size: 40,
              iconSize: 18,
              useOwnLayer: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: BlocBuilder<DocumentsBloc, DocumentsState>(
            builder: (context, state) {
              final query = _query.trim().toLowerCase();
              final results = query.isEmpty
                  ? state.documents
                  : state.documents
                        .where(
                          (document) =>
                              document.title.toLowerCase().contains(query),
                        )
                        .toList();

              if (results.isEmpty) {
                return Center(
                  child: Text(
                    AppTranslationKeys.documentsNoResults.tr(),
                    style: AppTextTheme.smallTextStyle,
                  ),
                );
              }
              return DocumentsGrid(documents: results);
            },
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.search,
            size: 18,
            color: AppColors.blackTextColor.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              onChanged: onChanged,
              autofocus: true,
              placeholder: AppTranslationKeys.documentsSearchPlaceholder.tr(),
              placeholderStyle: AppTextTheme.smallTextStyle.copyWith(
                fontSize: 16,
              ),
              style: AppTextTheme.logoLabelStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              decoration: const BoxDecoration(),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
