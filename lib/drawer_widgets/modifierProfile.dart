import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pim/UserHome/home.dart';
import 'package:pim/drawer_widgets/Profile_page.dart';
import 'package:pim/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/size_config.dart';
import 'Settings.dart';

class ModifierProfile extends StatefulWidget {
  @override
  State<ModifierProfile> createState() => _ModifierProfileState();
}

class _ModifierProfileState extends State<ModifierProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  late String _id;

  String? _f_name;
  String? _username;
  String? _email;

  late SharedPreferences prefs;

  final String _baseUrl = "10.0.2.2:3001";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<bool> fetchedUser;
  Future<bool> fetchUser() async {
    prefs = await SharedPreferences.getInstance();
    _id = prefs.getString("userId")!;
    _f_name = prefs.getString("f_name")!;
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: color,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Settings()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text("Modify your Profile", style: headingStyle),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Your account is already verified",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: (_f_name),
                        icon: Icon(Icons.person),
                        helperText: "Full Name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 3, 29, 116),
                        ),
                      ),
                      onSaved: (String? value) {
                        _f_name = value;
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
                      hintText: (_email),
                      helperText: "Email",
                      icon: Icon(Icons.email),
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
                  const SizedBox(height: 25),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: (_username),
                        icon: Icon(Icons.nordic_walking_sharp),
                        helperText: "Username",
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
                  const SizedBox(height: 25),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: ("0000000000000"),
                        icon: Icon(Icons.account_balance_wallet_rounded),
                        helperText: "Wallet_address",
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        border: const OutlineInputBorder()),
                    onSaved: (String? value) {},
                  ),
                  const SizedBox(
                    height: 20,
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
                      'SAVE',
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        Map<String, dynamic> userData = {
                          "f_name": _f_name,
                          "email": _email,
                          "username": _username,
                        };

                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };
                        http
                            .put(Uri.http(_baseUrl, "/user" + _id),
                                headers: headers, body: json.encode(userData))
                            .then((http.Response response) {
                          if (response.statusCode == 201) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext) {
                                  return const AlertDialog(
                                    title: Text("Information"),
                                    content: Text(
                                        "An error has occurred. Try Again"),
                                  );
                                });
                          }
                        });
                      }
                    },
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class EdiImage extends StatefulWidget {
  const EdiImage({Key? key}) : super(key: key);

  @override
  _EditImageProfileState createState() => _EditImageProfileState();
}

class _EditImageProfileState extends State<EdiImage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          const Spacer(),
          image != null
              ? ClipOval(
                  child: Image.file(
                  image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ))
              : const CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage("assets/images/user.jpg"),
                ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: ((Builder) => bottomSheet()));
                },
                child: const Icon(
                  Icons.edit,
                  color: color,
                  size: 28.0,
                )),
          ),
        ],
      ),
    ); // one above another ( icon above image)
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: Text("Camera")),
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"))
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
