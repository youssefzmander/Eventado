import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../main.dart';
import 'avatr_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SingUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Sing Up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 35),
            SinupForm(),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

class SinupForm extends StatefulWidget {
  @override
  _SinupFormFormState createState() => _SinupFormFormState();
}

class _SinupFormFormState extends State<SinupForm> {
  var _obscureText = true;
  bool role = false;
  late String? _name;
  late String? _username;
  late String? _email;
  late String? _pwd;

  final String _baseUrl = "10.0.2.2:3001";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Full Name",
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
            const SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "abc@email.com",
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
              onSaved: (String? value) {
                _email = value;
              },
              validator: (String? value) {
                RegExp regex = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                if (value!.isEmpty || !regex.hasMatch(value)) {
                  return "Invalid Email !";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Choose your UserName",
                  labelStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                  border: const OutlineInputBorder()),
              onSaved: (String? value) {
                _username = value;
              },
              validator: (String? value) {
                if (value!.isEmpty || value.length < 8) {
                  return "Too short !";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              onSaved: (String? value) {
                _pwd = value;
              },
              validator: (String? value) {
                if (value!.isEmpty || value.length < 5) {
                  return "Too Short !";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 35),
            TextFormField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelText: 'ConfirmPassword',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        " SingUp as an admin",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlutterSwitch(
                        width: 75.0,
                        height: 35.0,
                        valueFontSize: 25.0,
                        toggleSize: 20,
                        toggleColor: color,
                        borderRadius: 30.0,
                        padding: 8.0,
                        value: role,
                        onToggle: (val) {
                          setState(() {
                            role = val;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: color,
                padding: const EdgeInsets.symmetric(
                  horizontal: 125,
                  vertical: 13,
                ),
              ),
              child: const Text(
                'suivant',
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  Map<String, dynamic> userData = {
                    "name": _name,
                    "email": _email,
                    "username": _username,
                    "password": _pwd,
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=UTF-8"
                  };
                  http
                      .post(Uri.http(_baseUrl, "/user"),
                          headers: headers, body: json.encode(userData))
                      .then((http.Response response) {
                    if (response.statusCode == 201) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Avatar(),
                        ),
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext) {
                            return const AlertDialog(
                              title: Text("Information"),
                              content: Text("An error has occurred. Try Again"),
                            );
                          });
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
