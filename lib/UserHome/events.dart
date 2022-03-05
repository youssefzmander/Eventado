import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Event_info.dart';

class Events extends StatefulWidget {
  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final List<EventsData> _events = [];

  final String _baseUrl = "10.0.2.2:3001";

  late Future<bool> _fetchedEvents;

  Future<bool> fetchEvents() async {
    http.Response response = await http.get(Uri.http(_baseUrl, "/event"));

    List<dynamic> eventsFromServer = json.decode(response.body);

    for (int i = 0; i < eventsFromServer.length; i++) {
      _events.add(EventsData(
        eventsFromServer[i]["_id"],
        eventsFromServer[i]["name"],
      ));
    }

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
          return GridView.builder(
            itemCount: _events.length,
            itemBuilder: (BuildContext context, int index) {
              return EventInfo(_events[index].name);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 120,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class EventsData {
  final String id;
  final String name;

  EventsData(this.id, this.name);

  @override
  String toString() {
    return 'EventsData{id: $id, name: $name}';
  }
}
