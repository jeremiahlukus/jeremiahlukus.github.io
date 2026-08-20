import 'package:flutter/material.dart';

import 'package:personal_site/const.dart';
import 'package:personal_site/resume_data.dart';
import 'package:personal_site/theme.dart';
import 'package:personal_site/widgets.dart';

const _kMobile = 760.0;
const _kMaxContent = 900.0;

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final mobile = w < _kMobile;
    final pad = mobile ? 22.0 : 48.0;

    return Scaffold(
      backgroundColor: C.ink,
      appBar: AppBar(
        backgroundColor: C.ink,
        titleSpacing: 0,
        title: Text('RÉSUMÉ', style: mono(size: 11, color: C.bone, tracking: 2.2)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: C.muted, size: 20),
          tooltip: 'Back',
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
        shape: const Border(bottom: BorderSide(color: C.line)),
      ),
      // SelectionArea makes the whole resume selectable and copyable, which a
      // Flutter canvas does not give you for free.
      body: SelectionArea(
        child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _kMaxContent),
            child: Padding(
              padding: EdgeInsets.fromLTRB(pad, mobile ? 34 : 52, pad, 72),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(mobile: mobile),
                  SizedBox(height: mobile ? 30 : 40),
                  _Block(
                    label: 'SUMMARY',
                    mobile: mobile,
                    child: Text(kResumeSummary,
                        style: sans(size: mobile ? 14 : 15, height: 1.75)),
                  ),
                  _Block(
                    label: 'EXPERIENCE',
                    mobile: mobile,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final r in kRoles) _RoleBlock(role: r, mobile: mobile),
                      ],
                    ),
                  ),
                  _Block(
                    label: 'OPEN SOURCE',
                    mobile: mobile,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final (group, items) in kOssGroups) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 12),
                            child: Text(group.toUpperCase(),
                                style: mono(
                                    size: 9.5, color: C.rust, tracking: 1.6)),
                          ),
                          for (final b in items)
                            _BulletRow(bullet: b, mobile: mobile),
                          const SizedBox(height: 14),
                        ],
                      ],
                    ),
                  ),
                  _Block(
                    label: 'TECHNICAL SKILLS',
                    mobile: mobile,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final (k, v) in kSkills)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: mobile
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(k.toUpperCase(),
                                          style: mono(
                                              size: 9,
                                              color: C.amber,
                                              tracking: 1.5)),
                                      const SizedBox(height: 4),
                                      Text(v, style: sans(size: 13.5, height: 1.55)),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 132,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3),
                                          child: Text(k.toUpperCase(),
                                              style: mono(
                                                  size: 9,
                                                  color: C.amber,
                                                  tracking: 1.5)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(v,
                                            style:
                                                sans(size: 14, height: 1.6)),
                                      ),
                                    ],
                                  ),
                          ),
                      ],
                    ),
                  ),
                  _Block(
                    label: 'EDUCATION',
                    mobile: mobile,
                    last: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(kEducation.$1,
                            style: serif(size: mobile ? 20 : 23, tracking: -0.3)),
                        const SizedBox(height: 7),
                        Text(kEducation.$2,
                            style: sans(size: mobile ? 13.5 : 14.5, height: 1.6)),
                        const SizedBox(height: 5),
                        Text(kEducation.$3,
                            style: mono(size: 10.5, color: C.faint, tracking: 1)),
                      ],
                    ),
                  ),
                  SizedBox(height: mobile ? 34 : 44),
                  Container(height: 1, color: C.line),
                  const SizedBox(height: 22),
                  _DownloadRow(mobile: mobile),
                ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool mobile;
  const _Header({required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(kResumeName,
            style: serif(
                size: mobile ? 44 : 60,
                height: 1.0,
                tracking: mobile ? -1 : -2)),
        const SizedBox(height: 14),
        Text(kResumeTitle,
            style: mono(size: mobile ? 10.5 : 12, color: C.amber, tracking: 1.4)),
        const SizedBox(height: 18),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(kResumeLocation,
                style: mono(size: 11, color: C.muted, tracking: 0.4)),
            _MetaLink(kEmailAddress, 'mailto:$kEmailAddress'),
            _MetaLink('github.com/jeremiahlukus', kGithubUrl),
            _MetaLink('linkedin.com/in/jeremiahlukus', kLinkedInUrl),
          ],
        ),
        const SizedBox(height: 24),
        _DownloadButton(),
      ],
    );
  }
}

class _MetaLink extends StatelessWidget {
  final String label;
  final String url;
  const _MetaLink(this.label, this.url);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: () => launchExternal(url),
      builder: (h) => Text(label,
          style: mono(
              size: 11,
              color: h ? C.amber : C.muted,
              tracking: 0.4)),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: () => launchExternal(kResumePdfPath),
      builder: (h) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        color: h ? C.bone : C.amber,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('DOWNLOAD PDF',
                style: mono(
                    size: 11,
                    color: C.ink,
                    tracking: 1.4,
                    weight: FontWeight.w500)),
            const SizedBox(width: 9),
            Text('↓',
                style: TextStyle(
                    fontFamily: F.mono, fontSize: 12, color: C.ink)),
          ],
        ),
      ),
    );
  }
}

class _DownloadRow extends StatelessWidget {
  final bool mobile;
  const _DownloadRow({required this.mobile});

  @override
  Widget build(BuildContext context) {
    final back = Hoverable(
      onTap: () => Navigator.of(context).pushReplacementNamed('/'),
      builder: (h) => Text('← Back to site',
          style: mono(
              size: 11, color: h ? C.amber : C.muted, tracking: 0.6)),
    );
    return mobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_DownloadButton(), const SizedBox(height: 18), back],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_DownloadButton(), back],
          );
  }
}

/// Section wrapper: mono label in a left column on desktop, stacked on mobile.
class _Block extends StatelessWidget {
  final String label;
  final Widget child;
  final bool mobile;
  final bool last;
  const _Block({
    required this.label,
    required this.child,
    required this.mobile,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: mobile ? 26 : 32, bottom: last ? 0 : 4),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: C.line)),
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: mono(size: 9.5, color: C.amber, tracking: 2.2)),
                const SizedBox(height: 16),
                child,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(label,
                        style: mono(size: 9.5, color: C.amber, tracking: 2.2)),
                  ),
                ),
                Expanded(child: child),
              ],
            ),
    );
  }
}

class _RoleBlock extends StatelessWidget {
  final Role role;
  final bool mobile;
  const _RoleBlock({required this.role, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: mobile ? 30 : 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(role.title,
              style: serif(size: mobile ? 22 : 26, tracking: -0.4, height: 1.15)),
          const SizedBox(height: 7),
          if (mobile) ...[
            Text(role.org,
                style: mono(size: 11, color: C.bone, tracking: 0.4)),
            const SizedBox(height: 4),
            Text(role.dates,
                style: mono(size: 10, color: C.faint, tracking: 0.8)),
          ] else
            Row(
              children: [
                Text(role.org,
                    style: mono(size: 11.5, color: C.bone, tracking: 0.4)),
                const SizedBox(width: 12),
                Expanded(child: Container(height: 1, color: C.line)),
                const SizedBox(width: 12),
                Text(role.dates,
                    style: mono(size: 10.5, color: C.faint, tracking: 0.8)),
              ],
            ),
          const SizedBox(height: 10),
          Text(role.blurb,
              style: sans(
                  size: mobile ? 12.5 : 13,
                  color: C.faint,
                  height: 1.6)),
          const SizedBox(height: 14),
          for (final b in role.bullets) _BulletRow(bullet: b, mobile: mobile),
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final Bullet bullet;
  final bool mobile;
  const _BulletRow({required this.bullet, required this.mobile});

  @override
  Widget build(BuildContext context) {
    final size = mobile ? 13.5 : 14.0;
    return Padding(
      padding: EdgeInsets.only(left: bullet.sub ? 20 : 0, bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, right: 11),
            child: Container(
              width: bullet.sub ? 3 : 4,
              height: bullet.sub ? 3 : 4,
              color: bullet.sub ? C.faint : C.amber,
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(children: [
                if (bullet.lead.isNotEmpty)
                  TextSpan(
                    text: bullet.lead,
                    style: sans(
                        size: size,
                        color: C.bone,
                        height: 1.65,
                        weight: FontWeight.w600),
                  ),
                TextSpan(
                  text: bullet.text,
                  style: sans(size: size, height: 1.65),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
