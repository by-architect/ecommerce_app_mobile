import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/skelton.dart';


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
          horizontal: AppSizes.defaultSpace, vertical: AppSizes.defaultSpace * 0.75),
      child: Row(
        children: [
          Skeleton(
            height: 32,
            width: 32,
            radious: 8,
          ),
          SizedBox(width: AppSizes.defaultSpace),
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