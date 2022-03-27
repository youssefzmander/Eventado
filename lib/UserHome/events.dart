import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:pim/widgets/bottom_navigation_bar.dart';
import 'dart:convert';

import 'Event_info.dart';

class Events extends StatefulWidget {
  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final List<EventsData> _events = [];
  late int _currentIndex = 0;
  final String _baseUrl = "10.0.2.2:3001";

  late Future<bool> _fetchedEvents;

  Future<bool> fetchEvents() async {
    http.Response response = await http.get(Uri.http(_baseUrl, "/event"));

    List<dynamic> eventsFromServer = json.decode(response.body);
    for (int i = 0; i < eventsFromServer.length; i++) {
      _events.add(EventsData(
        eventsFromServer[i]["_id"],
        eventsFromServer[i]["name"],
        eventsFromServer[i]["date"],
        eventsFromServer[i]["description"],
        eventsFromServer[i]["Price"].toString(),
        eventsFromServer[i]["organizer"],
      ));
    }
    print(eventsFromServer);

    return true;
  }

  @override
  void initState() {
    _fetchedEvents = fetchEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchedEvents,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          int _currentIndex;
          return Scaffold(
              backgroundColor: Color(0xFFEDECF2),
              appBar: AppBar(
                backgroundColor: Color(0xFFEDECF2),
                elevation: 0,
                title: const Text("My Events"),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (BuildContext context, int index) {
                  return EventInfo(
                      _events[index].name,
                      _events[index].date,
                      _events[index].description,
                      _events[index].price,
                      _events[index].organizer);
                },
              ),
              bottomNavigationBar: HomePageButtonNavigationBar(
                onTap: (index) => setState(() => _currentIndex = index),
                currentIndex: 1,
                //currentIndex: _currentIndex,
              ));
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class EventsData {
  final String id;
  final String name;
  final String date;
  final String description;
  final String price;
  final String organizer;

  EventsData(this.id, this.name, this.date, this.description, this.price,
      this.organizer);

  @override
  String toString() {
    return 'EventsData{id: $id, name: $name, date: $date, description: $description, Price: $price,organizer:$organizer}';
  }
}
