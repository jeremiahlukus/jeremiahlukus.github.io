import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:personal_site/const.dart';

// ─── Design tokens ──────────────────────────────────────────────────────────
const _bg = Color(0xFF0D0B14);
const _card = Color(0xFF1A1628);
const _border = Color(0xFF2D2440);
const _accent = Color(0xFF8B5CF6);
const _accentLight = Color(0xFFA78BFA);
const _cyan = Color(0xFF22D3EE);
const _emerald = Color(0xFF10B981);
const _amber = Color(0xFFF59E0B);
const _textSub = Color(0xFF94A3B8);

void _launch(String url) => launchUrl(Uri.parse(url));

// ─── Root ───────────────────────────────────────────────────────────────────

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700), curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: _bg.withValues(alpha: 0.88),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            title: _Logo(),
            actions: [
              if (!isMobile) ...[
                _NavLink('About', () => _scrollTo(_aboutKey)),
                _NavLink('Contact', () => _scrollTo(_contactKey)),
                const SizedBox(width: 8),
              ],
              _ResumeChip(),
              const SizedBox(width: 20),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _HeroSection(
                  key: _heroKey,
                  isMobile: isMobile,
                  onScrollToAbout: () => _scrollTo(_aboutKey),
                ),
                _AboutSection(key: _aboutKey, isMobile: isMobile),
                _SkillsSection(isMobile: isMobile),
                _ContactSection(key: _contactKey, isMobile: isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Nav ────────────────────────────────────────────────────────────────────

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_accent, _cyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text('JP',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 13,
                letterSpacing: 0.5)),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) { if (mounted) setState(() => _hovered = true); },
      onExit: (_) { if (mounted) setState(() => _hovered = false); },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              color: _hovered ? Colors.white : _textSub,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _ResumeChip extends StatefulWidget {
  @override
  State<_ResumeChip> createState() => _ResumeChipState();
}

class _ResumeChipState extends State<_ResumeChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) { if (mounted) setState(() => _hovered = true); },
      onExit: (_) { if (mounted) setState(() => _hovered = false); },
      child: GestureDetector(
        onTap: () => _launch(kResumeUrl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? _accent.withValues(alpha: 0.18)
                : _accent.withValues(alpha: 0.08),
            border: Border.all(
                color: _accent.withValues(alpha: _hovered ? 0.9 : 0.5)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Resume',
              style: TextStyle(
                  color: _accentLight, fontWeight: FontWeight.w600, fontSize: 13)),
        ),
      ),
    );
  }
}

// ─── Hero ───────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onScrollToAbout;
  const _HeroSection(
      {super.key, required this.isMobile, required this.onScrollToAbout});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height - 60;

    if (isMobile) {
      // Mobile: natural height, no viewport constraint, outer scroll handles it
      return Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _DotGridPainter())),
          Positioned(top: -60, left: -40,
              child: _GlowOrb(color: _accent.withValues(alpha: 0.4), size: 400)),
          Positioned(bottom: -40, right: -40,
              child: _GlowOrb(color: _cyan.withValues(alpha: 0.25), size: 300)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeroText(onScrollToAbout: onScrollToAbout, isMobile: true),
                const SizedBox(height: 28),
                _HeroCodeBlockMobile(),
              ],
            ),
          ),
        ],
      );
    }

    return SizedBox(
      width: double.infinity,
      height: h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Dot grid texture
          Positioned.fill(child: CustomPaint(painter: _DotGridPainter())),
          // Glow orbs
          Positioned(
            top: -60, left: -40,
            child: _GlowOrb(color: _accent.withValues(alpha: 0.4), size: 500),
          ),
          Positioned(
            bottom: -40, right: -40,
            child: _GlowOrb(color: _cyan.withValues(alpha: 0.25), size: 380),
          ),
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _HeroText(
                              onScrollToAbout: onScrollToAbout,
                              isMobile: false),
                        ),
                        const SizedBox(width: 56),
                        Expanded(
                          flex: 4,
                          child: _HeroCodeBlock(),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.045)
      ..style = PaintingStyle.fill;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HeroText extends StatelessWidget {
  final VoidCallback onScrollToAbout;
  final bool isMobile;
  const _HeroText({required this.onScrollToAbout, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Pulsing available badge
        _AvailableBadge(),
        const SizedBox(height: 28),
        // Gradient name
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFE0D7FF), _accentLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Jeremiah\nParrack',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 52 : 96,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 0.95,
              letterSpacing: -4,
            ),
          ),
        ),
        const SizedBox(height: 22),
        SizedBox(
          height: 34,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              color: _textSub,
              fontWeight: FontWeight.w400,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Lead Software Engineer',
                    speed: const Duration(milliseconds: 55)),
                TypewriterAnimatedText('Flutter Developer',
                    speed: const Duration(milliseconds: 55)),
                TypewriterAnimatedText('DevOps & Cloud Architect',
                    speed: const Duration(milliseconds: 55)),
                TypewriterAnimatedText('Open Source Contributor',
                    speed: const Duration(milliseconds: 55)),
              ],
              repeatForever: true,
              pause: const Duration(seconds: 2),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'I build production-grade apps and infrastructure.\nCurrently at Manheim leading SRE/DevOps across global teams.',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: _textSub,
            fontSize: isMobile ? 15 : 16,
            height: 1.75,
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _PrimaryBtn('About Me', onScrollToAbout),
            _OutlineBtn('Get in Touch', () => _launch('mailto:$kEmailAddress')),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _IconBtn(FontAwesomeIcons.github, kGithubUrl),
            const SizedBox(width: 12),
            _IconBtn(FontAwesomeIcons.linkedin, kLinkedInUrl),
            const SizedBox(width: 12),
            _IconBtn(FontAwesomeIcons.envelope, 'mailto:$kEmailAddress'),
          ],
        ),
      ],
    );
  }
}

// Animated pulsing "available" badge
class _AvailableBadge extends StatefulWidget {
  @override
  State<_AvailableBadge> createState() => _AvailableBadgeState();
}

class _AvailableBadgeState extends State<_AvailableBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat(reverse: true);
    _pulse = Tween(begin: 0.4, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _emerald.withValues(alpha: _pulse.value),
                boxShadow: [
                  BoxShadow(
                      color: _emerald.withValues(alpha: _pulse.value * 0.6),
                      blurRadius: 6)
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Flexible(
            child: Text('Available for freelance work',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: _accentLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

// Syntax-highlighted profile code block
class _HeroCodeBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0C1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
              color: _accent.withValues(alpha: 0.1),
              blurRadius: 40,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Traffic light buttons
          Row(children: [
            _TrafficDot(const Color(0xFFFF5F56)),
            const SizedBox(width: 7),
            _TrafficDot(const Color(0xFFFFBD2E)),
            const SizedBox(width: 7),
            _TrafficDot(const Color(0xFF27C93F)),
            const SizedBox(width: 12),
            const Text('profile.dart',
                style: TextStyle(color: _textSub, fontSize: 11)),
          ]),
          const SizedBox(height: 22),
          _CodeRow([
            _CS('const ', _accentLight),
            _CS('jeremiah', Colors.white),
            _CS(' = {', _textSub),
          ]),
          const SizedBox(height: 8),
          _CodeRow([
            _CS('  role', _cyan),
            _CS(': ', _textSub),
            _CS('"Lead Software Engineer"', _emerald),
            _CS(',', _textSub),
          ]),
          const SizedBox(height: 8),
          _CodeRow([
            _CS('  at', _cyan),
            _CS(': ', _textSub),
            _CS('"Manheim (SRE/DevOps)"', _emerald),
            _CS(',', _textSub),
          ]),
          const SizedBox(height: 8),
          _CodeRow([
            _CS('  oss', _cyan),
            _CS(': ', _textSub),
            _CS('[', _textSub),
            _CS('"Lamby"', _emerald),
            _CS(', ', _textSub),
            _CS('"Crypteia"', _emerald),
            _CS(', ...+more', _textSub),
            _CS('],', _textSub),
          ]),
          const SizedBox(height: 8),
          _CodeRow([
            _CS('  stack', _cyan),
            _CS(': ', _textSub),
            _CS('[', _textSub),
            _CS('"Flutter"', _emerald),
            _CS(', ', _textSub),
            _CS('"Ruby"', _emerald),
            _CS(', ', _textSub),
            _CS('"AWS"', _emerald),
            _CS('],', _textSub),
          ]),
          const SizedBox(height: 8),
          _CodeRow([
            _CS('  available', _cyan),
            _CS(': ', _textSub),
            _CS('true', _amber),
            _CS(',', _textSub),
          ]),
          const SizedBox(height: 8),
          _CodeRow([_CS('};', _textSub)]),
        ],
      ),
    );
  }
}

class _CS {
  final String text;
  final Color color;
  const _CS(this.text, this.color);
}

class _CodeRow extends StatelessWidget {
  final List<_CS> spans;
  const _CodeRow(this.spans);

  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: true,
      overflow: TextOverflow.visible,
      text: TextSpan(
        style: const TextStyle(
            fontFamily: 'monospace', fontSize: 13, height: 1.6),
        children: spans
            .map((s) => TextSpan(
                text: s.text,
                style: TextStyle(color: s.color, fontWeight: FontWeight.w500)))
            .toList(),
      ),
    );
  }
}

class _TrafficDot extends StatelessWidget {
  final Color color;
  const _TrafficDot(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

// Compact code block for mobile hero
class _HeroCodeBlockMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0C1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            _TrafficDot(const Color(0xFFFF5F56)),
            const SizedBox(width: 6),
            _TrafficDot(const Color(0xFFFFBD2E)),
            const SizedBox(width: 6),
            _TrafficDot(const Color(0xFF27C93F)),
            const SizedBox(width: 10),
            const Text('profile.dart',
                style: TextStyle(color: _textSub, fontSize: 11)),
          ]),
          const SizedBox(height: 14),
          _CodeRow([
            _CS('const ', _accentLight),
            _CS('jeremiah', Colors.white),
            _CS(' = {', _textSub)
          ]),
          const SizedBox(height: 6),
          _CodeRow([
            _CS('  role', _cyan),
            _CS(': ', _textSub),
            _CS('"Lead Software Engineer"', _emerald),
            _CS(',', _textSub)
          ]),
          const SizedBox(height: 6),
          _CodeRow([
            _CS('  at', _cyan),
            _CS(': ', _textSub),
            _CS('"Manheim (SRE/DevOps)"', _emerald),
            _CS(',', _textSub)
          ]),
          const SizedBox(height: 6),
          _CodeRow([
            _CS('  available', _cyan),
            _CS(': ', _textSub),
            _CS('true', _amber),
            _CS(',', _textSub)
          ]),
          const SizedBox(height: 6),
          _CodeRow([_CS('};', _textSub)]),
        ],
      ),
    );
  }
}

// ─── Buttons ─────────────────────────────────────────────────────────────────

class _PrimaryBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryBtn(this.label, this.onTap);

  @override
  State<_PrimaryBtn> createState() => _PrimaryBtnState();
}

class _PrimaryBtnState extends State<_PrimaryBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) { if (mounted) setState(() => _hovered = true); },
      onExit: (_) { if (mounted) setState(() => _hovered = false); },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _hovered
                  ? [const Color(0xFFB07FFF), _accent]
                  : [_accent, const Color(0xFF6D28D9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                        color: _accent.withValues(alpha: 0.45),
                        blurRadius: 24,
                        offset: const Offset(0, 8))
                  ]
                : [],
          ),
          child: Text(widget.label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15)),
        ),
      ),
    );
  }
}

class _OutlineBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineBtn(this.label, this.onTap);

  @override
  State<_OutlineBtn> createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<_OutlineBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) { if (mounted) setState(() => _hovered = true); },
      onExit: (_) { if (mounted) setState(() => _hovered = false); },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: _hovered ? _border : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _border, width: 1.5),
          ),
          child: Text(widget.label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
        ),
      ),
    );
  }
}

class _IconBtn extends StatefulWidget {
  final FaIconData icon;
  final String url;
  const _IconBtn(this.icon, this.url);

  @override
  State<_IconBtn> createState() => _IconBtnState();
}

class _IconBtnState extends State<_IconBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) { if (mounted) setState(() => _hovered = true); },
      onExit: (_) { if (mounted) setState(() => _hovered = false); },
      child: GestureDetector(
        onTap: () => _launch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _hovered ? _border : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color:
                    _hovered ? _accent.withValues(alpha: 0.5) : _border),
          ),
          child: Center(
            child: FaIcon(widget.icon,
                size: 17,
                color: _hovered ? _accentLight : _textSub),
          ),
        ),
      ),
    );
  }
}

// ─── About ───────────────────────────────────────────────────────────────────

class _AboutSection extends StatelessWidget {
  final bool isMobile;
  const _AboutSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80, vertical: isMobile ? 40 : 56),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _border)),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Label('ABOUT'),
                const SizedBox(height: 12),
                Text('The full picture.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 30 : 40,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1)),
                const SizedBox(height: 32),
                _AboutText(),
                const SizedBox(height: 48),
                _ServicesList(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Label('ABOUT'),
                      const SizedBox(height: 12),
                      const Text('The full picture.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1)),
                      const SizedBox(height: 32),
                      _AboutText(),
                    ],
                  ),
                ),
                const SizedBox(width: 64),
                Expanded(
                  flex: 4,
                  child: _ServicesList(),
                ),
              ],
            ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: _textSub, fontSize: 16, height: 1.8);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "I'm a lead software engineer and open source contributor with a decade of experience "
          'building production systems. Currently at Manheim, I lead SRE/DevOps initiatives '
          'across onshore and offshore teams.',
          style: style,
        ),
        const SizedBox(height: 16),
        const Text(
          'I author and maintain open source projects across Ruby, Rust, and Flutter — '
          'including Lamby (Rails on Lambda), Crypteia (Rust Lambda extension), ruby_todo, '
          'revise_auth-jets, and eb_deployer. I\'ve also contributed to numerous Flutter '
          'and Ruby packages, and work heavily with AWS CDK and SAM in production.',
          style: style,
        ),
        const SizedBox(height: 16),
        const Text(
          'Through my LLC I provide development and consulting services to clients looking '
          'to build, scale, or modernize their software infrastructure.',
          style: style,
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _StatPill('3+', 'Years consulting'),
            _StatPill('OSS', 'Contributor'),
            _StatPill('AWS', 'Certified exp.'),
          ],
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  final String value, label;
  const _StatPill(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  color: _accent,
                  fontSize: 18,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(color: _textSub, fontSize: 11)),
        ],
      ),
    );
  }
}

class _ServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final services = [
      ('Full Mobile App Development', Icons.phone_iphone_outlined, _accent),
      ('Web Application Development', Icons.web_outlined, _cyan),
      ('Infrastructure & DevOps', Icons.cloud_outlined, _emerald),
      ('System Architecture Design', Icons.architecture_outlined, _amber),
      ('AWS Cost Optimization', Icons.savings_outlined, _emerald),
      ('Technical Consulting', Icons.lightbulb_outline, _cyan),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('What I Do',
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 20),
        ...services.map((s) => _ServiceRow(s.$1, s.$2, s.$3)),
      ],
    );
  }
}

class _ServiceRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _ServiceRow(this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

// ─── Skills ──────────────────────────────────────────────────────────────────

class _SkillsSection extends StatelessWidget {
  final bool isMobile;
  const _SkillsSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80, vertical: isMobile ? 36 : 48),
      decoration: const BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: _border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Label('STACK'),
          const SizedBox(height: 12),
          Text('Built with these.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 30 : 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1)),
          const SizedBox(height: 32),
          if (isMobile) ...[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: _SkillGroup('Mobile', ['Flutter', 'Dart', 'iOS', 'Android'], _accent)),
              const SizedBox(width: 24),
              Expanded(child: _SkillGroup('Backend', ['Ruby on Rails', 'Node.js', 'TypeScript', 'REST APIs'], _cyan)),
            ]),
            const SizedBox(height: 32),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: _SkillGroup('Cloud & DevOps', ['AWS', 'CDK', 'AWS SAM', 'Docker', 'Terraform', 'CI/CD'], _emerald)),
              const SizedBox(width: 24),
              Expanded(child: _SkillGroup('Data', ['Firebase', 'PostgreSQL', 'Redis'], _amber)),
            ]),
          ] else ...[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: _SkillGroup('Mobile', ['Flutter', 'Dart', 'iOS', 'Android'], _accent)),
              Expanded(child: _SkillGroup('Backend', ['Ruby on Rails', 'Node.js', 'TypeScript', 'REST APIs'], _cyan)),
              Expanded(child: _SkillGroup('Cloud & DevOps', ['AWS', 'CDK', 'AWS SAM', 'Docker', 'Terraform', 'CI/CD'], _emerald)),
              Expanded(child: _SkillGroup('Data', ['Firebase', 'PostgreSQL', 'Redis'], _amber)),
            ]),
          ],
        ],
      ),
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String category;
  final List<String> skills;
  final Color color;
  const _SkillGroup(this.category, this.skills, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(category,
              style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5)),
        ),
        const SizedBox(height: 18),
        ...skills.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: color)),
                  const SizedBox(width: 12),
                  Text(s,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            )),
      ],
    );
  }
}

// ─── Contact ─────────────────────────────────────────────────────────────────

class _ContactSection extends StatelessWidget {
  final bool isMobile;
  const _ContactSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80, vertical: isMobile ? 36 : 48),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              _GlowOrb(
                  color: _accent.withValues(alpha: 0.22), size: 400),
              Column(
                children: [
                  const _Label('CONTACT'),
                  const SizedBox(height: 12),
                  Text(
                    "Let's build something\ntogether",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 32 : 44,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.5,
                        height: 1.1),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Available for freelance projects,\nconsulting, and full-time roles.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _textSub,
                        fontSize: isMobile ? 15 : 17,
                        height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _ContactBtn(FontAwesomeIcons.envelope,
                          isMobile ? 'Email' : kEmailAddress,
                          'mailto:$kEmailAddress', _accent),
                      _ContactBtn(FontAwesomeIcons.linkedin, 'LinkedIn',
                          kLinkedInUrl, _cyan),
                      _ContactBtn(FontAwesomeIcons.github, 'GitHub',
                          kGithubUrl, _emerald),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(color: _border, height: 1),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('© 2026 Jeremiah Parrack',
                  style: TextStyle(color: _textSub, fontSize: 13)),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _launch(kResumeUrl),
                  child: const Text('View Resume →',
                      style: TextStyle(
                          color: _accentLight,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactBtn extends StatefulWidget {
  final FaIconData icon;
  final String label, url;
  final Color color;
  const _ContactBtn(this.icon, this.label, this.url, this.color);

  @override
  State<_ContactBtn> createState() => _ContactBtnState();
}

class _ContactBtnState extends State<_ContactBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) { if (mounted) setState(() => _hovered = true); },
      onExit: (_) { if (mounted) setState(() => _hovered = false); },
      child: GestureDetector(
        onTap: () => _launch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: _hovered ? 0.18 : 0.07),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: widget.color
                    .withValues(alpha: _hovered ? 0.7 : 0.25)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(widget.icon,
                  color: widget.color
                      .withValues(alpha: _hovered ? 1.0 : 0.7),
                  size: 15),
              const SizedBox(width: 10),
              Text(widget.label,
                  style: TextStyle(
                      color: _hovered
                          ? Colors.white
                          : widget.color.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Shared ───────────────────────────────────────────────────────────────────

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  static const _nums = {'ABOUT': '01', 'STACK': '02', 'CONTACT': '03'};

  @override
  Widget build(BuildContext context) {
    final num = _nums[text];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (num != null) ...[
          Text(num,
              style: const TextStyle(
                  color: _border,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1)),
          const SizedBox(width: 8),
          Container(width: 16, height: 1, color: _border),
          const SizedBox(width: 8),
        ],
        Text(text,
            style: const TextStyle(
                color: _accent,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 3.5)),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
