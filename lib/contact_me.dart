import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Container contactMe(ThemeData theme) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(color: theme.primaryColorLight),
    child: Column(
      children: [
        Text(
          "CONTACT ME",
          style: theme.textTheme.headline2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              padding: const EdgeInsets.all(16),
              iconSize: 80,
              icon: const FaIcon(FontAwesomeIcons.envelope),
              onPressed: () async {
                final Uri _emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'jeremiahlukus1@gmail.com',
                  queryParameters: {'subject': 'Freelance Inquiry (Ref: WebSite)'},
                );
                await launch(_emailLaunchUri.toString());
              },
            ),
            IconButton(
              padding: const EdgeInsets.all(16),
              iconSize: 80,
              icon: const FaIcon(FontAwesomeIcons.linkedin),
              onPressed: () async {
                await launch("https://www.linkedin.com/in/jeremiahlukus/");
              },
            ),
            IconButton(
              padding: const EdgeInsets.all(16),
              iconSize: 80,
              icon: const FaIcon(FontAwesomeIcons.github),
              onPressed: () async {
                await launch("https://github.com/jeremiahlukus/");
              },
            ),
          ],
        ),
      ],
    ),
  );
}
