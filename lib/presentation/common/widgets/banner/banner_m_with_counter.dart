import 'dart:async';

import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../home/widget/blur_container.dart';
import 'banner_m.dart';

class BannerMWithCounter extends StatefulWidget {
  const BannerMWithCounter({
    super.key,
    required this.image,
    required this.text,
    required this.duration,
    required this.press,
  });

  final String image, text;
  final Duration duration;
  final VoidCallback press;

  @override
  State<BannerMWithCounter> createState() => _BannerMWithCounterState();
}

class _BannerMWithCounterState extends State<BannerMWithCounter> {
  late Duration _duration;
  late Timer _timer;

  @override
  void initState() {
    _duration = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: widget.image,
      press: widget.press,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppStyles.grandisExtendedFont,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSizes.defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlurContainer(
                  text: _duration.inHours.toString().padLeft(2, "0"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultPadding / 4),
                  child: SvgPicture.asset(AppImages.dot),
                ),
                BlurContainer(
                  text: _duration.inMinutes
                      .remainder(60)
                      .toString()
                      .padLeft(2, "0"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultPadding / 4),
                  child: SvgPicture.asset(AppImages.dot),
                ),
                BlurContainer(
                  text: _duration.inSeconds
                      .remainder(60)
                      .toString()
                      .padLeft(2, "0"),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
