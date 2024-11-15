import 'dart:async';
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_site/about_me.dart';
import 'package:personal_site/const.dart';
import 'package:personal_site/contact_me.dart';
import 'package:personal_site/hero_banner.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int assetIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 4, milliseconds: 5), (timer) {
      setState(() {
        assetIndex++;
        if (assetIndex >= kAssets.length) assetIndex = 0;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Column resumeButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Resume"),
        const SizedBox(height: 4),
        IconButton(
          constraints: const BoxConstraints(maxHeight: 32),
          padding: EdgeInsets.zero,
          icon: const FaIcon(FontAwesomeIcons.fileWord),
          onPressed: () async {
            await launchUrl(
                Uri.parse("https://docs.google.com/document/d/104vzbtyoHl3syc6PHHk4KlmcbtloF76mo7jhL-HDcio/edit"));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "JEREMIAH PARRACK",
            style: textTheme.headlineMedium?.copyWith(color: Colors.white),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32),
            child: resumeButton(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            heroBanner(assetIndex, textTheme, screenSize),
            aboutMe(theme, context),
            contactMe(theme),
          ],
        ),
      ),
    );
  }
}
