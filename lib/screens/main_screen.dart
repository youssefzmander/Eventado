import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/side_menu.dart';
import '../main.dart';
import 'createEvent/create.dart';

class MainScreen extends StatelessWidget {

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
