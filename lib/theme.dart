import 'package:flutter/material.dart';

/// Warm-dark palette. Deliberately narrow: one accent, one secondary, and a
/// three-step neutral ramp. Nothing gradient-filled.
abstract final class C {
  static const ink = Color(0xFF14110E); // page
  static const raise = Color(0xFF1C1815); // cards, hovered rows
  static const line = Color(0xFF2E2823); // hairlines
  static const bone = Color(0xFFEDE8E1); // primary text
  static const muted = Color(0xFF9C948A); // secondary text
  static const faint = Color(0xFF6B645C); // tertiary text, meta
  static const amber = Color(0xFFE0A356); // accent
  static const rust = Color(0xFFC0714A); // secondary accent, used sparingly
}

abstract final class F {
  static const sans = 'IBMPlexSans';
  static const mono = 'IBMPlexMono';
  static const serif = 'InstrumentSerif';
}

/// Monospace eyebrow/meta text. The wide tracking is the signature detail that
/// ties the nav, section headers, and table labels together.
TextStyle mono({
  double size = 11,
  Color color = C.faint,
  double tracking = 1.6,
  FontWeight weight = FontWeight.w400,
  double? height,
}) => TextStyle(
  fontFamily: F.mono,
  fontSize: size,
  color: color,
  letterSpacing: tracking,
  fontWeight: weight,
  height: height,
);

/// Instrument Serif display face, for the name and section headlines only.
TextStyle serif({
  required double size,
  Color color = C.bone,
  double height = 1.0,
  double tracking = -0.5,
}) => TextStyle(
  fontFamily: F.serif,
  fontSize: size,
  color: color,
  height: height,
  letterSpacing: tracking,
);

TextStyle sans({
  double size = 15,
  Color color = C.muted,
  double height = 1.7,
  FontWeight weight = FontWeight.w400,
  double tracking = 0,
}) => TextStyle(
  fontFamily: F.sans,
  fontSize: size,
  color: color,
  height: height,
  fontWeight: weight,
  letterSpacing: tracking,
);

ThemeData buildTheme() {
  const scheme = ColorScheme.dark(
    primary: C.amber,
    secondary: C.rust,
    surface: C.raise,
    onSurface: C.bone,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: C.ink,
    fontFamily: F.sans,
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color(0x33E0A356),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: C.bone,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
