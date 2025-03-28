import 'package:flutter/material.dart';
import 'main.dart'; // For HomePage
import 'contact_page.dart'; // For ContactPage
import 'services_page.dart'; // Add this import
import 'clients_page.dart'; // Add this
import 'widgets/custom_nav_bar.dart';
import 'widgets/custom_bottom_nav.dart';
import 'theme/app_theme.dart';
import 'theme/page_styles.dart'; // Add this
import 'widgets/scroll_indicator.dart';
import 'widgets/hover_card.dart';
import 'utils/responsive_helper.dart';
import 'utils/constants.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
                _buildAboutSection(context, isMobile, isTablet, isDesktop),
                _buildMissionVisionSection(isMobile),
                _buildSkillsSection(isMobile),
                _buildTeamSection(context, isMobile),
                _buildValuesSection(context, isMobile),
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
              selectedIndex: 1,
              onHomePressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              ),
              onAboutPressed: () {},
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
              selectedIndex: 1,
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
        image: const DecorationImage(
          image: NetworkImage(AppConstants.teamImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PageStyles.buildGradientTitle(
              'About Us',
              fontSize: isMobile ? 36 : isTablet ? 48 : 56,
            ),
            const SizedBox(height: 16),
            Text(
              'Building Tomorrow\'s Digital Solutions',
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

  Widget _buildAboutSection(
      BuildContext context, bool isMobile, bool isTablet, bool isDesktop) {
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
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildAboutContent(isMobile),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      AppConstants.officeImage,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    AppConstants.officeImage,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),
                _buildAboutContent(isMobile),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageStyles.buildGradientTitle('Our Story', fontSize: 32),
        const SizedBox(height: 16),
        Text(
          'Founded with a vision to transform digital landscapes, GenZ has been at the forefront of technological innovation since our inception. We combine creativity with technical expertise to deliver solutions that drive business growth and user engagement.',
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: AppTheme.textColor.withOpacity(0.8),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        _buildKeyPoints(),
      ],
    );
  }

  Widget _buildKeyPoints() {
    return Column(
      children: [
        _buildKeyPoint(
          Icons.rocket_launch_outlined,
          'Innovation First',
          'Pushing boundaries with cutting-edge solutions',
        ),
        _buildKeyPoint(
          Icons.psychology_outlined,
          'User-Centric',
          'Focusing on exceptional user experiences',
        ),
        _buildKeyPoint(
          Icons.timeline_outlined,
          'Future-Ready',
          'Building scalable and sustainable solutions',
        ),
      ],
    );
  }

  Widget _buildKeyPoint(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppTheme.gradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: AppTheme.textColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(BuildContext context, bool isMobile) {
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
          PageStyles.buildGradientTitle('Our Team', fontSize: 36),
          const SizedBox(height: 16),
          Text(
            'Meet the experts behind our success',
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
              _buildTeamMember(
                'John Doe',
                'CEO & Founder',
                AppConstants.teamImage,
                isMobile,
              ),
              _buildTeamMember(
                'Jane Smith',
                'Lead Developer',
                AppConstants.teamImage,
                isMobile,
              ),
              _buildTeamMember(
                'Mike Johnson',
                'Design Lead',
                AppConstants.teamImage,
                isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role, String imageUrl, bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 280,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.gradient,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection(BuildContext context, bool isMobile) {
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
          PageStyles.buildGradientTitle('Our Values', fontSize: 36),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildValueCard(
                Icons.lightbulb_outline,
                'Innovation',
                'Constantly pushing boundaries and embracing new technologies',
                isMobile,
              ),
              _buildValueCard(
                Icons.people_outline,
                'Collaboration',
                'Working together to achieve exceptional results',
                isMobile,
              ),
              _buildValueCard(
                Icons.verified_outlined,
                'Excellence',
                'Committed to delivering the highest quality solutions',
                isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(
      IconData icon, String title, String description, bool isMobile) {
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
                  'Our Skills',
                  fontSize: isMobile ? 32 : 42,
                ),
                const SizedBox(height: 16),
                Text(
                  'Expertise in cutting-edge technologies',
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
        'name': 'Frontend Development',
        'icon': Icons.web_rounded,
        'technologies': ['React', 'Angular', 'Vue.js', 'Flutter'],
        'level': 0.9,
      },
      {
        'name': 'Backend Development',
        'icon': Icons.dns_rounded,
        'technologies': ['Node.js', 'Python', 'Java', 'PHP'],
        'level': 0.85,
      },
      {
        'name': 'Mobile Development',
        'icon': Icons.phone_iphone_rounded,
        'technologies': ['Flutter', 'React Native', 'iOS', 'Android'],
        'level': 0.95,
      },
      {
        'name': 'Database & Cloud',
        'icon': Icons.storage_rounded,
        'technologies': ['MySQL', 'MongoDB', 'PostgreSQL', 'Firebase'],
        'level': 0.88,
      },
      {
        'name': 'UI/UX Design',
        'icon': Icons.design_services_rounded,
        'technologies': ['Figma', 'Adobe XD', 'Sketch', 'Photoshop'],
        'level': 0.92,
      },
      {
        'name': 'DevOps & Tools',
        'icon': Icons.build_circle_rounded,
        'technologies': ['Git', 'Docker', 'AWS', 'CI/CD'],
        'level': 0.87,
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
                child: Icon(skill['icon'], color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  skill['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: skill['level'],
              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 20),
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

  Widget _buildMissionVisionSection(bool isMobile) {
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
                Icons.lightbulb_outline_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildMissionCard(isMobile)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildVisionCard(isMobile)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionCard(bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 300,
      padding: const EdgeInsets.all(24),
      child: Column(
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
            child: const Icon(
              Icons.rocket_launch_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Our Mission',
            style: TextStyle(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = AppTheme.gradient.createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'To empower businesses through innovative digital solutions that drive growth and create lasting impact.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.8),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVisionCard(bool isMobile) {
    return HoverCard(
      width: isMobile ? double.infinity : 300,
      padding: const EdgeInsets.all(24),
      child: Column(
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
            child: const Icon(
              Icons.remove_red_eye_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Our Vision',
            style: TextStyle(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = AppTheme.gradient.createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'To be the leading force in digital transformation, shaping the future of technology and business innovation.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.8),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index != 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            switch (index) {
              case 0:
                return const HomePage();
              case 2:
                return const ServicesPage();
              case 3:
                return const ClientsPage();
              case 4:
                return const ContactPage();
              default:
                return const AboutPage();
            }
          },
        ),
      );
    }
  }
}
