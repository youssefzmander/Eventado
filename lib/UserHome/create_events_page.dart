import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pim/UserHome/paiement-page.dart';
import 'package:pim/singin.out/avatr_page.dart';

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
            SizedBox(
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
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Event Name ",
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "nbr participants",
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Affiche(),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${date.year}/${date.month}/${date.day}",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2050),
                            );
                            if (newDate == null) return;
                            setState(() => date = newDate);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: color,
                          ),
                          child: const Text("Select Date")),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: color,
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 13,
                ),
              ),
              child: Text(
                'Send request',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Paiemenet(),
                  ),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: color,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 13,
                ),
              ),
              child: const Text(
                'Generate NFT Here',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Paiemenet(),
                  ),
                );
              },
            )
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
