import 'package:flutter/material.dart';
import 'main.dart';
import 'about_page.dart';
import 'services_page.dart';
import 'clients_page.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/custom_bottom_nav.dart';
import 'theme/app_theme.dart';
import 'widgets/scroll_indicator.dart';
import 'widgets/hover_card.dart';
import 'theme/page_styles.dart';
import 'utils/responsive_helper.dart';
import 'utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'services/excel_service.dart';
import 'submissions_page.dart';
import 'dart:math';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool _isScrolled = false;
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  bool _isHovered = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> _submissions = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadSubmissions();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(context, isMobile, isTablet),
                _buildContactForm(context, isMobile),
                _buildOfficeLocations(context, isMobile),
                _buildContactMethods(context, isMobile),
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
              selectedIndex: 4,
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
              onClientsPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ClientsPage()),
              ),
              onContactPressed: () {},
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? CustomBottomNav(
              selectedIndex: 4,
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
        image: DecorationImage(
          image: const NetworkImage(AppConstants.officeImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildParticleOverlay(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedTitle('Contact Us', isMobile, isTablet),
                const SizedBox(height: 24),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    'Let\'s Create Something Amazing Together',
                    style: TextStyle(
                      fontSize: isMobile
                          ? 16
                          : isTablet
                              ? 20
                              : 24,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
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
              fontSize: isMobile
                  ? 36
                  : isTablet
                      ? 48
                      : 56,
            ),
          ),
        );
      },
    );
  }

  Widget _buildParticleOverlay() {
    return CustomPaint(
      painter: ParticlePainter(),
    );
  }

  Widget _buildContactForm(BuildContext context, bool isMobile) {
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
          ..._buildDecorativeElements(),
          Container(
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildFormHeader(isMobile),
                  const SizedBox(height: 48),
                  _buildFormFields(isMobile),
                  const SizedBox(height: 32),
                  _buildFormActions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDecorativeElements() {
    return [
      Positioned(
        top: -50,
        right: -50,
        child: _buildFloatingIcon(),
      ),
      Positioned(
        bottom: -30,
        left: -30,
        child: _buildDecorativeCircle(),
      ),
    ];
  }

  Widget _buildFloatingIcon() {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 2),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 10 * sin(value * pi)),
          child: Container(
            width: 150,
            height: 150,
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
              Icons.mail_outline_rounded,
              color: Colors.white,
              size: 60,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDecorativeCircle() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.3),
            AppTheme.secondaryColor.withOpacity(0.3),
          ],
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildFormHeader(bool isMobile) {
    return PageStyles.buildGradientTitle(
      'Send us a Message',
      fontSize: isMobile ? 32 : 42,
    );
  }

  Widget _buildFormFields(bool isMobile) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'We\'d love to hear from you! Fill out the form below and we\'ll get back to you as soon as possible.',
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
              _buildFormField(
                'Name',
                Icons.person_outline,
                TextInputType.name,
                (value) => value!.isEmpty ? 'Please enter your name' : null,
                controller: _nameController,
              ),
              const SizedBox(height: 24),
              _buildFormField(
                'Email',
                Icons.email_outlined,
                TextInputType.emailAddress,
                (value) =>
                    !value!.contains('@') ? 'Please enter a valid email' : null,
                controller: _emailController,
              ),
              const SizedBox(height: 24),
              _buildFormField(
                'Message',
                Icons.message_outlined,
                TextInputType.multiline,
                (value) => value!.isEmpty ? 'Please enter your message' : null,
                maxLines: 5,
                controller: _messageController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormActions() {
    return _buildSubmitButton();
  }

  Widget _buildFormField(
    String label,
    IconData icon,
    TextInputType keyboardType,
    String? Function(String?) validator, {
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppTheme.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppTheme.primaryColor.withOpacity(0.1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppTheme.primaryColor.withOpacity(0.1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppTheme.primaryColor,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await ExcelService.saveContactForm(
                    _nameController.text,
                    _emailController.text,
                    _messageController.text,
                  );

                  // Clear the form
                  _nameController.clear();
                  _emailController.clear();
                  _messageController.clear();

                  // Show success message
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Message saved successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error saving message: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
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
                'Send Message',
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

  Widget _buildOfficeLocations(BuildContext context, bool isMobile) {
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
          PageStyles.buildGradientTitle('Our Offices', fontSize: 36),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildOfficeCard(
                'San Francisco',
                '123 Tech Valley, CA 94043',
                Icons.location_on_outlined,
                isMobile,
              ),
              _buildOfficeCard(
                'New York',
                '456 Business Ave, NY 10013',
                Icons.location_on_outlined,
                isMobile,
              ),
              _buildOfficeCard(
                'London',
                '789 Innovation St, UK SW1A 1AA',
                Icons.location_on_outlined,
                isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactMethods(BuildContext context, bool isMobile) {
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
          PageStyles.buildGradientTitle('Get in Touch', fontSize: 36),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildContactMethodCard(
                'Phone',
                '+1 (555) 123-4567',
                Icons.phone_outlined,
                isMobile,
              ),
              _buildContactMethodCard(
                'Email',
                'contact@genz.com',
                Icons.email_outlined,
                isMobile,
              ),
              _buildContactMethodCard(
                'Working Hours',
                'Mon - Fri: 9:00 AM - 6:00 PM',
                Icons.access_time_outlined,
                isMobile,
              ),
            ],
          ),
          const SizedBox(height: 48),
          _buildSocialLinks(isMobile),
        ],
      ),
    );
  }

  Widget _buildContactMethodCard(
      String title, String content, IconData icon, bool isMobile) {
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
            content,
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

  Widget _buildSocialLinks(bool isMobile) {
    return Column(
      children: [
        Text(
          'Follow Us',
          style: TextStyle(
            fontSize: isMobile ? 24 : 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(FontAwesomeIcons.facebook, () {}),
            const SizedBox(width: 16),
            _buildSocialButton(FontAwesomeIcons.twitter, () {}),
            const SizedBox(width: 16),
            _buildSocialButton(FontAwesomeIcons.linkedin, () {}),
            const SizedBox(width: 16),
            _buildSocialButton(FontAwesomeIcons.instagram, () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onPressed) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: AppTheme.gradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor
                        .withOpacity(isHovered ? 0.3 : 0.2),
                    blurRadius: isHovered ? 20 : 15,
                    spreadRadius: isHovered ? 2 : 1,
                  ),
                ],
              ),
              transform: Matrix4.identity()..scale(isHovered ? 1.1 : 1.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOfficeCard(
      String city, String address, IconData icon, bool isMobile) {
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
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            city,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            address,
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

  void _handleNavigation(int index) {
    if (index != 4) {
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
              case 3:
                return const ClientsPage();
              default:
                return const ContactPage();
            }
          },
        ),
      );
    }
  }

  Future<void> _loadSubmissions() async {
    final submissions = await ExcelService.getSubmissions();
    setState(() {
      _submissions = submissions;
    });
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
