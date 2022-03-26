import 'package:flutter/material.dart';
import 'package:pim/drawer_widgets/messages.dart';
import 'package:pim/event_detail_page.dart';

import 'package:pim/widgets/home_bg_color.dart';
import '../constant/text_style.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/event_model.dart';
import '../utils/app_utils.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/nearby_event_card.dart';
import '../widgets/ui_helper.dart';
import '../widgets/upcoming_event_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

late int _currentIndex = 0;
final List<Widget> _interfaces = const [MyHomePage()];

final String _baseUrl = "10.0.2.2:3001";

late Future<bool> _fetchedEvents;

Future<bool> fetchEvents() async {
  http.Response response = await http.get(Uri.http(_baseUrl, "/event"));

  List<dynamic> eventsFromServer = json.decode(response.body);
  for (int i = 0; i < eventsFromServer.length; i++) {
    //if (eventsFromServer[i]["name"] != eventsFromServer[i + 1]["name"])
    upcomingEvents.add(Event(
        description: eventsFromServer[i]["description"],
        eventDate: eventsFromServer[i]["date"],
        image:
            'https://imgs.search.brave.com/Q3o3M6b6AzmVMmCUbOmHeA__FwUzWo9DVd8LHGNhwFk/rs:fit:704:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5f/cVRLTmtJLWJIQkFZ/ZWI4QnlpX05nSGFF/XyZwaWQ9QXBp',
        location: 'Tunisia',
        name: eventsFromServer[i]["name"],
        organizer: eventsFromServer[i]["organizer"],
        price: eventsFromServer[i]["Price"]));
  }
  print(eventsFromServer);

  return true;
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late ScrollController scrollController;
  late AnimationController controller;
  late AnimationController opacityController;
  late Animation<double> opacity;

  void viewEventDetail(Event event) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, animation, __) {
          return FadeTransition(
            opacity: animation,
            child: EventDetailPage(event),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    scrollController = ScrollController();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    opacityController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 1));
    opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: opacityController,
    ));
    scrollController.addListener(() {
      opacityController.value = offsetToOpacity(
          currentOffset: scrollController.offset,
          maxOffset: scrollController.position.maxScrollExtent / 2);
    });
    super.initState();
    _fetchedEvents = fetchEvents();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomeBackgroundColor(opacity),
          SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIHelper.verticalSpace(16),
                buildUpComingEventList(),
                UIHelper.verticalSpace(16),
                buildNearbyConcerts(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomePageButtonNavigationBar(
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Messages()));
        },
        child: const Icon(Icons.message),
      ),
    );
  }

  Widget buildUpComingEventList() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Upcoming Events",
              style: headerStyle.copyWith(color: Colors.white)),
          UIHelper.verticalSpace(16),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: upcomingEvents.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final event = upcomingEvents[index];
                return UpComingEventCard(
                    event: event, onTap: () => viewEventDetail(event));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNearbyConcerts() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text("Recommendations", style: headerStyle),
              const Spacer(),
              const Icon(Icons.more_horiz),
              UIHelper.horizontalSpace(16),
            ],
          ),
          ListView.builder(
            itemCount: nearbyEvents.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              final event = nearbyEvents[index];
              var animation = Tween<double>(begin: 800.0, end: 0.0).animate(
                CurvedAnimation(
                  parent: controller,
                  curve: Interval((1 / nearbyEvents.length) * index, 1.0,
                      curve: Curves.decelerate),
                ),
              );
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(animation.value, 0.0),
                  child: NearbyEventCard(
                    event: event,
                    onTap: () => viewEventDetail(event),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
