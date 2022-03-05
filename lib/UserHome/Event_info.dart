import 'package:flutter/material.dart';

class EventInfo extends StatelessWidget {
  final String _name;

  const EventInfo(this._name);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        child: Column(
          children: [Text(_name)],
        ),
      ),
    );
  }
}
