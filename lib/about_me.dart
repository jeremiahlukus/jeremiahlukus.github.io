import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_site/const.dart';
import 'package:responsive_framework/responsive_framework.dart';

Container aboutMe(ThemeData theme, BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(color: theme.secondaryHeaderColor),
    child: Column(
      children: [
        Text(
          "ABOUT ME",
          style: theme.textTheme.displayMedium,
        ),
        ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowPadding: const EdgeInsets.all(30),
          columnPadding: const EdgeInsets.all(30),
          layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Lottie.asset(kCoffee),
                    const Text("I have been roasting my own coffee for over a decade now. I LOVE ESPRESSO!"),
                  ],
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Lottie.asset(kCollab),
                    const Text("I Work at Manheim full-time doing a mixture of work."
                        "Currently I am doing SRE/Devops work for 8 teams onshore and offshore."
                        "I also formed an LLC and I have been doing work on the side."
                        "This includes, consulting, full mobile app development, full web app development full deployment overhaul,"
                        "automating everything, adding monitoring/logging ect.."),
                  ],
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Lottie.asset(kGrad),
                    const Text(
                        "I Graduated with a B.A. in Computer Science from Georgia State with Cum Laude distinction"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
