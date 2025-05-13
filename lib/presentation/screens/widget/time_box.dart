import 'package:flutter/material.dart';

import '../../../common/color.dart';

Widget timeBox({required String nowTime}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 1.5),
    child: Container(
      width: 20,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: timeColor
      ),
      child: Center(
        child: Text(
          nowTime,
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ),
    ),
  );
}