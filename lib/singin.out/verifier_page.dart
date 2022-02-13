import 'package:flutter/material.dart';
import '../delayedAnimation.dart';
import '../main.dart';
import '../UserHome/home.dart';

class Verifier extends StatelessWidget{
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
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
               child: Text("please enter your verification code" ),
            ),
            SizedBox(height: 35),
            VerifierForm(),
            SizedBox(height: 35),
            ElevatedButton(style: ElevatedButton.styleFrom(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 35),
                child:Row(
                  children: <Widget>[
                    Expanded(child:DelayedAnimation(
                      delay: 6500,
                      child: Text("Didn't recieve the code  "),
                    )
                    ),
                    Expanded(child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Verifier(),
                          ),
                        );
                      },

                      child: DelayedAnimation(
                        delay: 6500,
                        child:
                        Text(
                          "Re_send",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,

                          ),

                        ),
                      ),
                    ),)
                  ],

                ),
              ),

            )

          ],

    ),
    )
    )
    );
  }

}

class VerifierForm extends StatefulWidget {
  @override
  _VerifierFormState createState() => _VerifierFormState();
}

class _VerifierFormState  extends State <VerifierForm>{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:20 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: TextField(
            decoration: InputDecoration(
              hintText: "0",
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

            keyboardType: TextInputType.number,
          ),
          ),
          Expanded(child: SizedBox(width: 20,)),
          Expanded(child: TextField(
            decoration: InputDecoration(
              hintText: "0",
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

            keyboardType: TextInputType.number,
          ),
          ),
          Expanded(child: SizedBox(width: 20,)),
          Expanded(child: TextField(
            decoration: InputDecoration(
              hintText: "0",
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

            keyboardType: TextInputType.number,
          ),
          ),
          Expanded(child: SizedBox(width: 20,)),
          Expanded(child: TextField(
            decoration: InputDecoration(
              hintText: "0",
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

            keyboardType: TextInputType.number,
          ),
          )
          

        ],
      ),
    );

  }
}






