import 'package:flutter/material.dart';
import 'dart:ui';
import 'contact_page.dart';
import 'about_page.dart';
import 'services_page.dart';
import 'theme/app_theme.dart';
import 'widgets/service_card.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/custom_bottom_nav.dart';
import 'clients_page.dart';
import 'utils/responsive_helper.dart';
import 'utils/constants.dart';
import 'widgets/loading_overlay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _isImageLoading = true;

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

  // Define professional color scheme
  static const Color primaryColor = Color(0xFF0066CC); // Electric blue
  static const Color accentColor = Color(0xFF00CCFF); // Light electric blue
  static const Color lightAccent = Color(0xFFFFFFFF);

  void _handleNavigation(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        }
        break;
      case 1: // About page - no loading effect
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AboutPage(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
        break;
      // Other cases with loading effect
      default:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const LoadingOverlay(),
        );

        Future.delayed(const Duration(seconds: 3), () {
          if (!mounted) return;
          Navigator.of(context).pop();

          switch (index) {
            case 2:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ServicesPage(),
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ClientsPage(),
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ContactPage(),
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
              break;
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    bool isTablet = MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Top Background Image with Overlay
                Container(
                  height:
                      ResponsiveHelper.getImageHeight(context, isHero: true),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(AppConstants.backgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      _buildHeroContent(isMobile),
                      // Scroll Indicator
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
                      ),
                    ],
                  ),
                ),
                // Content sections
                Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 32),
                  child: Column(
                    children: [
                      _buildAboutSection(isMobile),
                      const SizedBox(height: 32),
                      _buildServicesSection(isMobile),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Fixed Navigation Bar
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
                child: _buildNavBar(isMobile),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? CustomBottomNav(
              selectedIndex: _selectedIndex,
              onItemSelected: _handleNavigation,
            )
          : null,
    );
  }

  Widget _buildNavBar(bool isMobile) {
    return CustomNavBar(
      isScrolled: _isScrolled,
      isMobile: isMobile,
      selectedIndex: _selectedIndex,
      onHomePressed: () => _handleNavigation(0),
      onAboutPressed: () => _handleNavigation(1),
      onServicesPressed: () => _handleNavigation(2),
      onClientsPressed: () => _handleNavigation(3),
      onContactPressed: () => _handleNavigation(4),
    );
  }

  Widget _buildHeroContent(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppTheme.gradient.createShader(bounds),
            child: Text(
              'Welcome to GenZ',
              style: TextStyle(
                fontSize: isMobile ? 36 : 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Transforming Ideas into Digital Reality',
            style: TextStyle(
              fontSize: isMobile ? 18 : 24,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'We specialize in creating innovative digital solutions that help businesses thrive in the modern world.',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.white.withOpacity(0.8),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.secondaryColor.withOpacity(0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with gradient
          ShaderMask(
            shaderCallback: (bounds) => AppTheme.gradient.createShader(bounds),
            child: const Text(
              'About Us',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile)
                Expanded(
                  flex: 1,
                  child: Container(
                    height: ResponsiveHelper.getImageHeight(context),
                    width: ResponsiveHelper.getImageWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                      image: const DecorationImage(
                        image: NetworkImage(AppConstants.teamImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (!isMobile) const SizedBox(width: 40),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: AppTheme.gradient,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Professional Developer',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "I'm Temmy, a seasoned Graphic Designer and Web Developer",
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'With over 5 years of experience in creating beautiful and functional digital solutions.',
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        color: AppTheme.subtitleColor,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Skills section
                    Text(
                      'Skills',
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSkillBar('Software Development', 0.92),
                    const SizedBox(height: 16),
                    _buildSkillBar('Web Development', 0.90),
                    const SizedBox(height: 16),
                    _buildSkillBar('Data Security', 0.85),
                    const SizedBox(height: 16),
                    _buildSkillBar('Design', 0.95),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.gradient.createShader(bounds),
                child: const Text(
                  'My Services',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Specialized in bringing your ideas to life',
                style: AppTheme.subheadingStyle,
              ),
              const SizedBox(height: 48),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                ),
                child: Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: ResponsiveHelper.isMobile(context)
                          ? maxWidth * 0.9
                          : maxWidth * 0.3,
                      child: const ServiceCard(
                        title: 'Website Development',
                        icon: Icons.computer_rounded,
                        description:
                            'Bringing your online presence to life with our custom web development solutions.',
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveHelper.isMobile(context)
                          ? maxWidth * 0.9
                          : maxWidth * 0.3,
                      child: const ServiceCard(
                        title: 'Graphics Design',
                        icon: Icons.brush_rounded,
                        description:
                            'Designing visuals for websites, including banners, icons, and infographics.',
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveHelper.isMobile(context)
                          ? maxWidth * 0.9
                          : maxWidth * 0.3,
                      child: const ServiceCard(
                        title: 'Web Design',
                        icon: Icons.palette_rounded,
                        description:
                            'Creating engaging and intuitive websites that keep users coming back.',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkillBar(String skill, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill,
              style: const TextStyle(
                color: AppTheme.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  gradient: AppTheme.gradient,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.secondaryColor.withOpacity(0.3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildViewMoreButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0066CC),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: const Text('View More'),
    );
  }
}
