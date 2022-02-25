import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pim/UserHome/paiement-page.dart';
import 'package:date_time_picker/date_time_picker.dart';
import '../main.dart';

class Create extends StatelessWidget {
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
                    "Add Event Here",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
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
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: <Widget>[
            TextFormField(
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
            const SizedBox(
              height: 35,
            ),
            TextFormField(
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
            const SizedBox(
              height: 35,
            ),
            TextFormField(
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
            const SizedBox(height: 20),
            Affiche(),
            DateTimePicker(
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
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: color,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 13,
                ),
              ),
              child: const Text(
                'Send request',
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Paiemenet(),
                    ),
                  );
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
                context: context, builder: ((Builder) => bottomSheet()));
          },
          child: const Icon(
            Icons.camera_alt,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
          ),
        ),
        const Spacer(),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Camera")),
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text("Gallery"))
            ],
          )
        ],
      ),
    );
  }

  Future takePhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("failed to pick image: $e");
    }
  }
}
