import 'package:flutter/material.dart';
import '../../../common/color.dart';

Widget countryIntroTemplate({required String introName, required IconData icon, required String countryInfo}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Text(
              introName,
              style: TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 16
              ),
            ),
            SizedBox(width: 2.5,),
            Icon(
              icon,
              size: 16,
            )
          ],
        ),
      ),
      Row(
        children: [
          Flexible(
            child: Text(
              countryInfo,
              style: TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: climateColor
              ),
            ),
          ),
        ],
      ),
    ],
  );
}