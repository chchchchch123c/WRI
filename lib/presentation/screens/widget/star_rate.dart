import 'package:flutter/material.dart';

import '../../../common/color.dart';

Widget starRate({required IconData iconData}) {
  return Row(
    children: [
      Icon(
        Icons.star_rounded,
        size: 18,
        color: starColor,
      ),
      Icon(
        Icons.star_rounded,
        size: 18,
        color: starColor,
      ),
      Icon(
        Icons.star_rounded,
        size: 18,
        color: starColor,
      ),
      Icon(
        Icons.star_rounded,
        size: 18,
        color: starColor,
      ),
      Icon(
        iconData,
        size: 18,
        color: starColor,
      ),
    ],
  );

}