import 'package:flutter/material.dart';
import 'package:pim/UserHome/create_events_page.dart';
import 'package:pim/UserHome/explore.dart';
import 'package:pim/UserHome/notification.dart';

import '../drawer_widgets/Profile_page.dart';
import '../drawer_widgets/Settings.dart';
import '../drawer_widgets/bookmark.dart';
import '../drawer_widgets/messages.dart';
import '../main.dart';
class AdminHome extends StatefulWidget{
  const AdminHome({Key? key}) : super(key: key);
  @override
  AdminHomeState  createState() => AdminHomeState();

}

class AdminHomeState   extends State<AdminHome>{
  int currentIndex = 0;
  final screens = [
  Explore(),
    Notificationspage(),
    Messages(),
    Create(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:  color,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(color: color,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Image.asset("assets/images/user.jpg",height: 100,width: 100,)
                    ),
                    const SizedBox(width: 10,),
                    const Expanded(child: Text("Full Name"))
                  ],
                )
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text("My Profile"),
              onTap:() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>Profile(),
                    )
                );
              },
            ),
            const SizedBox(height: 20,),
            ListTile(
              leading: const  Icon(Icons.message_outlined),
              title: const Text("Message"),
              onTap:() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> Messages(),
                    ));
              },

            ),
            const SizedBox(height: 20,),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text("BookMark"),
              onTap:() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> Eventslist(),
                    ));
              },
            ),
            const SizedBox(height: 20,),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Seetings"),
              onTap:() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> Settings(),
                    ));
              },
            ),
            const SizedBox(height: 20,),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title:const Text("Sign Out"),
              onTap:() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> MyApp(),
                    )
                );
              },
            ),

          ],
        ),

      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore, ),
            label: "Explore",
            backgroundColor: color,),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, ),
            label: "Notification",
            backgroundColor: color,),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_sharp,),
            label: "message",),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_sharp,),
            label: " create",),
        ],
      ),
    );
  }
}