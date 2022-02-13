import 'package:flutter/material.dart';
import 'package:pim/main.dart';
import 'package:pim/singin.out/newpsw_page.dart';
class Resset extends StatelessWidget{
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
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: Column(
            children: [
              Text("Resset Password",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text("Please enter your address email to reset your password "),
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(
                hintText: "abc@email.com",
                labelStyle: TextStyle(color: Colors.grey[400],),
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
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: color,
                  padding: EdgeInsets.symmetric(
                    horizontal: 120,
                    vertical: 10,
                  ),
                ),
                child: Text(
                  'SEND',
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewPassword(),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );

  }

}