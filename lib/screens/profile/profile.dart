import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  /* late String _id;
  late String f_name;
  late String _username;
  late String _email;
  late SharedPreferences prefs;
  final String _baseUrl = "10.0.2.2:3001";
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
  }*/

  @override
  Widget build(BuildContext context) {
    /*  return FutureBuilder(
      future: fetchedUser,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {*/
    return Scaffold(
        /*appBar: AppBar(
              elevation: 0,
              backgroundColor: primaryColor,
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
                    ("admine"),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    ("admine"),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    ("admine.admine@admine.com"),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
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
      },*/
        );
  }
}
