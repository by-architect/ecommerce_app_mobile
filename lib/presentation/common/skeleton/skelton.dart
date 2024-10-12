import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:flutter/material.dart';


class Skeleton extends StatelessWidget {
  const Skeleton(
      {super.key,
        this.height,
        this.width,
        this.layer = 1,
        this.radius = AppSizes.defaultPadding});

  final double? height, width;
  final int layer;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
      decoration: BoxDecoration(
          color: Theme.of(context).iconTheme.color!.withOpacity(0.08 * layer),
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      // padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor.withOpacity(0.04),
        color: Theme.of(context).iconTheme.color!.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}