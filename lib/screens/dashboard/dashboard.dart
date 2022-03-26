import 'package:admin/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/chart.dart';
import 'components/eventListcard.dart';
import 'components/header.dart';

class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const Header(),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      height: 500,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "User Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Chart(),
                          EventInfoCard(
                            title: "Om Kalthoum",
                            amountUser: '3',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
