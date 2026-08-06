import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class AppGaps {
  const AppGaps._();

  static const xxs = 2.0;
  static const xs = 4.0;
  static const s = 8.0;
  static const m = 12.0;
  static const l = 16.0;
  static const xl = 20.0;
  static const xxl = 26.0;
  static const xxxl = 36.0;

  static const gapXxs = SizedBox(height: xxs);
  static const gapXs = SizedBox(height: xs);
  static const gapS = SizedBox(height: s);
  static const gapM = SizedBox(height: m);
  static const gapL = SizedBox(height: l);
  static const gapXl = SizedBox(height: xl);

  static const hGapS = SizedBox(width: s);
  static const hGapM = SizedBox(width: m);
  static const hGapL = SizedBox(width: l);
}

class AppRadii {
  const AppRadii._();

  static const pill = 999.0;
  static const page = 10.0;
  static const control = 16.0;
  static const menuCard = 30.0;
  static const board = 36.0;
  static const signedBadge = 20.0;
}

class AppSizes {
  const AppSizes._();

  static const headerHeight = 66.0;
  static const headerButton = 38.0;

  static const barControl = 63.0;
  static const barControlIcon = 26.0;
  static const addDocumentHeight = 61.0;
  static const addDocumentIcon = 25.0;

  static const signedBadge = 42.0;
  static const signedIconWidth = 24.0;
  static const signedIconHeight = 23.0;

  static const selectionFill = 36.0;
  static const selectionBorder = 3.0;
  static const selectionCheck = 26.0;

  static const sourcePillHeight = 50.0;
  static const sourceIcon = 24.0;
  static const sheetSourceIcon = 30.0;

  static const menuIcon = 20.0;
  static const menuCardWidth = 220.0;
  static const contextMenuWidth = 264.0;
  static const contextActionIcon = 22.0;
  static const contextDeleteIcon = 21.0;

  static const dividerThickness = 1.0;

  static const filledCircleGlyph = 14.0;

  static const segmentControlHeight = 36.0;

  static const signedBadgeOverhang = -6.0;
}

class AppRatios {
  const AppRatios._();

  static const frontPageTilt = 3 * math.pi / 180;

  static const backPageOffset = 0.05;

  static const emptyIllustrationHeight = 0.42;

  static const contextMenuLift = 1.04;
}

class AppOpacities {
  const AppOpacities._();

  static const disabledPill = 0.5;
  static const disabledControl = 0.4;
}

class AppBlurs {
  const AppBlurs._();

  static const sheetBackdrop = 20.0;
  static const contextMenuBackdrop = 14.0;
}

class AppShadows {
  const AppShadows._();

  static const badgeBlur = 2.0;
  static const badgeOffset = Offset(0, 1);
  static const pageBlur = 12.0;
  static const pageOffset = Offset(0, 6);
}

class AppInsets {
  const AppInsets._();

  static const screenHorizontal = AppGaps.xl;

  static const bottomBar = EdgeInsets.fromLTRB(
    AppGaps.xl,
    AppGaps.m,
    AppGaps.xl,
    AppGaps.s,
  );
  static const header = EdgeInsets.symmetric(horizontal: AppGaps.l);
  static const segmentedControl = EdgeInsets.only(
    left: AppGaps.m,
    right: AppGaps.m,
    top: AppGaps.l,
    bottom: AppGaps.xl,
  );

  static const gridBottom = 100.0;
  static const grid = EdgeInsets.fromLTRB(
    AppGaps.xxxl,
    AppGaps.xs,
    AppGaps.xxxl,
    gridBottom,
  );

  static const menuHorizontal = 18.0;
  static const menuTile = EdgeInsets.symmetric(
    horizontal: menuHorizontal,
    vertical: 11,
  );
  static const menuDivider = EdgeInsets.symmetric(
    horizontal: menuHorizontal,
    vertical: AppGaps.xxs,
  );
  static const selectAllButton = EdgeInsets.symmetric(
    horizontal: menuHorizontal,
    vertical: 10,
  );
  static const addDocumentButton = EdgeInsets.symmetric(
    horizontal: AppGaps.xl,
    vertical: 14,
  );
  static const contextDivider = EdgeInsets.symmetric(horizontal: AppGaps.xxl);

  static const emptyStateTop = 46.0;

  static const overlayEdge = AppGaps.m;
}

class AppGrid {
  const AppGrid._();

  static const maxTileExtent = 190.0;
  static const crossSpacing = 32.0;
  static const mainSpacing = 40.0;
  static const tileAspectRatio = 0.67;
}

class AppDurations {
  const AppDurations._();

  static const badge = Duration(milliseconds: 150);
  static const menu = Duration(milliseconds: 160);
  static const contextMenuIn = Duration(milliseconds: 180);
  static const contextMenuOut = Duration(milliseconds: 140);
  static const sheetIn = Duration(milliseconds: 220);
  static const sheetOut = Duration(milliseconds: 160);
}
