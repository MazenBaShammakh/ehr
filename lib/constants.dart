import 'package:flutter/material.dart';

const double kSpacingUnit = 8.0;

SizedBox sizedBoxH(int factor) => SizedBox(width: kSpacingUnit * factor);
SizedBox sizedBoxV(int factor) => SizedBox(height: kSpacingUnit * factor);
Spacer spacer({int flex = 1}) => Spacer(flex: flex);

Column defaultOptionCardChild({required IconData icon, required String text}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: kSpacingUnit * 10,
        ),
        sizedBoxV(2),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

Container constraint40(Widget child) => Container(
      constraints: const BoxConstraints(maxWidth: kSpacingUnit * 40),
      child: child,
    );

enum Sex { male, female }

Color kColor = const Color(0xFF008624);
Map<int, Color> _materialColor = {
  50: kColor,
  100: kColor,
  200: kColor,
  300: kColor,
  400: kColor,
  500: kColor,
  600: kColor,
  700: kColor,
  800: kColor,
  900: kColor,
};
MaterialColor kMaterialColor = MaterialColor(kColor.value, _materialColor);
