import 'package:flutter/material.dart';
import 'package:pim/main.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String _id;
  late String f_name;
  late String _username;
  late String _email;
  late SharedPreferences prefs;

  late Future<bool> fetchedUser;

  Future<bool> fetchUser() async {
    prefs = await SharedPreferences.getInstance();
    _id = prefs.getString("userId")!;
    f_name = prefs.getString("f_name")!;
    _username = prefs.getString("username")!;
    _email = prefs.getString("email")!;

    return true;
  }

  @override
  void initState() {
    fetchedUser = fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedUser,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: color,
              title: const Text("Profile"),
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
            body: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const CircleAvatar(
                      radius: 120,
                      backgroundImage: AssetImage("assets/images/user.jpg"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    (f_name),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    (_username),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    (_email),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text(
                          'Following',
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Followers',
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      ElevatedButton(
                        child: Text(
                          'CONFIRM',
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
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
