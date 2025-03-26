import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:personal_site/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(3, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Text('JP', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
            actions: [
              TextButton(
                onPressed: () => _scrollToSection(0),
                child: Text('Home', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              TextButton(
                onPressed: () => _scrollToSection(1),
                child: Text('About', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              TextButton(
                onPressed: () => _scrollToSection(2),
                child: Text('Contact', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              const SizedBox(width: 16),
              _buildResumeButton(),
              const SizedBox(width: 24),
            ],
          ),
          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeroSection(),
                _buildAboutSection(),
                _buildContactSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return VisibilityDetector(
      key: _sectionKeys[0],
      onVisibilityChanged: (_) {},
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          image: const DecorationImage(
            image: AssetImage('assets/space.jpg'),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jeremiah Parrack',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white70,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Full-stack developer transforming ideas',
                        speed: const Duration(milliseconds: 50),
                      ),
                      TypewriterAnimatedText(
                        'into scalable digital solutions',
                        speed: const Duration(milliseconds: 50),
                      ),
                    ],
                    repeatForever: true,
                    pause: const Duration(seconds: 2),
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () => _scrollToSection(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Explore My Work',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return VisibilityDetector(
      key: _sectionKeys[1],
      onVisibilityChanged: (_) {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          image: DecorationImage(
            image: const AssetImage('assets/space.jpg'),
            fit: BoxFit.cover,
            opacity: 0.03,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              BlendMode.overlay,
            ),
          ),
        ),
        child: ResponsiveRowColumn(
          layout: ResponsiveBreakpoints.of(context).largerThan(TABLET)
              ? ResponsiveRowColumnType.ROW
              : ResponsiveRowColumnType.COLUMN,
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          columnMainAxisAlignment: MainAxisAlignment.start,
          columnCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 1,
              columnFlex: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Me',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'I\'m a passionate full-stack developer with expertise in building scalable applications. '
                      'Currently working at Manheim, I lead SRE/DevOps initiatives across multiple teams, '
                      'both onshore and offshore. Through my consulting work, I\'ve helped organizations optimize their AWS infrastructure, significantly reducing cloud costs while maintaining performance.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'As an active open source contributor, I maintain several significant projects in the Rails-Lambda ecosystem, including Lamby (a Ruby on Rails & AWS Lambda integration framework) and Crypteia (a Rust-based Lambda extension for secure environment variables). My commitment to open source reflects my belief in collaborative development and knowledge sharing.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Through my LLC, I provide comprehensive development services including:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildSkillsList(),
                  ],
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              columnFlex: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Skills & Expertise',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildSkillChip('Flutter'),
                        _buildSkillChip('Ruby'),
                        _buildSkillChip('Node.js'),
                        _buildSkillChip('TypeScript'),
                        _buildSkillChip('DevOps'),
                        _buildSkillChip('AWS'),
                        _buildSkillChip('Serverless'),
                        _buildSkillChip('Docker'),
                        _buildSkillChip('CI/CD'),
                        _buildSkillChip('Open Source'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return VisibilityDetector(
      key: _sectionKeys[2],
      onVisibilityChanged: (_) {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get in Touch',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 64),
            Wrap(
              spacing: 48,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: [
                _buildContactButton(
                  icon: FontAwesomeIcons.envelope,
                  label: 'Email',
                  onPressed: () => _launchEmail(),
                ),
                _buildContactButton(
                  icon: FontAwesomeIcons.linkedin,
                  label: 'LinkedIn',
                  onPressed: () => _launchUrl(kLinkedInUrl),
                ),
                _buildContactButton(
                  icon: FontAwesomeIcons.github,
                  label: 'GitHub',
                  onPressed: () => _launchUrl(kGithubUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsList() {
    final skills = [
      'Full Mobile App Development',
      'Web Application Development',
      'Infrastructure & DevOps',
      'System Architecture Design',
      'Performance Optimization',
      'AWS Cost Optimization & Analysis',
      'Technical Consulting',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skills.map((skill) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.1),
                  ),
                  child: const Icon(Icons.check_circle, size: 20, color: Colors.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    skill,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ],
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: FaIcon(
                  icon,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumeButton() {
    return TextButton.icon(
      onPressed: () => _launchUrl(kResumeUrl),
      icon: FaIcon(
        FontAwesomeIcons.fileLines,
        size: 16,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        'Resume',
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  void _scrollToSection(int index) {
    Scrollable.ensureVisible(
      _sectionKeys[index].currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: kEmailAddress,
      queryParameters: {'subject': 'Freelance Inquiry (Ref: Website)'},
    );
    await launchUrl(emailLaunchUri);
  }
}
