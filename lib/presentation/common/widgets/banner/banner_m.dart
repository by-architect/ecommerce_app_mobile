import 'package:ecommerce_app_mobile/presentation/common/widgets/network_image_with_loader.dart';
import 'package:flutter/material.dart';

class BannerM extends StatelessWidget {
  const BannerM({super.key, required this.image, required this.press, required this.children});

  final String image;
  final VoidCallback press;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.87,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: [
            NetworkImageWithLoader(image),
            Container(color: Colors.black45),
            ...children,
          ],
        ),
      ),
    );
  }
}
