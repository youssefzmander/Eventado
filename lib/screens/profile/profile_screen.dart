import 'package:admin/screens/profile/profile.dart';
import 'package:flutter/material.dart';

import '../../components/side_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
            child: Profile(),
          ),
        ],
      ),
    );
  }
}
