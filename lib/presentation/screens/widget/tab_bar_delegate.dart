import 'package:flutter/material.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  TabBarDelegate({required this.widget});

  Widget widget;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;

  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}