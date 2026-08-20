import 'package:flutter/material.dart';

import 'package:personal_site/const.dart';
import 'package:personal_site/resume_data.dart';
import 'package:personal_site/theme.dart';
import 'package:personal_site/widgets.dart';

/// Layout breakpoints. Kept local rather than pulled from a package — two
/// thresholds is all this site needs.
const _kMobile = 760.0;
const _kNarrow = 1040.0;
const _kMaxContent = 1140.0;

double _gutter(double w) => w < _kMobile ? 22 : (w < _kNarrow ? 40 : 64);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scroll = ScrollController();
  final _work = GlobalKey();
  final _about = GlobalKey();
  final _contact = GlobalKey();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _to(GlobalKey k) {
    final ctx = k.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 620),
      curve: Curves.easeOutCubic,
      alignment: 0.06,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final mobile = w < _kMobile;
    final pad = _gutter(w);

    return Scaffold(
      backgroundColor: C.ink,
      body: Scrollbar(
        controller: _scroll,
        child: CustomScrollView(
          controller: _scroll,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _NavBar(
                mobile: mobile,
                pad: pad,
                onWork: () => _to(_work),
                onAbout: () => _to(_about),
                onContact: () => _to(_contact),
                onHome: () => _scroll.animateTo(0,
                    duration: const Duration(milliseconds: 620),
                    curve: Curves.easeOutCubic),
                onResume: () =>
                    Navigator.of(context).pushNamed('/resume'),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _kMaxContent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Hero(mobile: mobile, pad: pad, onWork: () => _to(_work)),
                      _WorkSection(key: _work, mobile: mobile, pad: pad),
                      _AboutSection(key: _about, mobile: mobile, pad: pad),
                      _StackSection(mobile: mobile, pad: pad),
                      _ContactSection(key: _contact, mobile: mobile, pad: pad),
                      _Footer(mobile: mobile, pad: pad),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Nav ─────────────────────────────────────────────────────────────────────

class _NavBar extends SliverPersistentHeaderDelegate {
  final bool mobile;
  final double pad;
  final VoidCallback onWork, onAbout, onContact, onHome, onResume;

  _NavBar({
    required this.mobile,
    required this.pad,
    required this.onWork,
    required this.onAbout,
    required this.onContact,
    required this.onHome,
    required this.onResume,
  });

  static const _h = 66.0;

  @override
  double get minExtent => _h;
  @override
  double get maxExtent => _h;

  @override
  Widget build(BuildContext context, double shrink, bool overlaps) {
    // Only show the rule once the page has actually scrolled, so the nav sits
    // flush against the hero at rest.
    final scrolled = shrink > 4 || overlaps;
    return ClipRect(
      // Fully opaque: at 94% the work rows scrolled visibly through the bar.
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _h,
          decoration: BoxDecoration(
            color: C.ink,
            border: Border(
              bottom: BorderSide(
                color: scrolled ? C.line : Colors.transparent,
              ),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _kMaxContent),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: pad),
                child: Row(
                  children: [
                    // Wordmark: type, not a gradient chip.
                    Hoverable(
                      onTap: onHome,
                      builder: (h) => Row(
                        children: [
                          Container(width: 7, height: 7, color: C.amber),
                          const SizedBox(width: 11),
                          Text(
                            'jeremiah parrack',
                            style: mono(
                              size: 12.5,
                              color: C.bone,
                              tracking: 0.4,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (!mobile) ...[
                      NavLink('work', onWork),
                      NavLink('about', onAbout),
                      NavLink('contact', onContact),
                      const SizedBox(width: 18),
                      Container(width: 1, height: 16, color: C.line),
                      const SizedBox(width: 18),
                    ],
                    Hoverable(
                      onTap: onResume,
                      builder: (h) => Text(
                        'résumé',
                        style: mono(
                          size: 11.5,
                          color: h ? C.amber : C.bone,
                          tracking: 0.8,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  @override
  bool shouldRebuild(_NavBar old) => old.mobile != mobile || old.pad != pad;
}

// ─── Hero ────────────────────────────────────────────────────────────────────

class _Hero extends StatelessWidget {
  final bool mobile;
  final double pad;
  final VoidCallback onWork;
  const _Hero({required this.mobile, required this.pad, required this.onWork});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final narrow = w < _kNarrow;

    final name = Text(
      'Jeremiah\nParrack',
      style: serif(
        size: mobile ? 62 : (narrow ? 84 : 104),
        height: 0.92,
        tracking: mobile ? -1 : -2.5,
      ),
    );

    final lede = Text(
      'Nine years building production systems and the infrastructure they run on.',
      style: sans(size: mobile ? 16 : 18, height: 1.65, color: C.muted),
    );

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('LEAD SOFTWARE ENGINEER',
                style: mono(size: 11, color: C.amber, tracking: 2.4)),
            const SizedBox(width: 12),
            Expanded(child: Container(height: 1, color: C.line)),
          ],
        ),
        SizedBox(height: mobile ? 26 : 34),
        name,
        SizedBox(height: mobile ? 24 : 30),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: lede,
        ),
        SizedBox(height: mobile ? 30 : 38),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SolidButton('Selected work', onWork),
            GhostButton('Get in touch', () => launchExternal('mailto:$kEmailAddress')),
          ],
        ),
      ],
    );

    final facts = _FactsTable(mobile: mobile);

    return Padding(
      padding: EdgeInsets.only(
        left: pad,
        right: pad,
        top: mobile ? 56 : 92,
        bottom: mobile ? 64 : 104,
      ),
      child: narrow
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [left, SizedBox(height: mobile ? 52 : 64), facts],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(flex: 6, child: left),
                const SizedBox(width: 72),
                Expanded(flex: 5, child: facts),
              ],
            ),
    );
  }
}

/// Replaces the old fake `profile.dart` editor window. Same visual slot, but
/// every line is a real, verifiable fact.
class _FactsTable extends StatelessWidget {
  final bool mobile;
  const _FactsTable({required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: C.line),
        color: C.raise.withValues(alpha: 0.45),
      ),
      child: Column(
        children: [
          for (var i = 0; i < kFacts.length; i++)
            Container(
              decoration: BoxDecoration(
                border: i == 0
                    ? null
                    : const Border(top: BorderSide(color: C.line)),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: mobile ? 16 : 20, vertical: mobile ? 13 : 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mobile ? 96 : 116,
                    child: Text(kFacts[i].$1,
                        style: mono(size: 9.5, color: C.faint, tracking: 1.5)),
                  ),
                  Expanded(
                    child: Text(
                      kFacts[i].$2,
                      style: mono(
                        size: mobile ? 12 : 12.5,
                        color: i == kFacts.length - 1 ? C.amber : C.bone,
                        tracking: 0.2,
                        height: 1.45,
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
}

// ─── 01 Work ─────────────────────────────────────────────────────────────────

class _WorkSection extends StatelessWidget {
  final bool mobile;
  final double pad;
  const _WorkSection({super.key, required this.mobile, required this.pad});

  @override
  Widget build(BuildContext context) {
    return Section(
      index: '01',
      label: 'SELECTED WORK',
      title: 'Things I have shipped\nand contributed to.',
      mobile: mobile,
      pad: pad,
      child: Column(
        children: [
          for (var i = 0; i < kWork.length; i++)
            _WorkRow(work: kWork[i], first: i == 0, mobile: mobile),
          // Closes the list; without it the last row reads as unfinished.
          Container(height: 1, color: C.line),
        ],
      ),
    );
  }
}

class _WorkRow extends StatefulWidget {
  final Work work;
  final bool first;
  final bool mobile;
  const _WorkRow({required this.work, required this.first, required this.mobile});

  @override
  State<_WorkRow> createState() => _WorkRowState();
}

class _WorkRowState extends State<_WorkRow> {
  bool _h = false;

  Color get _roleColor => switch (widget.work.role) {
        'Contributor' => C.rust,
        'DevOps' => C.amber,
        _ => C.faint,
      };

  @override
  Widget build(BuildContext context) {
    final work = widget.work;
    final mobile = widget.mobile;

    // Rows with no public listing must not look clickable.
    final tappable = work.links.isNotEmpty;

    final body = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: _h && tappable ? C.raise : Colors.transparent,
        border: const Border(top: BorderSide(color: C.line)),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: mobile ? 4 : 12, vertical: mobile ? 20 : 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 3,
            height: mobile ? 40 : 34,
            color: _h && tappable ? C.amber : Colors.transparent,
            margin: EdgeInsets.only(right: mobile ? 12 : 18),
          ),
          Expanded(
            child: mobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titleRow(),
                      const SizedBox(height: 9),
                      Text(work.blurb, style: sans(size: 13.5, height: 1.6)),
                      const SizedBox(height: 12),
                      Text(work.meta,
                          style: mono(size: 10, color: C.faint, tracking: 1.1)),
                      if (tappable) ...[
                        const SizedBox(height: 12),
                        _links(),
                      ],
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titleRow(),
                            const SizedBox(height: 10),
                            Text(work.meta,
                                style: mono(
                                    size: 10.5, color: C.faint, tracking: 1.1)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 28),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(work.blurb,
                                  style: sans(size: 14.5, height: 1.65)),
                              if (tappable) ...[
                                const SizedBox(height: 13),
                                _links(),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );

    if (!tappable) return body;

    // Hover state lives on the row so the whole row lights up, but the actual
    // navigation targets are the individual link chips.
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: body,
    );
  }

  Widget _titleRow() {
    final work = widget.work;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 6,
      children: [
        Text(work.name,
            style: serif(
                size: widget.mobile ? 25 : 29,
                color: _h && work.links.isNotEmpty ? C.amber : C.bone,
                height: 1.05,
                tracking: -0.4)),
        // Author vs Contributor stated on every row, so the distinction is
        // impossible to misread.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            border: Border.all(color: _roleColor.withValues(alpha: 0.5)),
          ),
          child: Text(work.role.toUpperCase(),
              style: mono(size: 8.5, color: _roleColor, tracking: 1.3)),
        ),
      ],
    );
  }

  Widget _links() => Wrap(
        spacing: 18,
        runSpacing: 8,
        children: [
          for (final (label, url) in widget.work.links)
            Hoverable(
              onTap: () => launchExternal(url),
              builder: (lh) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label,
                      style: mono(
                          size: 10.5,
                          color: lh ? C.amber : C.bone,
                          tracking: 0.9,
                          weight: FontWeight.w500)),
                  const SizedBox(width: 5),
                  Text('↗',
                      style: TextStyle(
                          fontFamily: F.mono,
                          fontSize: 10,
                          color: lh ? C.amber : C.faint)),
                ],
              ),
            ),
        ],
      );
}

// ─── 02 About ────────────────────────────────────────────────────────────────

class _AboutSection extends StatelessWidget {
  final bool mobile;
  final double pad;
  const _AboutSection({super.key, required this.mobile, required this.pad});

  @override
  Widget build(BuildContext context) {
    final prose = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final p in kAboutParagraphs) ...[
          Text(p, style: sans(size: mobile ? 14.5 : 15.5, height: 1.8)),
          const SizedBox(height: 18),
        ],
      ],
    );

    final services = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('WHAT I DO', style: mono(size: 10, color: C.amber, tracking: 2.2)),
        const SizedBox(height: 20),
        for (var i = 0; i < kServices.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                  child: Text('0${i + 1}',
                      style: mono(size: 10.5, color: C.faint, tracking: 0.8)),
                ),
                Expanded(
                  child: Text(kServices[i],
                      style: sans(
                          size: 14.5, color: C.bone, height: 1.5)),
                ),
              ],
            ),
          ),
      ],
    );

    return Section(
      index: '02',
      label: 'ABOUT',
      title: 'The full picture.',
      mobile: mobile,
      pad: pad,
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [prose, const SizedBox(height: 36), services],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: prose),
                const SizedBox(width: 72),
                Expanded(flex: 4, child: services),
              ],
            ),
    );
  }
}

// ─── 03 Stack ────────────────────────────────────────────────────────────────

class _StackSection extends StatelessWidget {
  final bool mobile;
  final double pad;
  const _StackSection({required this.mobile, required this.pad});

  @override
  Widget build(BuildContext context) {
    return Section(
      index: '03',
      label: 'STACK',
      title: 'Tools I reach for.',
      mobile: mobile,
      pad: pad,
      child: Wrap(
        spacing: mobile ? 28 : 56,
        runSpacing: 34,
        children: [
          for (final (label, items) in kStack)
            SizedBox(
              width: mobile ? 132 : 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: mono(size: 9.5, color: C.amber, tracking: 1.8)),
                  const SizedBox(height: 8),
                  Container(height: 1, color: C.line),
                  const SizedBox(height: 14),
                  for (final it in items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Text(it,
                          style: sans(
                              size: 14, color: C.bone, height: 1.4)),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ─── 04 Contact ──────────────────────────────────────────────────────────────

class _ContactSection extends StatelessWidget {
  final bool mobile;
  final double pad;
  const _ContactSection({super.key, required this.mobile, required this.pad});

  @override
  Widget build(BuildContext context) {
    return Section(
      index: '04',
      label: 'CONTACT',
      title: "Let's build something.",
      mobile: mobile,
      pad: pad,
      last: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              'Available for freelance projects, consulting, and full-time roles. '
              'The fastest way to reach me is email.',
              style: sans(size: mobile ? 14.5 : 15.5, height: 1.75),
            ),
          ),
          SizedBox(height: mobile ? 30 : 38),
          // The email address itself as the primary affordance, set large.
          Hoverable(
            onTap: () => launchExternal('mailto:$kEmailAddress'),
            builder: (h) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kEmailAddress,
                  style: TextStyle(
                    fontFamily: F.mono,
                    fontSize: mobile ? 16 : 24,
                    color: h ? C.amber : C.bone,
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 7),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 1,
                  width: h ? (mobile ? 210 : 310) : 44,
                  color: h ? C.amber : C.line,
                ),
              ],
            ),
          ),
          SizedBox(height: mobile ? 34 : 44),
          Wrap(
            spacing: 26,
            runSpacing: 14,
            children: [
              TextLink('GitHub', kGithubUrl),
              TextLink('LinkedIn', kLinkedInUrl),
              // url is the PDF so the label still means something if the
              // route ever fails; onTap keeps the normal path in-app.
              TextLink('Résumé', kResumePdfPath,
                  onTap: () => Navigator.of(context).pushNamed('/resume')),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Footer ──────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  final bool mobile;
  final double pad;
  const _Footer({required this.mobile, required this.pad});

  @override
  Widget build(BuildContext context) {
    final left = Text('© 2026 Jeremiah Parrack',
        style: mono(size: 10.5, color: C.faint, tracking: 0.8));

    final right = Wrap(
      spacing: 22,
      runSpacing: 10,
      children: [
        Hoverable(
          onTap: () => Navigator.of(context).pushNamed('/privacy'),
          builder: (h) => Text('Privacy policy',
              style: mono(
                  size: 10.5,
                  color: h ? C.amber : C.faint,
                  tracking: 0.8)),
        ),
        Text('Built with Flutter',
            style: mono(size: 10.5, color: C.faint, tracking: 0.8)),
      ],
    );

    return Container(
      padding: EdgeInsets.fromLTRB(pad, 26, pad, 34),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: C.line)),
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [left, const SizedBox(height: 14), right],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [left, right],
            ),
    );
  }
}
