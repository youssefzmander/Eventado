import 'package:admin/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

import '../../components/side_menu.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: SideMenu(),
          ),
          Expanded(
            flex: 5,
            child: Dashboard(),
          ),
        ],
      ),
    );
  }
}
