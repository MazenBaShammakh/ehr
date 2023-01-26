import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:dapp_ehr_1/widgets/option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      title: "Who are you?",
      content: Container(
        constraints: const BoxConstraints(maxWidth: kSpacingUnit * 50),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: kSpacingUnit * 5,
          crossAxisSpacing: kSpacingUnit * 5,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: OptionCard(
                child: defaultOptionCardChild(
                  icon: Icons.sick,
                  text: "Patient",
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: OptionCard(
                child: defaultOptionCardChild(
                  icon: Icons.medication,
                  text: "Doctor",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
