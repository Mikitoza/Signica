import 'package:flutter/cupertino.dart';
import 'package:signica/presentation/const/colors.dart';

class AppTextTheme {
  const AppTextTheme._();

  static const _fontFamily = 'Inter';

  static const logoLabelStyle = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    fontSize: 18,
    height: 1.2,
    letterSpacing: 0,
  );

  static const segmentLabelStyle = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: -0.08,
  );

  static final smallTextStyle = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.placeholderText,
    fontSize: 15,
    height: 1.3,
    letterSpacing: 0,
  );

  static const actionTextStyle = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.actionBlackTextColor,
    fontSize: 12,
    height: 18 / 12,
    letterSpacing: 0,
  );

  static const selectAllStyle = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontSize: 14,
    height: 18 / 14,
  );

  static const menuTileStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 20 / 17,
    letterSpacing: -0.43,
    color: AppColors.black,
  );

  static final menuTileDestructiveStyle = menuTileStyle.copyWith(
    color: AppColors.actionRed,
  );

  static const emptyTitleStyle = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.greyTextColor,
    fontSize: 20,
    height: 1.2,
  );

  static const sourcePillStyle = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.blackTextColor,
    fontSize: 20,
    height: 1,
  );

  static final sheetSourcePillStyle = sourcePillStyle.copyWith(fontSize: 16);

  static const sheetTitleStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    height: 1.2,
  );

  static const addDocumentStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.greyTextColor,
    height: 1,
  );

  static const searchFieldStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    height: 1,
  );

  static final searchPlaceholderStyle = searchFieldStyle.copyWith(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.placeholderText,
  );

  static const documentTitleStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.blackTextColor,
    height: 1.2,
  );

  static final documentDateStyle = smallTextStyle.copyWith(fontSize: 12);
}
