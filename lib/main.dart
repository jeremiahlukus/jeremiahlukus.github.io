import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:personal_site/home_page.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 350, name: MOBILE),
          const Breakpoint(start: 351, end: 600, name: TABLET),
          const Breakpoint(start: 601, end: 800, name: DESKTOP),
          const Breakpoint(start: 801, end: 1920, name: 'XL'),
        ],
      ),
      theme: FlexThemeData.light(scheme: FlexScheme.blueWhale),
      home: const MyHomePage(),
    );
  }
}
