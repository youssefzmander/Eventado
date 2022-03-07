import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'event_detail.dart';

class EventInfo extends StatelessWidget {
  final String _name;
  final String _date;
  final String _description;
  final String _nbrMax;

  const EventInfo(this._name, this._date, this._description, this._nbrMax);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("eventName", _name);
          prefs.setString("eventDate", _date);
          prefs.setString("eventDescription", _description);
          prefs.setString("eventNbrMax", _nbrMax);
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ProductDetails();
          }));
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
              child: Image.asset("assets/images/Capture.PNG",
                  width: 200, height: 94),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_name),
              ],
            )
          ],
        ),
      ),
    );
  }
}
