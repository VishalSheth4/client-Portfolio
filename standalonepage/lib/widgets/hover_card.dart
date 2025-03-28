import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final double width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const HoverCard({
    super.key,
    required this.child,
    required this.width,
    this.padding,
    this.borderRadius,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          border: Border.all(
            color: isHovered 
                ? AppTheme.primaryColor.withOpacity(0.3)
                : Colors.grey.shade200,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? AppTheme.primaryColor.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isHovered ? 20 : 10,
              spreadRadius: isHovered ? 5 : 2,
              offset: Offset(0, isHovered ? 10 : 5),
            ),
          ],
        ),
        transform: Matrix4.identity()..translate(0, isHovered ? -5 : 0),
        child: widget.child,
      ),
    );
  }
} 