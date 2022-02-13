import 'package:flutter/material.dart';
class Paiemenet extends StatelessWidget{
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

   );
  }


}