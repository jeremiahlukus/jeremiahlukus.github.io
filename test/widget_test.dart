import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:personal_site/const.dart';
import 'package:personal_site/main.dart';

void main() {
  // Wide surface so the desktop branch of every responsive layout is exercised.
  Future<void> pumpSite(WidgetTester tester, {Size size = const Size(1400, 2400)}) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
  }

  testWidgets('renders the hero and every selected-work entry', (tester) async {
    await pumpSite(tester);

    expect(find.text('Jeremiah\nParrack'), findsOneWidget);
    expect(find.text('LEAD SOFTWARE ENGINEER'), findsOneWidget);

    for (final w in kWork) {
      expect(find.text(w.name), findsOneWidget, reason: 'missing work: ${w.name}');
    }
  });

  testWidgets('labels contributions as Contributor, not Author', (tester) async {
    await pumpSite(tester);

    final contributions = kWork.where((w) => w.role == 'Contributor').toList();
    expect(contributions, isNotEmpty);
    for (final w in contributions) {
      expect(find.text(w.name), findsOneWidget);
    }
    // Lamby, Crypteia and Lambdakiq are other people's projects; the badge has
    // to say so. Counted from the data so adding work cannot silently drop it.
    expect(find.text('CONTRIBUTOR'), findsNWidgets(contributions.length));
  });

  testWidgets('every work link is a valid absolute https url', (tester) async {
    for (final w in kWork) {
      for (final (label, url) in w.links) {
        final uri = Uri.tryParse(url);
        expect(uri, isNotNull, reason: '${w.name}/$label is unparseable');
        expect(uri!.isAbsolute, isTrue, reason: '${w.name}/$label is not absolute');
        expect(uri.scheme, 'https', reason: '${w.name}/$label is not https');
      }
    }
  });

  // Catches structural overflow at every breakpoint. Note the limit: widget
  // tests render with a fake font whose glyph metrics are integral, so overflows
  // that depend on real fractional text metrics (the IntrinsicWidth bug in
  // TextLink, for one) do NOT reproduce here and need a browser to catch.
  for (final (name, size) in const [
    ('mobile', Size(390, 3600)),
    ('mobile large', Size(600, 3600)),
    ('tablet', Size(900, 3200)),
    ('desktop', Size(1440, 2800)),
    ('wide', Size(1920, 2600)),
  ]) {
    testWidgets('$name layout builds without overflow', (tester) async {
      final errors = <FlutterErrorDetails>[];
      final prior = FlutterError.onError;
      FlutterError.onError = errors.add;
      addTearDown(() => FlutterError.onError = prior);

      await pumpSite(tester, size: size);

      expect(
        errors.map((e) => e.exceptionAsString()).toList(),
        isEmpty,
        reason: 'layout errors at $name (${size.width}x${size.height})',
      );
      expect(find.text('Jeremiah\nParrack'), findsOneWidget);
    });
  }

  testWidgets('nav and contact both link out to the resume of record',
      (tester) async {
    await pumpSite(tester);

    // The arrow marks it as leaving the site, unlike the in-app nav links.
    expect(find.text('résumé ↗'), findsOneWidget);
    expect(find.text('Résumé'), findsOneWidget);

    final uri = Uri.parse(kResumeUrl);
    expect(uri.scheme, 'https');
    expect(uri.host, 'docs.google.com');
  });

  testWidgets('footer exposes the privacy policy route', (tester) async {
    await pumpSite(tester);

    final privacy = find.text('Privacy policy');
    expect(privacy, findsOneWidget);

    await tester.ensureVisible(privacy);
    // ensureVisible starts a scroll animation; without settling it first the
    // tap lands on the pre-scroll position and never hits the link.
    await tester.pumpAndSettle();
    await tester.tap(privacy);
    await tester.pumpAndSettle();

    expect(find.text('PRIVACY POLICY'), findsOneWidget);
    // The Play Store rejection was about identifiers — keep them asserted.
    expect(
      find.text('FlowJitsu (com.jparrack.flowjitsu) · Jeremiah Parrack'),
      findsOneWidget,
    );
  });
}
