import 'package:flutter/material.dart';

import 'package:personal_site/home_page.dart';
import 'package:personal_site/privacy_policy_page.dart';
import 'package:personal_site/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeremiah Parrack — Lead Software Engineer',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      initialRoute: '/',
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        builder: (_) => settings.name == '/privacy'
            ? const PrivacyPolicyPage()
            : const HomePage(),
      ),
    );
  }
}
