import 'dart:io';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pim/singin.out/verifier_page.dart';
import '../main.dart';

class Avatar extends StatefulWidget {
  @override
  AvatarForm createState() => AvatarForm();
}

class AvatarForm extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  const Text(
                    "Add Image",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ImageProfile(),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(height: 35),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageProfile extends StatefulWidget {
  const ImageProfile({Key? key}) : super(key: key);

  @override
  _ImageProfileState createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
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
                  Icons.camera_alt,
                  color: Colors.teal,
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
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
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
                  label: const Text("Camera")),
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
