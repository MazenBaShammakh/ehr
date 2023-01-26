import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/widgets/page_title.dart';
import 'package:flutter/material.dart';

class DefaultBody extends StatelessWidget {
  const DefaultBody({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .25,
        vertical: kSpacingUnit * 15,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFFEFBE9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PageTitle(title),
          sizedBoxV(10),
          content,
        ],
      ),
    );
  }
}
