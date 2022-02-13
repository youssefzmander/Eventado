import 'package:flutter/material.dart';
import '../main.dart';
import '../singin.out/newpsw_page.dart';
import 'change-password.dart';
import 'modifierProfile.dart';
class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color,

        title: const Text("Settings"),
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
      body:  SingleChildScrollView(
        child: Column(
          children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,horizontal: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ModifierProfile(),
                          ),
                        );
                      },
                      child: const Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => changepaswrd(),
                          ),
                        );
                      },
                      child: const Text(
                        "Security ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),

    );
  }

}