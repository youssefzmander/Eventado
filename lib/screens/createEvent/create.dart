import 'dart:io';
import 'dart:typed_data';

import 'package:admin/constants.dart';
import 'package:admin/screens/createEvent/test.dart';
//import 'package:admin/screens/createEvent/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main_screen.dart';

class Createvent extends StatelessWidget {
  static const String id = "Createvent";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Create event",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            CreateForm(),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}

class CreateForm extends StatefulWidget {
  @override
  _CreateFormFormState createState() => _CreateFormFormState();
}

class _CreateFormFormState extends State<CreateForm> {
  DateTime date = DateTime(2022, 02, 23);
  late String? _name;
  late String? _date;
  late String? _nbrMax;
  late String? _description;
  final String _baseUrl = "10.0.2.2:3001";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.fromLTRB(300, 0, 50, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 450,
              child: TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Event Name ",
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  onSaved: (String? value) {
                    _name = value;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 8) {
                      return "Too short !";
                    } else {
                      return null;
                    }
                  }),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              width: 450,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "nbr participants",
                  labelStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
                onSaved: (String? value) {
                  _nbrMax = value;
                },
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              width: 450,
              child: TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Description",
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  onSaved: (String? value) {
                    _description = value;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 8) {
                      return "Too short !";
                    } else {
                      return null;
                    }
                  }),
            ),
            const SizedBox(height: 20),
            Affiche(),
            Container(
              width: 450,
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }

                  return true;
                },
                onSaved: (String? val) {
                  print(val);
                  _date = val;
                },
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 13,
                ),
              ),
              child: const Text(
                'Create',
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  Map<String, dynamic> eventData = {
                    "name": _name,
                    "date": _date,
                    "nbrMax": _nbrMax,
                    "description": _description,
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=UTF-8"
                  };
                  http
                      .post(Uri.http(_baseUrl, "/event"),
                          headers: headers, body: json.encode(eventData))
                      .then((http.Response response) {
                    if (response.statusCode == 201) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ));
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Affiche extends StatefulWidget {
  @override
  AfficheState createState() => AfficheState();
}

class AfficheState extends State<Affiche> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        width: 450,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          image != null
              ? Image.file(
                  image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                )
              : const Text(
                  "   Add a Picture           ",
                  style: TextStyle(color: Colors.grey),
                ),
          const SizedBox(
            width: 50,
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context, builder: ((Builder) => Test()));
            },
            child: const Icon(
              Icons.camera_alt,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
