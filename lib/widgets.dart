import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:personal_site/theme.dart';

void launchExternal(String url) => launchUrl(Uri.parse(url));

/// One hover primitive for the whole site. Replaces the six near-identical
/// StatefulWidgets the previous version carried, each tracking its own `_hovered`.
class Hoverable extends StatefulWidget {
  final Widget Function(bool hovered) builder;
  final VoidCallback onTap;
  const Hoverable({super.key, required this.builder, required this.onTap});

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: widget.builder(_h),
      ),
    );
  }
}

/// Section scaffold: numbered mono eyebrow, a rule, a serif headline, content.
/// The repeating 01/02/03 + rule motif is what gives the page its structure.
class Section extends StatelessWidget {
  final String index;
  final String label;
  final String title;
  final Widget child;
  final bool mobile;
  final double pad;
  final bool last;

  const Section({
    super.key,
    required this.index,
    required this.label,
    required this.title,
    required this.child,
    required this.mobile,
    required this.pad,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: pad,
        right: pad,
        top: mobile ? 56 : 88,
        bottom: last ? (mobile ? 64 : 96) : (mobile ? 56 : 88),
      ),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: C.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(index, style: mono(size: 10.5, color: C.amber, tracking: 1)),
              const SizedBox(width: 12),
              Container(width: 22, height: 1, color: C.line),
              const SizedBox(width: 12),
              Text(label, style: mono(size: 10, color: C.faint, tracking: 2.4)),
            ],
          ),
          SizedBox(height: mobile ? 18 : 22),
          Text(
            title,
            style: serif(
              size: mobile ? 32 : 46,
              height: 1.08,
              tracking: mobile ? -0.6 : -1.2,
            ),
          ),
          SizedBox(height: mobile ? 34 : 48),
          child,
        ],
      ),
    );
  }
}

class NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const NavLink(this.label, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: onTap,
      builder: (h) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label,
                style: mono(
                    size: 11.5,
                    color: h ? C.bone : C.muted,
                    tracking: 0.8)),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 1,
              width: h ? 16 : 0,
              color: C.amber,
            ),
          ],
        ),
      ),
    );
  }
}

class SolidButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const SolidButton(this.label, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: onTap,
      builder: (h) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        decoration: BoxDecoration(
          color: h ? C.bone : C.amber,
        ),
        child: Text(
          label,
          style: mono(
              size: 11.5,
              color: C.ink,
              tracking: 1.2,
              weight: FontWeight.w500),
        ),
      ),
    );
  }
}

class GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const GhostButton(this.label, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: onTap,
      builder: (h) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: h ? C.bone : C.line),
        ),
        child: Text(
          label,
          style: mono(
              size: 11.5,
              color: h ? C.bone : C.muted,
              tracking: 1.2,
              weight: FontWeight.w500),
        ),
      ),
    );
  }
}

/// Underline-on-hover text link, used instead of icon glyphs so the site
/// carries no icon font.
class TextLink extends StatelessWidget {
  final String label;
  final String url;
  const TextLink(this.label, this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    // The underline is a bottom border rather than a sibling in a Column, so it
    // spans exactly the label width with no intrinsic-sizing pass. IntrinsicWidth
    // rounds fractional text metrics down and overflowed the Row by ~1.6px.
    return Hoverable(
      onTap: () => launchExternal(url),
      builder: (h) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: h ? C.amber : Colors.transparent),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label,
                style: mono(
                    size: 12,
                    color: h ? C.amber : C.bone,
                    tracking: 0.6,
                    weight: FontWeight.w500)),
            const SizedBox(width: 6),
            Text('↗',
                style: TextStyle(
                    fontFamily: F.mono,
                    fontSize: 11,
                    color: h ? C.amber : C.faint)),
          ],
        ),
      ),
    );
  }
}
