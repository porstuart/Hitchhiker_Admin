import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:hitchhiker_admin/passenger.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

double perpage = 1;
String urlBlacklist =
    "http://pickupandlaundry.com/hitchhiker/php/admin/blacklistPassenger.php";

class PassengerList extends StatefulWidget {
  final Passenger passenger;

  PassengerList({Key key, this.passenger});

  @override
  _PassengerListPageState createState() => _PassengerListPageState();
}

class _PassengerListPageState extends State<PassengerList> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List data;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: RefreshIndicator(
              key: refreshKey,
              color: Colors.black,
              onRefresh: () async {
                await refreshList();
              },
              child: ListView.builder(
                  itemCount: data == null ? 1 : data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.blue,
                              child: Center(
                                child: Text("Passenger List",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                            Container(
                              child: Text("Click to blacklist account"),
                            ),
                          ],
                        ),
                      );
                    }

                    if (index == data.length && perpage > 1) {
                      return Container(
                        width: 250,
                        color: Colors.white,
                        child: MaterialButton(
                          child: Text(
                            "Load More",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      );
                    }
                    index -= 1;
                    return Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        elevation: 2,
                        child: InkWell(
                          onTap: () => _onBlacklist(data[index]['email']),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            data[index]['email']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )));
  }

  Future<String> makeRequest() async {
    String urlLoadPassenger =
        "http://pickupandlaundry.com/hitchhiker/php/admin/loadPassenger.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading Passenger");
    http.post(urlLoadPassenger, body: {}).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["passenger"];
        perpage = (data.length / 10);
        print("data");
        print(data);
        pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }

  Future init() async {
    this.makeRequest();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    this.makeRequest();
    return null;
  }

  void _onBlacklist(String email) {
    Passenger passenger = new Passenger(email: email);
    print(email);
    if (email == "not register") {
      Toast.show("Not allowed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Blacklist " + email),
          content: new Text("Are you sure?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlBlacklist, body: {
                  "email": email,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      email = dres[1];
                      if (dres[0] == "success") {
                        Toast.show("Success", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        Navigator.of(context).pop();
                      }
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
                });
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
