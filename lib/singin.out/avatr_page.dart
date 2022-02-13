import 'dart:io';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pim/singin.out/verifier_page.dart';
import '../main.dart';
class Avatar extends  StatefulWidget{
  @override
   AvatarForm createState()=> AvatarForm();
    }
class AvatarForm  extends State<Avatar> {
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child:Column(
                children : [
                  Text("Add Image",),
                  SizedBox(height: 20,),
                  ImageProfile(),
                  SizedBox(height: 20,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Choose your UserName",
                      labelStyle: TextStyle(color: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox( height: 35),
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
                      'CONFIRM',
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Verifier(),
                        ),
                      );
                    },
                  ),
                ],
              ) ,
            ),
          ],
        ),
      ),
    );
  }}
class ImageProfile  extends StatefulWidget{
  const ImageProfile({Key? key}) : super(key: key);

  @override
    _ImageProfileState createState() => _ImageProfileState();
  }

class _ImageProfileState extends State<ImageProfile>{
  File? image ;
  @override
  Widget build(BuildContext context) {
    return  Center (
      child : Stack(
      children: <Widget>[
        const Spacer(),
        image != null ? ClipOval( child:Image.file(image!,
          width: 160,
        height: 160,
        fit: BoxFit.cover,))
            : CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage("assets/images/user.jpg"),

        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child : InkWell(
          onTap: (){
            showModalBottomSheet(context: context,
                builder : ((Builder)=> bottomSheet()));
          },
          child: Icon(
            Icons.camera_alt,
            color: Colors.teal,
            size: 28.0,)
        ),
        ),
      ],
    ), );// one above another ( icon above image)
  }

   Widget bottomSheet() {
     return Container(
       height: 100.0,
       width: MediaQuery
           .of(context).size.width,
       margin: EdgeInsets.symmetric(
         horizontal: 20,
         vertical: 20,
       ),
       child: Column(
         children: <Widget>[
           Text("choose Profile Photo",
             style: TextStyle(
               fontSize: 20.0),),
           SizedBox(height: 20,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
             TextButton.icon(onPressed: () {
               takePhoto(ImageSource.camera);},
                 icon: Icon(Icons.camera),
                 label: Text("Camera")),
             TextButton.icon(onPressed: () {
               takePhoto(ImageSource.gallery);},
                 icon: Icon(Icons.image),
                 label: Text("Gallery"))
           ],
           )
         ],
       ),
     );
  }
  Future takePhoto(ImageSource source) async {
    try{final image = await ImagePicker().pickImage(source: source);
     if ( image == null) return ;
     final imageTemporary = File(image.path);
     setState(() => this.image=imageTemporary ); }
        on PlatformException catch (e){
      print ("failed to pick image: $e");
        }}
    }