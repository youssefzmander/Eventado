import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constant/text_style.dart';
import '../utils/size_config.dart';
import '../widgets/ui_helper.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails();

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late String _name;
  late String _date;
  late String _description;
  late String _price;
  late String _organizer;
  late SharedPreferences prefs;
  final String _baseUrl = "10.0.2.2:3001";

  late Future<bool> fetchedEvents;

  Future<bool> fetchEvents() async {
    prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("eventName")!;
    _date = prefs.getString("eventDate")!;
    _description = prefs.getString("eventDescription")!;
    _price = prefs.getString("eventPrice")!;
    _organizer = prefs.getString("eventOrg")!;

    return true;
  }

  @override
  void initState() {
    fetchedEvents = fetchEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedEvents,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(238),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        width: double.infinity,
                        child: Image.asset("assets/images/Capture.PNG",
                            width: 460, height: 215)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Text(
                        _name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(15)),
                          width: getProportionateScreenWidth(64),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 161, 180, 238),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Icon(Icons.notifications_active)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text((_date)),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        UIHelper.horizontalSpace(16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_organizer, style: titleStyle),
                            UIHelper.verticalSpace(4),
                            const Text("Organizer", style: subtitleStyle),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(64),
                      ),
                      child: Text(
                        _description,
                        maxLines: 3,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: 10,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("Price", style: subtitleStyle),
                    UIHelper.verticalSpace(8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: (_price),
                              style: titleStyle.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          const TextSpan(
                              text: "/per person",
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(Icons.shopping_basket_rounded),
                label: const Text(
                  "Buy ticket",
                  textScaleFactor: 1.5,
                ),
                onPressed: () async {
                  http.Response response =
                      await http.get(Uri.http(_baseUrl, "/create-charge"));
                }),
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
