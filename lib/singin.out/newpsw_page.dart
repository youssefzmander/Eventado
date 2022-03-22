import 'package:flutter/material.dart';
import 'package:pim/singin.out/social_page.dart';

import 'login_page.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  var _obscureText = true;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  late String? _email;
  late String? _passwd;
  final String _baseUrl = "10.0.2.2:3001";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 30,
          ),
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "abc@email.com",
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.4),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
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
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "new password",
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
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
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  onSaved: (String? value) {
                    _passwd = value;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "confirm password",
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(0.0),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: color,
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'CONFIRM',
                  ),
                  onPressed: () {
                    print("tapped");
                    if (_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();
                      Map<String, dynamic> userData = {
                        "email": _email,
                        "password": _passwd
                      };
                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=UTF-8"
                      };

                      http
                          .patch(Uri.http(_baseUrl, "/user/editPassword"),
                              headers: headers, body: json.encode(userData))
                          .then((http.Response response) async {
                        if (response.statusCode == 200) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text("success"),
                                  content: Text("Password updated!"),
                                );
                              });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SocialPage()));
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text("Failed"),
                                  content: Text("Try Again!"),
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
        ),
      ),
    );
  }
}
