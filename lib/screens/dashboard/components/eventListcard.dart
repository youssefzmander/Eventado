import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class EventInfoCard extends StatelessWidget {
  const EventInfoCard({
    Key? key,
    required this.title,
    required this.amountUser,
  }) : super(key: key);
  final String title, amountUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(Radius.circular(defaultPadding)),
      ),
      child: Row(children: [
        SizedBox(
          height: 20,
          width: 20,
          child: SvgPicture.asset("assets/icons/menu_profile.svg"),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  amountUser,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
