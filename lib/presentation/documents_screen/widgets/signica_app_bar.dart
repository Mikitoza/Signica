import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:signica/presentation/const/assets.dart';

class SignicaAppBar extends StatelessWidget {
  const SignicaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassAppBar(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      leading: Row(
        children: [
          SvgPicture.asset(AppAssets.logo),
          const SizedBox(width: 10),
          const Text(
            'Signica',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        GlassButton(
          glowColor: Colors.white.withValues(alpha: 0.1),
          icon: const Icon(Icons.more_horiz),
          iconColor: Colors.white,
          width: 38,
          height: 38,
          shape: LiquidRoundedRectangle(borderRadius: 16),
          onTap: () {},
        ),
      ],
    );
  }
}
