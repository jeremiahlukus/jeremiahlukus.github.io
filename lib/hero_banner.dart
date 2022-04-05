import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_site/const.dart';

Stack heroBanner(int index, TextTheme textTheme, Size size) {
  return Stack(
    children: [
      Hero(
        tag: "hero-banner",
        child: Image(
          image: const AssetImage("assets/space.jpg"),
          height: 600,
          width: size.width,
          fit: BoxFit.fill,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Center(child: SizedBox(height: 400, width: 400, child: Lottie.asset(kAssets[index]))),
            AutoSizeText(
              kAssetsDescription[index],
              style: textTheme.headlineLarge?.copyWith(color: Colors.white),
              maxLines: 2,
            ),
          ],
        ),
      ),
    ],
  );
}
