import 'package:flutter/material.dart';
import 'app_theme.dart';

class PageStyles {
  static BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: AppTheme.primaryColor.withOpacity(0.2),
      width: 1.5,
    ),
    boxShadow: [
      BoxShadow(
        color: AppTheme.primaryColor.withOpacity(0.08),
        blurRadius: 20,
        spreadRadius: 5,
      ),
    ],
  );

  static EdgeInsets getResponsivePadding(bool isMobile, bool isTablet) {
    return EdgeInsets.all(isMobile ? 16 : isTablet ? 24 : 32);
  }

  static double getResponsiveFontSize(bool isMobile, bool isTablet, {bool isTitle = false}) {
    if (isTitle) {
      return isMobile ? 28 : isTablet ? 36 : 48;
    }
    return isMobile ? 16 : isTablet ? 18 : 20;
  }

  static Widget buildGradientTitle(String text, {double? fontSize}) {
    return ShaderMask(
      shaderCallback: (bounds) => AppTheme.gradient.createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
} 