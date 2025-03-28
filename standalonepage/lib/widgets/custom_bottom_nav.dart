import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemSelected,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            _buildNavItem(Icons.home_rounded, 'Home'),
            _buildNavItem(Icons.person_rounded, 'About'),
            _buildNavItem(Icons.design_services_rounded, 'Services'),
            _buildNavItem(Icons.groups_rounded, 'Clients'),
            _buildNavItem(Icons.mail_rounded, 'Contact Us'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: AppTheme.gradient,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      label: label == 'Contact' ? 'Contact Us' : label,
    );
  }

  List<BottomNavigationBarItem> get items => [
        _buildNavItem(Icons.home_rounded, 'Home'),
        _buildNavItem(Icons.person_rounded, 'About'),
        _buildNavItem(Icons.design_services_rounded, 'Services'),
        _buildNavItem(Icons.groups_rounded, 'Clients'),
        _buildNavItem(Icons.mail_rounded, 'Contact Us'),
      ];
}
