

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class payementPaypal extends StatefulWidget {
  payementPaypal(this.prix) ;
  final prix ;

  @override
  _PayementPaypalState createState() => _PayementPaypalState();

  }



class _PayementPaypalState extends State<payementPaypal>  {
  String loadHTML(){
    return r'''''';
  }
  @override
  Widget build ( BuildContext context){
    return Scaffold(
      body: WebView(
        onPageFinished: (page)
        {
        if(page.contains('/successpayment'))
          {
            Navigator.pop(context);
          }
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'http://10.0.2.2:3001/pay',
      ),
    );
  }
}