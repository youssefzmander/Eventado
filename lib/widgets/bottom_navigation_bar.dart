import 'package:flutter/material.dart';
import 'package:pim/UserHome/events.dart';
import 'package:pim/UserHome/home.dart';
import 'package:pim/drawer_widgets/Profile_page.dart';

class HomePageButtonNavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  HomePageButtonNavigationBar(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFEDECF2),
      onTap: (index) {
        if (index == 0)
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));

        if (index == 1)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Events()));
        ;
        if (index == 2)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
      },
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          label: "Explore",
          icon: Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          label: "My Events",
          icon: Icon(Icons.event),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          label: "Notifications",
          icon: Icon(Icons.notifications),
        ),
      ],
    );
  }
}
