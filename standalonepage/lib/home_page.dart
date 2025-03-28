import 'package:flutter/material.dart';
import 'main.dart';
import 'about_page.dart';
import 'contact_page.dart';
import 'services_page.dart';
import 'clients_page.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/custom_bottom_nav.dart';
import 'theme/app_theme.dart';
import 'theme/page_styles.dart';
import 'widgets/scroll_indicator.dart';
import 'widgets/hover_card.dart';
import 'utils/responsive_helper.dart';
import 'utils/constants.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isScrolled = false;
  final ScrollController _scrollController = ScrollController();

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

  Widget _buildHeroSection(BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      height: ResponsiveHelper.getImageHeight(context, isHero: true),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage(AppConstants.backgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          // Animated particles background
          Positioned.fill(
            child: CustomPaint(
              painter: ParticlePainter(),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedTitle('Welcome to GenZ', isMobile, isTablet),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor.withOpacity(0.2),
                        AppTheme.secondaryColor.withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Building Digital Solutions for Tomorrow',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : isTablet ? 20 : 24,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                _buildHeroButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTitle(String text, bool isMobile, bool isTablet) {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 1),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: PageStyles.buildGradientTitle(
              text,
              fontSize: isMobile ? 36 : isTablet ? 48 : 56,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeroButton(
          context,
          'Get Started',
          Icons.rocket_launch_rounded,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactPage()),
          ),
        ),
        const SizedBox(width: 16),
        _buildHeroButton(
          context,
          'Our Services',
          Icons.design_services_rounded,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ServicesPage()),
          ),
          isSecondary: true,
        ),
      ],
    );
  }

  Widget _buildHeroButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onTap, {
    bool isSecondary = false,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: isSecondary ? null : AppTheme.gradient,
                color: isSecondary ? Colors.white : null,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: (isSecondary ? Colors.black : AppTheme.primaryColor)
                        .withOpacity(isHovered ? 0.3 : 0.2),
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
                    icon,
                    color: isSecondary ? AppTheme.primaryColor : Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSecondary ? AppTheme.primaryColor : Colors.white,
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

  Widget _buildServicesSection(BuildContext context, bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.08),
            AppTheme.secondaryColor.withOpacity(0.08),
          ],
          stops: const [0.1, 0.9],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative elements
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppTheme.gradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.design_services_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            child: Column(
              children: [
                PageStyles.buildGradientTitle(
                  'Our Services',
                  fontSize: isMobile ? 32 : 42,
                ),
                const SizedBox(height: 16),
                Text(
                  'Comprehensive solutions for your digital needs',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: AppTheme.textColor.withOpacity(0.8),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                _buildServicesGrid(isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(bool isMobile) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        _buildServiceCard(
          'Web Development',
          'Custom websites and web applications',
          Icons.web_rounded,
          isMobile,
        ),
        _buildServiceCard(
          'Mobile Apps',
          'Native and cross-platform solutions',
          Icons.phone_iphone_rounded,
          isMobile,
        ),
        _buildServiceCard(
          'Cloud Services',
          'Scalable cloud infrastructure',
          Icons.cloud_rounded,
          isMobile,
        ),
      ],
    );
  }

  Widget _buildServiceCard(
      String title, String description, IconData icon, bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 280,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.gradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Add this new method for the skills section
  Widget _buildSkillsSection(bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.08),
            AppTheme.secondaryColor.withOpacity(0.08),
          ],
          stops: const [0.1, 0.9],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative elements
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppTheme.gradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.code_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            child: Column(
              children: [
                PageStyles.buildGradientTitle(
                  'Our Expertise',
                  fontSize: isMobile ? 32 : 42,
                ),
                const SizedBox(height: 16),
                Text(
                  'Delivering excellence across multiple domains',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: AppTheme.textColor.withOpacity(0.8),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                _buildSkillsGrid(isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid(bool isMobile) {
    final List<Map<String, dynamic>> skills = [
      {
        'name': 'Web Development',
        'icon': Icons.web_rounded,
        'description': 'Modern and responsive web applications',
        'technologies': ['React', 'Angular', 'Vue.js'],
      },
      {
        'name': 'Mobile Apps',
        'icon': Icons.phone_iphone_rounded,
        'description': 'Native and cross-platform mobile solutions',
        'technologies': ['Flutter', 'React Native', 'iOS'],
      },
      {
        'name': 'Cloud Services',
        'icon': Icons.cloud_rounded,
        'description': 'Scalable cloud infrastructure and solutions',
        'technologies': ['AWS', 'Azure', 'GCP'],
      },
      {
        'name': 'UI/UX Design',
        'icon': Icons.design_services_rounded,
        'description': 'User-centered design solutions',
        'technologies': ['Figma', 'Adobe XD', 'Sketch'],
      },
    ];

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: skills.map((skill) => _buildSkillCard(skill, isMobile)).toList(),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill, bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 280,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppTheme.gradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(skill['icon'], color: Colors.white, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            skill['name'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            skill['description'],
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (skill['technologies'] as List<String>).map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tech,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.primaryColor.withOpacity(0.8),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context, bool isMobile) {
    final List<Map<String, dynamic>> projects = [
      {
        'title': 'E-commerce Platform',
        'description': 'Modern online shopping solution with AI-powered recommendations',
        'icon': Icons.shopping_cart_rounded,
        'stats': ['500K+ Users', '99.9% Uptime', '2M+ Orders'],
      },
      {
        'title': 'Healthcare App',
        'description': 'Integrated patient management system with telemedicine support',
        'icon': Icons.health_and_safety_rounded,
        'stats': ['100K+ Patients', '24/7 Support', '50+ Hospitals'],
      },
      {
        'title': 'Finance Dashboard',
        'description': 'Real-time data visualization and analytics platform',
        'icon': Icons.analytics_rounded,
        'stats': ['1B+ Transactions', 'Real-time Data', '99% Accuracy'],
      },
    ];

    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.08),
            AppTheme.secondaryColor.withOpacity(0.08),
          ],
          stops: const [0.1, 0.9],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppTheme.gradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.rocket_launch_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            child: Column(
              children: [
                PageStyles.buildGradientTitle(
                  'Recent Projects',
                  fontSize: isMobile ? 32 : 42,
                ),
                const SizedBox(height: 16),
                Text(
                  'Delivering excellence through innovation',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: AppTheme.textColor.withOpacity(0.8),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: projects.map((project) => _buildProjectCard(
                    project['title'],
                    project['description'],
                    project['icon'],
                    project['stats'],
                    isMobile,
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    String title,
    String description,
    IconData icon,
    List<String> stats,
    bool isMobile,
  ) {
    return HoverCard(
      width: isMobile ? double.infinity : 320,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppTheme.gradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: stats.map((stat) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                stat,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.primaryColor.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection(BuildContext context, bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 32),
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          PageStyles.buildGradientTitle('Client Testimonials', fontSize: 36),
          const SizedBox(height: 48),
          _buildTestimonialsGrid(isMobile),
        ],
      ),
    );
  }

  Widget _buildTestimonialsGrid(bool isMobile) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        _buildTestimonialCard(
          'Exceptional service and results!',
          'John Doe',
          'CEO, Tech Corp',
          isMobile,
        ),
        _buildTestimonialCard(
          'Transformed our business completely',
          'Jane Smith',
          'Founder, StartUp Inc',
          isMobile,
        ),
        _buildTestimonialCard(
          'Professional and innovative team',
          'Mike Johnson',
          'CTO, Digital Solutions',
          isMobile,
        ),
      ],
    );
  }

  Widget _buildTestimonialCard(
      String text, String name, String role, bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 300,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(
            Icons.format_quote_rounded,
            color: AppTheme.primaryColor,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.textColor.withOpacity(0.8),
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          Text(
            role,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction(BuildContext context, bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 32),
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        gradient: AppTheme.gradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Start Your Project?',
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s create something amazing together',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 32),
          _buildContactButton(context),
        ],
      ),
    );
  }

  Widget _buildContactButton(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactPage()),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isHovered ? 0.2 : 0.1),
                    blurRadius: isHovered ? 20 : 10,
                    spreadRadius: isHovered ? 2 : 1,
                  ),
                ],
              ),
              transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
              child: const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleNavigation(int index) {
    if (index != 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            switch (index) {
              case 1:
                return const AboutPage();
              case 2:
                return const ServicesPage();
              case 3:
                return const ClientsPage();
              case 4:
                return const ContactPage();
              default:
                return const HomePage();
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);
    bool isTablet = ResponsiveHelper.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(context, isMobile, isTablet),
                _buildSkillsSection(isMobile),
                _buildServicesSection(context, isMobile),
                _buildProjectsSection(context, isMobile),
                _buildTestimonialsSection(context, isMobile),
                _buildCallToAction(context, isMobile),
              ],
            ),
          ),
          ScrollIndicator(
            isScrolled: _isScrolled,
            isMobile: isMobile,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavBar(
              isScrolled: _isScrolled,
              isMobile: isMobile,
              selectedIndex: 0,
              onHomePressed: () {},
              onAboutPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              ),
              onServicesPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ServicesPage()),
              ),
              onClientsPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ClientsPage()),
              ),
              onContactPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ContactPage()),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? CustomBottomNav(
              selectedIndex: 0,
              onItemSelected: _handleNavigation,
            )
          : null,
    );
  }
}

class ParticlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final random = Random();
    for (var i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
} 