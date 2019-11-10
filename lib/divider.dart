import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget getFqlDivider(BuildContext context, {double height, Color color}) {
  if (height == null) {
    height = getFqlDividerValue(context);
  }
  if (color == null) {
    color = getFqlDividerColor();
  }
  return Container(height: height, color: color);
}

Widget getFqlVerticalDivider(BuildContext context,
    {double width, Color color}) {
  if (width == null) {
    width = getFqlDividerValue(context);
  }
  if (color == null) {
    color = getFqlDividerColor();
  }
  return Container(width: width, color: color);
}

double getFqlDividerValue(BuildContext context) {
  return 1 / MediaQuery.of(context).devicePixelRatio;
}

Color getFqlDividerColor() {
  return Color(0xffDBDBDB);
}
