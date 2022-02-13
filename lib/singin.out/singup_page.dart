import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../main.dart';
import 'avatr_page.dart';


class SingUp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    elevation: 0,
    backgroundColor: Colors.white.withOpacity(0),
    leading: IconButton(
      icon: Icon(
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
        child:Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 20, horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Text("Sing Up",
                        style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      ),)

                ],
              ),
            ),
            SizedBox(height: 35),
            SinupForm(),
            SizedBox(height: 35),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: color,
                  padding: EdgeInsets.symmetric(
                    horizontal: 125,
                    vertical: 13,
                  ),
                ),
                child: Text(
                  'suivant',
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Avatar(),
                    ),
                  );
                },
              ),

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

class _SinupFormFormState extends State<SinupForm>{
  var _obscureText = true;
  bool role = false ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: <Widget>[
           TextField(
            decoration: InputDecoration(
              labelText: "Full Name",
              labelStyle: TextStyle(color: Colors.grey[400],
              ),
            ),
          ),

          SizedBox(height: 30),
            TextField(
            decoration: InputDecoration(
              labelText: "abc@email.com",
              labelStyle: TextStyle(color: Colors.grey[400],
              ),
            ),
          ),

          SizedBox(height: 30),
            TextField(
            decoration: InputDecoration(
              labelText: "Phone Number",
              labelStyle: TextStyle(color: Colors.grey[400],
              ),
            ),
          ),

          SizedBox(height: 30),
             TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelText: 'Password',
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
              ),
            ),

          SizedBox(height: 35),
           TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                labelText: 'ConfirmPassword',
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
              ),
            ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(padding: const EdgeInsets.only(left :8),
              child: Row(
                children: <Widget>[
                  const Expanded(child: Text(" SingUp as an admin",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                Expanded(
                    child:  FlutterSwitch(
                      width: 75.0,
                      height: 35.0,
                      valueFontSize: 25.0,
                      toggleSize: 20,
                      toggleColor: color ,
                      borderRadius: 30.0,
                      padding: 8.0,
                      value :role,
                      onToggle: (val) {setState(() { role= val;});
                      },
                    ),

                )],
              ),

            ),
          ),
        ],
      ),
    );
  }
}

