import 'package:dapp_ehr_1/constants.dart';
import 'package:flutter/material.dart';

class OptionCard extends StatefulWidget {
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
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: widget.onHover ??
          (value) {
            setState(() {
              isHovered = value;
            });
          },
      onTap: widget.onTap,
      child: Container(
        width: 160,
        height: 160,
        // constraints: BoxConstraints(minHeight: 160, maxHeight: 400),
        decoration: BoxDecoration(
          border: Border.all(
            color: isHovered ? kColor.withOpacity(0) : kColor.withOpacity(.2),
            width: 1,
            strokeAlign: StrokeAlign.outside,
          ),
          borderRadius: BorderRadius.circular(kSpacingUnit * 2),
          color: isHovered ? kColor.withOpacity(.2) : null,
        ),
        padding: const EdgeInsets.all(kSpacingUnit),
        child: widget.child,
      ),
    );
  }
}
