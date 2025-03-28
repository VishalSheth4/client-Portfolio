import 'package:flutter/material.dart';
import 'main.dart';
import 'about_page.dart';
import 'contact_page.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/custom_bottom_nav.dart';
import 'theme/app_theme.dart';
import 'widgets/scroll_indicator.dart';
import 'widgets/page_layout.dart';
import 'widgets/hover_card.dart';
import 'theme/page_styles.dart';
import 'clients_page.dart';
import 'utils/responsive_helper.dart';
import 'utils/constants.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
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

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);
    bool isTablet = ResponsiveHelper.isTablet(context);
    bool isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(context, isMobile, isTablet),
                _buildServicesGrid(context, isMobile, isTablet, isDesktop),
                _buildWorkProcessSection(context),
                _buildCollaborationSection(context),
                _buildTestimonialsSection(context, isMobile),
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
              selectedIndex: 2,
              onHomePressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              ),
              onAboutPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              ),
              onServicesPressed: () {},
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
              selectedIndex: 2,
              onItemSelected: _handleNavigation,
            )
          : null,
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      height: ResponsiveHelper.getImageHeight(context, isHero: true),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
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
        image: const DecorationImage(
          image: NetworkImage(AppConstants.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PageStyles.buildGradientTitle(
              'Our Services',
              fontSize: isMobile
                  ? 36
                  : isTablet
                      ? 48
                      : 56,
            ),
            const SizedBox(height: 16),
            Text(
              'Professional Solutions for Your Business',
              style: TextStyle(
                fontSize: isMobile
                    ? 16
                    : isTablet
                        ? 20
                        : 24,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid(
      BuildContext context, bool isMobile, bool isTablet, bool isDesktop) {
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
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.3),
                    AppTheme.secondaryColor.withOpacity(0.3),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Main content
          Container(
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            child: Column(
              children: [
                PageStyles.buildGradientTitle(
                  'Our Services',
                  fontSize: isMobile ? 32 : 42,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Discover our comprehensive range of professional services tailored to your needs',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: AppTheme.textColor.withOpacity(0.8),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),
                // Services grid
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(32),
                  child: Wrap(
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
                        'UI/UX Design',
                        'Intuitive and beautiful interfaces',
                        Icons.design_services_rounded,
                        isMobile,
                      ),
                      // Add more service cards as needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
      String title, String description, IconData icon, bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 300,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.gradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkProcessSection(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 32),
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.05),
            AppTheme.secondaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          PageStyles.buildGradientTitle('How I Work', fontSize: 36),
          const SizedBox(height: 48),
          _buildWorkSteps(context),
        ],
      ),
    );
  }

  Widget _buildWorkSteps(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        _buildWorkStep(
          icon: Icons.lightbulb_outline,
          title: 'Discovery',
          description:
              'Understanding your needs, goals, and vision through detailed consultation.',
          number: '01',
          isMobile: isMobile,
        ),
        _buildWorkStep(
          icon: Icons.architecture,
          title: 'Planning',
          description:
              'Creating comprehensive strategy and technical architecture.',
          number: '02',
          isMobile: isMobile,
        ),
        _buildWorkStep(
          icon: Icons.code,
          title: 'Development',
          description:
              'Building your solution with best practices and latest technologies.',
          number: '03',
          isMobile: isMobile,
        ),
        _buildWorkStep(
          icon: Icons.rocket_launch,
          title: 'Launch',
          description:
              'Deploying and ensuring smooth operation of your solution.',
          number: '04',
          isMobile: isMobile,
        ),
      ],
    );
  }

  Widget _buildWorkStep({
    required IconData icon,
    required String title,
    required String description,
    required String number,
    required bool isMobile,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isMobile ? double.infinity : 280,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isHovered
                    ? AppTheme.primaryColor.withOpacity(0.3)
                    : Colors.transparent,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: isHovered ? 20 : 10,
                  spreadRadius: isHovered ? 5 : 2,
                ),
              ],
            ),
            transform: Matrix4.identity()..translate(0, isHovered ? -5 : 0),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Text(
                    number,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor.withOpacity(0.1),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: AppTheme.gradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 24),
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCollaborationSection(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 32),
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
          width: 1,
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
        children: [
          PageStyles.buildGradientTitle('Why Work With Us?', fontSize: 36),
          const SizedBox(height: 16),
          Text(
            'Experience seamless collaboration and exceptional results',
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.textColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildCollaborationCard(
                icon: Icons.timer_outlined,
                title: 'Fast Turnaround',
                description: 'Quick delivery without compromising quality',
                isMobile: isMobile,
              ),
              _buildCollaborationCard(
                icon: Icons.support_agent,
                title: '24/7 Support',
                description: 'Round-the-clock assistance for your needs',
                isMobile: isMobile,
              ),
              _buildCollaborationCard(
                icon: Icons.handshake_outlined,
                title: 'Dedicated Team',
                description: 'Expert professionals at your service',
                isMobile: isMobile,
              ),
              _buildCollaborationCard(
                icon: Icons.price_check,
                title: 'Competitive Pricing',
                description: 'Best value for your investment',
                isMobile: isMobile,
              ),
            ],
          ),
          const SizedBox(height: 48),
          _buildCallToAction(context),
        ],
      ),
    );
  }

  Widget _buildCollaborationCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isMobile ? double.infinity : 250,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isHovered
                  ? AppTheme.primaryColor.withOpacity(0.02)
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isHovered
                    ? AppTheme.primaryColor.withOpacity(0.3)
                    : AppTheme.primaryColor.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: isHovered ? 20 : 10,
                  spreadRadius: isHovered ? 5 : 2,
                ),
              ],
            ),
            transform: Matrix4.identity()..translate(0, isHovered ? -5 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppTheme.gradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCallToAction(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ContactPage()),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                gradient: AppTheme.gradient,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor
                        .withOpacity(isHovered ? 0.3 : 0.2),
                    blurRadius: isHovered ? 20 : 15,
                    spreadRadius: isHovered ? 2 : 1,
                  ),
                ],
              ),
              transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
              child: const Text(
                'Start Your Project',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestimonialsSection(BuildContext context, bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 32),
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.05),
            AppTheme.secondaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          PageStyles.buildGradientTitle('Client Testimonials', fontSize: 36),
          const SizedBox(height: 16),
          Text(
            'What our clients say about us',
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.textColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildTestimonialCard(
                'Amazing service! The team was professional and delivered exactly what we needed.',
                'John Smith',
                'CEO, Tech Corp',
                isMobile,
              ),
              _buildTestimonialCard(
                'Exceptional work quality and great communication throughout the project.',
                'Sarah Johnson',
                'Marketing Director',
                isMobile,
              ),
              _buildTestimonialCard(
                'They transformed our business with their innovative solutions.',
                'Mike Brown',
                'Founder, StartUp Inc',
                isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(
      String testimonial, String name, String role, bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 300,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.format_quote,
            color: AppTheme.primaryColor,
            size: 32,
          ),
          const SizedBox(height: 16),
          Text(
            testimonial,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.8),
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.gradient,
                ),
                child: Center(
                  child: Text(
                    name[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
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
            ],
          ),
        ],
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index != 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            switch (index) {
              case 0:
                return const HomePage();
              case 1:
                return const AboutPage();
              case 3:
                return const ClientsPage();
              case 4:
                return const ContactPage();
              default:
                return const ServicesPage();
            }
          },
        ),
      );
    }
  }
}
