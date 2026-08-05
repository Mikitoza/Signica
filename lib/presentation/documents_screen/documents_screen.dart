import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/colors.dart';
import 'package:signica/presentation/documents_screen/widgets/signica_app_bar.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  int _selectedFilter = 0;

  static const _cardBackground = Color(0xFFF3F3F4);
  static const _accentGreen = Color(0xFF8FE637);

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      enableBackgroundSampling:true,
      extendBody: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: SignicaAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
              child: _DocumentsCard(
                cardBackground: _cardBackground,
                selectedFilter: _selectedFilter,
                onFilterSelected: (index) =>
                    setState(() => _selectedFilter = index),
              ),
            ),
          ),
          _BottomActionBar(accentGreen: _accentGreen),
        ],
      ),
    );
  }
}

class _DocumentsCard extends StatelessWidget {
  const _DocumentsCard({
    required this.cardBackground,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final Color cardBackground;
  final int selectedFilter;
  final ValueChanged<int> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Center(
              child: SizedBox(
                width: 260,
                child: GlassSegmentedControl(
                  segments: const [
                    GlassSegment(label: 'All'),
                    GlassSegment(label: 'Signed'),
                    GlassSegment(label: 'Unsigned'),
                  ],
                  selectedIndex: selectedFilter,
                  onSegmentSelected: onFilterSelected,
                  height: 36,
                  useOwnLayer: true,
                  selectedTextStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  unselectedTextStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withValues(alpha: 0.55),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _DocumentIllustration(),
                    const SizedBox(height: 28),
                    const Text(
                      'No Documents Yet',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'You can add documents from',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withValues(alpha: 0.45),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ActionPill(
                          icon: CupertinoIcons.folder_fill,
                          iconColor: const Color(0xFF3E82F7),
                          label: 'Files',
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _ActionPill(
                          icon: CupertinoIcons.photo_fill,
                          iconColor: const Color(0xFFE0459A),
                          label: 'Photos',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _ActionPill(
                      icon: CupertinoIcons.camera_fill,
                      iconColor: Colors.black87,
                      label: 'Scanner',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentIllustration extends StatelessWidget {
  const _DocumentIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 190,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 130,
            height: 170,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE3E3E6)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 6,
                  width: 70,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3C),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                for (final w in const [90.0, 80.0, 95.0, 60.0])
                  Container(
                    height: 4,
                    width: w,
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                const Spacer(),
                Icon(
                  CupertinoIcons.scribble,
                  size: 28,
                  color: Colors.black.withValues(alpha: 0.8),
                ),
                const SizedBox(height: 4),
                Container(height: 2, width: 60, color: const Color(0xFF8FE637)),
              ],
            ),
          ),
          Positioned(
            right: -12,
            top: 30,
            child: Transform.rotate(
              angle: -0.7,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  CupertinoIcons.pencil,
                  size: 22,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({required this.accentGreen});

  final Color accentGreen;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Row(
          children: [
            GlassIconButton(
              icon: const Icon(CupertinoIcons.search, color: Colors.white),
              size: 48,
              useOwnLayer: true,
              onPressed: () {},
              semanticLabel: 'Search',
            ),
            const Spacer(),
            Material(
              color: accentGreen,
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.add, size: 20, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'Add Document',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
