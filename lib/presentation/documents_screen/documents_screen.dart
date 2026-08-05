import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/documents_screen/widgets/documents_list.dart';
import 'package:signica/presentation/documents_screen/widgets/signica_header.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return  GlassScaffold(
        backgroundColor: AppColors.backgroundColor,
        extendBody: false,
        appBar: const SignicaHeader(),
        body:DocumentsList(
            documents: [],
            selectedFilter: _selectedFilter,
            onFilterSelected: (index) {
              setState(() => _selectedFilter = index);
            },
          ),
    );
  }
}
