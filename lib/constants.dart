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
        Container(
          // width: double.infinity,
          // color: Colors.red,
          child: Icon(
            icon,
            // color: Colors.green,
            size: kSpacingUnit * 10,
          ),
        ),
        sizedBoxV(2),
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

Container constraint40(Widget child) => Container(
      constraints: const BoxConstraints(maxWidth: kSpacingUnit * 40),
      child: child,
    );

enum Sex { male, female }
