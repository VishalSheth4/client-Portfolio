import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;
  static const double tvBreakpoint = 1920;

  static double getImageHeight(BuildContext context, {bool isHero = false}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (width > tvBreakpoint) { // TV
      return isHero ? height * 0.6 : height * 0.5;
    } else if (width > desktopBreakpoint) { // Large Desktop
      return isHero ? height * 0.5 : height * 0.4;
    } else if (width > tabletBreakpoint) { // Desktop
      return isHero ? 500 : 400;
    } else if (width > mobileBreakpoint) { // Tablet
      return isHero ? 400 : 350;
    } else { // Mobile
      return isHero ? 300 : 250;
    }
  }

  static double getImageWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    if (width > tvBreakpoint) { // TV
      return width * 0.5;
    } else if (width > desktopBreakpoint) { // Large Desktop
      return width * 0.4;
    } else if (width > tabletBreakpoint) { // Desktop
      return width * 0.35;
    } else if (width > mobileBreakpoint) { // Tablet
      return width * 0.45;
    } else { // Mobile
      return width * 0.9;
    }
  }

  static EdgeInsets getPadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    if (width > tvBreakpoint) {
      return const EdgeInsets.all(64);
    } else if (width > desktopBreakpoint) {
      return const EdgeInsets.all(48);
    } else if (width > tabletBreakpoint) {
      return const EdgeInsets.all(32);
    } else if (width > mobileBreakpoint) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(16);
    }
  }

  static double getFontSize(BuildContext context, {bool isTitle = false}) {
    double width = MediaQuery.of(context).size.width;
    
    if (width > tvBreakpoint) {
      return isTitle ? 64 : 24;
    } else if (width > desktopBreakpoint) {
      return isTitle ? 56 : 20;
    } else if (width > tabletBreakpoint) {
      return isTitle ? 48 : 18;
    } else if (width > mobileBreakpoint) {
      return isTitle ? 36 : 16;
    } else {
      return isTitle ? 28 : 14;
    }
  }

  static double getMaxWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    if (width > tvBreakpoint) {
      return 1800;
    } else if (width > desktopBreakpoint) {
      return 1440;
    } else if (width > tabletBreakpoint) {
      return 1200;
    } else if (width > mobileBreakpoint) {
      return 900;
    } else {
      return width;
    }
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletBreakpoint &&
      MediaQuery.of(context).size.width >= mobileBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  static bool isTV(BuildContext context) =>
      MediaQuery.of(context).size.width >= tvBreakpoint;
} 