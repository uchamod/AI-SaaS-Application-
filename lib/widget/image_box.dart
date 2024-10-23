import 'dart:io';

import 'package:ai_saas_application/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageBox extends StatelessWidget {
  final String? imagePath;
  const ImageBox({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: greyColor),
      child: Center(
        child: imagePath == null
            ? SvgPicture.asset(
                "assets/focus.svg",
                colorFilter:
                    const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
                height: 128,
                width: 128,
                semanticsLabel: 'My SVG Image',
              )
            : Image.file(
                File(imagePath!),
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
