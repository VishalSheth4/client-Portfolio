import 'package:flutter/material.dart';
import 'dart:ui';
import '../theme/app_theme.dart';

class CustomNavBar extends StatelessWidget {
  final bool isScrolled;
  final bool isMobile;
  final VoidCallback onHomePressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onServicesPressed;
  final VoidCallback onClientsPressed;
  final VoidCallback onContactPressed;
  final int selectedIndex;

  const CustomNavBar({
    super.key,
    required this.isScrolled,
    required this.isMobile,
    required this.onHomePressed,
    required this.onAboutPressed,
    required this.onServicesPressed,
    required this.onClientsPressed,
    required this.onContactPressed,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth >= 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 12 : isDesktop ? 20 : 16,
      ),
      decoration: BoxDecoration(
        color: isScrolled 
            ? Colors.white.withOpacity(0.95) 
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(isScrolled ? 0 : 30),
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isScrolled ? 0 : 30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(isDesktop),
              const Spacer(),
              if (!isMobile) ...[
                _buildNavButtons(),
                const SizedBox(width: 24),
                _buildContactButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isDesktop) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onHomePressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: AppTheme.gradient,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            'GenZ',
            style: TextStyle(
              fontSize: isDesktop ? 32 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildNavButton('Home', onHomePressed, 0),
          _buildNavButton('About', onAboutPressed, 1),
          _buildNavButton('Services', onServicesPressed, 2),
          _buildNavButton('Clients', onClientsPressed, 3),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text, VoidCallback onPressed, int index) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppTheme.primaryColor.withOpacity(0.1)
                    : isHovered
                        ? Colors.grey.withOpacity(0.1)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: selectedIndex == index || isHovered
                      ? FontWeight.bold
                      : FontWeight.w500,
                  color: selectedIndex == index
                      ? AppTheme.primaryColor
                      : AppTheme.textColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactButton() {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onContactPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: AppTheme.gradient,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(isHovered ? 0.3 : 0.2),
                    blurRadius: isHovered ? 20 : 15,
                    spreadRadius: isHovered ? 2 : 1,
                  ),
                ],
              ),
              transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.mail_outline_rounded,
                    color: Colors.white,
                    size: isHovered ? 20 : 18,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
