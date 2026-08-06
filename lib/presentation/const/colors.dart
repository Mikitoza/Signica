import 'dart:ui';

class AppColors {
  const AppColors._();

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);

  static const backgroundColor = Color(0xFF242424);
  static const actionsBackgroundColor = Color(0xFFF5F5F5);
  static const scaffoldBackgroundColor = Color(0xFFF0F0F0);
  static const segmentBackgroundColor = Color(0xFF767680);

  static const greyTextColor = Color(0xFF303030);
  static const blackTextColor = Color(0xFF373737);
  static const actionBlackTextColor = Color(0xFF333333);

  static const accentGreen = Color(0xFF8FE637);
  static const selectionGreen = Color(0xFF6AD528);
  static const actionRed = Color(0xFFFF383C);

  static const pageBorder = Color(0xFFE3E3E6);

  static const pageShadow = Color(0x14000000);

  static const badgeShadow = Color(0x99000000);

  static final divider = black.withValues(alpha: 0.1);
  static final segmentBackground = segmentBackgroundColor.withValues(
    alpha: 0.12,
  );
  static final placeholderText = blackTextColor.withValues(alpha: 0.4);

  static final glassWhite = white.withValues(alpha: 0.85);
  static final glassWhiteSoft = white.withValues(alpha: 0.5);
  static final glassWhiteStrong = white.withValues(alpha: 0.94);
  static final signedBadgeGlass = white.withValues(alpha: 0.75);
  static final menuCardGlass = white.withValues(alpha: 0.75);
  static final addDocumentGlass = accentGreen.withValues(alpha: 0.95);
  static final buttonGlow = white.withValues(alpha: 0.1);

  static final sheetScrim = white.withValues(alpha: 0.2);
  static final contextMenuScrim = scaffoldBackgroundColor.withValues(
    alpha: 0.45,
  );
}
