import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails();

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late String _name;
  late String _date;
  late String _description;
  late String _nbrMax;
  late SharedPreferences prefs;

  late Future<bool> fetchedUser;

  Future<bool> fetchUser() async {
    prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("eventName")!;
    _date = prefs.getString("eventDate")!;
    _description = prefs.getString("eventDescription")!;
    _nbrMax = prefs.getString("eventNbrMax")!;

    return true;
  }

  @override
  void initState() {
    fetchedUser = fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedUser,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_name),
            ),
            body: Column(
              children: [
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Image.asset("assets/images/Capture.PNG",
                        width: 460, height: 215)),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
                  child: Text(_description),
                ),
                Text("Price", textScaleFactor: 3),
                Text("Description " + _description),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(Icons.shopping_basket_rounded),
                label: const Text(
                  "Buy ticket",
                  textScaleFactor: 1.5,
                ),
                onPressed: () {}),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
