import 'package:flutter/cupertino.dart';
import 'package:signica/presentation/const/colors.dart';

class AppTextTheme {
  static final logoLabelStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    fontSize: 18,
    height: 1.2,
    letterSpacing: 0,
  );

  static final segmentLabelStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    fontSize: 14,
    height: 18/14,
    letterSpacing: -0.08,
  );

  static final smallTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    color: AppColors.blackTextColor.withValues(alpha: 0.4),
    fontSize: 15,
    height: 1.3,
    letterSpacing: 0,
  );

}
