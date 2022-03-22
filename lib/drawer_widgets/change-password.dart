import 'package:flutter/material.dart';

import '../main.dart';
import '../singin.out/login_page.dart';

class changepaswrd extends StatefulWidget {
  @override
  _changepaswrdState createState() => _changepaswrdState();
}

class _changepaswrdState extends State<changepaswrd> {
  var _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: Icon(
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
          child: Column(
            children: [
              TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "your password",
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
              SizedBox(
                height: 25,
              ),
              TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "new password",
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
              SizedBox(
                height: 25,
              ),
              TextField(
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
                child: Text(
                  'CONFIRM',
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
