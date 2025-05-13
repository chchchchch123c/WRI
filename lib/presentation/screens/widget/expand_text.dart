import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../common/color.dart';

Widget expandText({required String text}) {
  bool isExpanded = false;

  return LayoutBuilder(
    builder: (context, constraints) {
      final textStyle = const TextStyle(
        fontFamily: 'inter',
        fontWeight: FontWeight.w400,
        color: countryInfoTextColor,
      );

      final textPainter = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        maxLines: 3,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: constraints.maxWidth);

      final bool isOverflow = textPainter.didExceedMaxLines;

      String firstPart = text;
      String remainingPart = '';

      if (isOverflow) {
        final endIndex = textPainter.getPositionForOffset(Offset(
            constraints.maxWidth, textPainter.height),).offset;
        firstPart = text.substring(0, endIndex).trim();
        remainingPart = text.substring(endIndex).trim();
      }

      return StatefulBuilder(
        builder: (context, localSetState) {
          return remainingPart.isEmpty
              ? Text(text, style: textStyle)
              : isExpanded
              ? RichText(
                text: TextSpan(
                  style: textStyle,
                  children: [
                    TextSpan(text: '$text '),
                    TextSpan(
                      text: '간략히',
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: kBlack,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              localSetState(() {
                                isExpanded = false;
                              });
                            },
                    ),
                  ],
                ),
              )
              : RichText(
                text: TextSpan(
                  style: textStyle,
                  children: [
                    TextSpan(text: '$firstPart... '),
                    TextSpan(
                      text: '더보기',
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: kBlack,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              localSetState(() {
                                isExpanded = true;
                              });
                            },
                    ),
                  ],
                ),
              );
        },
      );
    },
  );
}
