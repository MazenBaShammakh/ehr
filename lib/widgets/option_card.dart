import 'package:dapp_ehr_1/constants.dart';
import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    this.onHover,
    this.onTap,
    required this.child,
  });

  final Function(bool val)? onHover;
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: onHover,
      onTap: onTap,
      child: Container(
        width: 160,
        height: 160,
        // constraints: BoxConstraints(minHeight: 160, maxHeight: 400),
        decoration: BoxDecoration(
          border: Border.all(
            // color: Colors.green,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(kSpacingUnit * 2),
        ),
        padding: const EdgeInsets.all(kSpacingUnit),
        child: child,
      ),
    );
  }
}
