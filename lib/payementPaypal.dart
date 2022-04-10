

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class payementPaypal extends StatefulWidget {
  payementPaypal(this.prix) ;
  var prix ;

  @override
  _PayementPaypalState createState() => _PayementPaypalState();

  }




  /*
  html>
        <body onload="document.f.submit();">
          <form id="f" name="f" method="post" action="http://10.0.2.2:3001/pay">
            <input type="hidden" name="prix" value="${widget.prix}" />
          </form>
        </body>
      </html>
   */
class _PayementPaypalState extends State<payementPaypal>  {
  String _loadHTML(){
    return  r'''
    
      '''; 
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
        //initialUrl: 'http://10.0.2.2:3001/pay', // paypal
        initialUrl: 'http://10.0.2.2:3001/create-charge'
        //  initialUrl: Uri.dataFromString(_loadHTML(), mimeType: 'text/html').toString(),
      ),
    );
  }
}