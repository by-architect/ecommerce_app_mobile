import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:flutter/material.dart';

import '../../common/skeleton/skelton.dart';


class DiscoverCategoriesSkeleton extends StatelessWidget {
  const DiscoverCategoriesSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => const _DiscoverCategorySkeleton(),
    );
  }
}

class _DiscoverCategorySkeleton extends StatelessWidget {
  const _DiscoverCategorySkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding * 0.75),
      child: Row(
        children: [
          Skeleton(
            height: 32,
            width: 32,
            radius: 8,
          ),
          SizedBox(width: AppSizes.defaultPadding),
          Expanded(
            flex: 2,
            child: Skeleton(),
          ),
          Spacer(),
        ],
      ),
    );
  }
}