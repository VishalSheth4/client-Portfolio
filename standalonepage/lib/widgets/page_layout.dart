import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';
import 'custom_bottom_nav.dart';
import 'scroll_indicator.dart';
import '../utils/responsive_helper.dart';
import 'loading_overlay.dart';

class PageLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;
  final String title;
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onServicesPressed;
  final VoidCallback? onClientsPressed;
  final VoidCallback? onContactPressed;

  const PageLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.title,
    this.onHomePressed,
    this.onAboutPressed,
    this.onServicesPressed,
    this.onClientsPressed,
    this.onContactPressed,
  });

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(
                        padding: ResponsiveHelper.getPadding(context),
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: ResponsiveHelper.isMobile(context) ? 80 : 100,
                          ),
                          child: widget.child,
                        ),
                      ),
                    ],
                  ),
                ),
                // Fixed Navigation Bar with Animation
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: _isScrolled ? Colors.white : Colors.transparent,
                    padding: EdgeInsets.symmetric(
                      vertical: _isScrolled ? 8 : 16,
                    ),
                    child: SafeArea(
                      child: CustomNavBar(
                        isScrolled: _isScrolled,
                        isMobile: ResponsiveHelper.isMobile(context),
                        selectedIndex: widget.selectedIndex,
                        onHomePressed: widget.onHomePressed ?? () {},
                        onAboutPressed: widget.onAboutPressed ?? () {},
                        onServicesPressed: widget.onServicesPressed ?? () {},
                        onClientsPressed: widget.onClientsPressed ?? () {},
                        onContactPressed: widget.onContactPressed ?? () {},
                      ),
                    ),
                  ),
                ),
                // Scroll Indicator
                if (!_isScrolled)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _isScrolled ? 0.0 : 1.0,
                        child: Column(
                          children: [
                            Text(
                              'Scroll Down',
                              style: TextStyle(
                                color: _isScrolled ? Colors.black : Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: _isScrolled ? Colors.black : Colors.white,
                              size: ResponsiveHelper.isMobile(context) ? 24 : 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            bottomNavigationBar: ResponsiveHelper.isMobile(context)
                ? CustomBottomNav(
                    selectedIndex: widget.selectedIndex,
                    onItemSelected: _handleNavigation,
                  )
                : null,
          ),
        );
      },
    );
  }

  void _handleNavigation(int index) async {
    if (index == widget.selectedIndex) return;

    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingOverlay(),
    );

    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Navigate to new page
    Navigator.of(context).pop(); // Remove loading overlay
    switch (index) {
      case 0:
        widget.onHomePressed?.call();
        break;
      case 1:
        widget.onAboutPressed?.call();
        break;
      case 2:
        widget.onServicesPressed?.call();
        break;
      case 3:
        widget.onClientsPressed?.call();
        break;
      case 4:
        widget.onContactPressed?.call();
        break;
    }
  }
} 