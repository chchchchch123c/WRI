import 'package:flutter/material.dart';

import '../../../common/color.dart';

Widget airPlaneCard({required String imageUrl, required String name}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Card(
        color: textFiledColor,
        child: SizedBox(
          height: 100,
          width: constraints.maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/air_plane/$imageUrl',
                      width: constraints.maxWidth * 0.35,
                      height: 30,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Spacer(),
                    Icon(
                      Icons.open_in_new_rounded,
                      size: 20,
                    ),
                    Text(
                      '바로가기',
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  );
}