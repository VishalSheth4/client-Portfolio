import 'package:flutter/material.dart';

class ScrollIndicator extends StatelessWidget {
  final bool isScrolled;
  final bool isMobile;

  const ScrollIndicator({
    super.key,
    required this.isScrolled,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isScrolled ? 0.0 : 1.0,
          child: Column(
            children: [
              const Text(
                'Scroll Down',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: isMobile ? 24 : 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 