import 'package:flutter/material.dart';
import 'main.dart';
import 'about_page.dart';
import 'contact_page.dart';
import 'services_page.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/custom_bottom_nav.dart';
import 'theme/app_theme.dart';
import 'theme/page_styles.dart';
import 'widgets/scroll_indicator.dart';
import 'widgets/hover_card.dart';
import 'widgets/page_layout.dart';
import 'utils/responsive_helper.dart';
import 'utils/constants.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
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
                _buildClientShowcase(context, isMobile),
                _buildSuccessStories(context, isMobile),
                _buildPartnershipBenefits(context, isMobile),
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
              selectedIndex: 3,
              onHomePressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              ),
              onAboutPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              ),
              onServicesPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ServicesPage()),
              ),
              onClientsPressed: () {},
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
              selectedIndex: 3,
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
        image: const DecorationImage(
          image: NetworkImage(AppConstants.teamImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PageStyles.buildGradientTitle(
              'Our Clients',
              fontSize: isMobile ? 36 : isTablet ? 48 : 56,
            ),
            const SizedBox(height: 16),
            Text(
              'Success Stories & Partnerships',
              style: TextStyle(
                fontSize: isMobile ? 16 : isTablet ? 20 : 24,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientShowcase(BuildContext context, bool isMobile) {
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
                Icons.business_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          // Main content
          Container(
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            child: Column(
              children: [
                PageStyles.buildGradientTitle(
                  'Trusted by Industry Leaders',
                  fontSize: isMobile ? 32 : 42,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Partnering with leading companies to deliver exceptional solutions',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: AppTheme.textColor.withOpacity(0.8),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),
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
                  child: Column(
                    children: [
                      _buildClientGrid(isMobile),
                      const SizedBox(height: 32),
                      _buildClientStats(isMobile),
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

  Widget _buildClientGrid(bool isMobile) {
    final List<String> clientNames = [
      'TechVision Corp',
      'InnovatePro',
      'GlobalSoft',
      'DataFlow Systems',
      'SmartBridge Inc',
      'FutureWave Tech',
    ];

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: clientNames.map((name) => _buildClientLogo(name, isMobile)).toList(),
    );
  }

  Widget _buildClientLogo(String name, bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 200,
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.gradient,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  name.split(' ').map((word) => word[0]).join(''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientStats(bool isMobile) {
    return Wrap(
      spacing: 40,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        _buildStatItem('100+', 'Happy Clients', Icons.people_outline),
        _buildStatItem('500+', 'Projects Completed', Icons.task_alt_outlined),
        _buildStatItem('10+', 'Years Experience', Icons.timeline_outlined),
        _buildStatItem('24/7', 'Support', Icons.support_agent_outlined),
      ],
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.05),
            AppTheme.secondaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            number,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = AppTheme.gradient.createShader(
                  const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessStories(BuildContext context, bool isMobile) {
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
          PageStyles.buildGradientTitle('Success Stories', fontSize: 36),
          const SizedBox(height: 16),
          Text(
            'Real results from real clients',
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.textColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          _buildSuccessStoriesGrid(isMobile),
        ],
      ),
    );
  }

  Widget _buildSuccessStoriesGrid(bool isMobile) {
    final List<Map<String, dynamic>> successStories = [
      {
        'client': 'TechVision Corp',
        'title': 'Digital Transformation',
        'result': '200% increase in online engagement',
        'icon': Icons.trending_up_rounded,
      },
      {
        'client': 'InnovatePro',
        'title': 'E-commerce Solution',
        'result': '150% growth in sales revenue',
        'icon': Icons.shopping_cart_rounded,
      },
      {
        'client': 'GlobalSoft',
        'title': 'Mobile App Development',
        'result': '1M+ downloads in first month',
        'icon': Icons.phone_iphone_rounded,
      },
    ];

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: successStories.map((story) {
        return _buildSuccessStoryCard(
          story['title'],
          story['result'],
          story['icon'],
          isMobile,
          clientName: story['client'],
        );
      }).toList(),
    );
  }

  Widget _buildSuccessStoryCard(
      String title, String result, IconData icon, bool isMobile,
      {required String clientName}) {
    return HoverCard(
      width: isMobile ? double.infinity : 300,
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
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            clientName,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.primaryColor.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
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
            result,
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

  Widget _buildPartnershipBenefits(BuildContext context, bool isMobile) {
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
          PageStyles.buildGradientTitle('Why Partner With Us?', fontSize: 36),
          const SizedBox(height: 48),
          _buildBenefitsGrid(isMobile),
        ],
      ),
    );
  }

  Widget _buildBenefitsGrid(bool isMobile) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        _buildBenefitCard(
          'Expertise',
          'Access to skilled professionals',
          Icons.psychology_rounded,
          isMobile,
        ),
        _buildBenefitCard(
          'Innovation',
          'Cutting-edge solutions',
          Icons.lightbulb_rounded,
          isMobile,
        ),
        _buildBenefitCard(
          'Support',
          '24/7 dedicated assistance',
          Icons.support_agent_rounded,
          isMobile,
        ),
      ],
    );
  }

  Widget _buildBenefitCard(
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

  Widget _buildTestimonialsSection(BuildContext context, bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 32),
      padding: EdgeInsets.all(isMobile ? 24 : 40),
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
                Icons.format_quote_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          Column(
            children: [
              PageStyles.buildGradientTitle('Client Testimonials', fontSize: 36),
              const SizedBox(height: 16),
              Text(
                'What our clients say about us',
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: AppTheme.textColor.withOpacity(0.8),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _buildTestimonialsGrid(isMobile),
            ],
          ),
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

  Widget _buildTestimonialCard(String text, String name, String role, bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 300,
      padding: const EdgeInsets.all(24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              const SizedBox(height: 40), // Space for the avatar
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textColor.withOpacity(0.8),
                  height: 1.6,
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
          // Floating avatar
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: AppTheme.gradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    name[0],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
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
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ContactPage()),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
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
    if (index != 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            switch (index) {
              case 0:
                return const HomePage();
              case 1:
                return const AboutPage();
              case 2:
                return const ServicesPage();
              case 4:
                return const ContactPage();
              default:
                return const ClientsPage();
            }
          },
        ),
      );
    }
  }
} 