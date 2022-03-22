import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageButtonNavigationBar extends StatefulWidget {
  final Function(int) onTap;
  final int currentIndex;
  const HomePageButtonNavigationBar(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  State<HomePageButtonNavigationBar> createState() =>
      _HomePageButtonNavigationBarState();
}

class _HomePageButtonNavigationBarState
    extends State<HomePageButtonNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: widget.onTap,
      currentIndex: widget.currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          label: "Explore",
          icon: Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          label: "My Events",
          icon: Icon(Icons.access_alarms),
        ),
        BottomNavigationBarItem(
          label: "Ticket",
          icon: Icon(FontAwesomeIcons.ticketAlt),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
