import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:hitchhiker_admin/passenger.dart';
import 'package:hitchhiker_admin/slideRightRoute.dart';
import 'package:hitchhiker_admin/passengerApprovalDetail.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

double perpage = 1;

class PassengerApproval extends StatefulWidget {
  final Passenger passenger;

  PassengerApproval({Key key, this.passenger});

  @override
  _PassengerApprovalPageState createState() => _PassengerApprovalPageState();
}

class _PassengerApprovalPageState extends State<PassengerApproval> {
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
                                child: Text("Passenger Approval List",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                            Container(
                              child: Text("Click to approve passenger account"),
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
                          onTap: () => _onApproval(
                              data[index]['email'],
                              data[index]['fName'],
                              data[index]['lName'],
                              data[index]['gender'],
                              data[index]['matric'],
                              data[index]['phoneNum'],
                              data[index]['emergeNum'],
                              data[index]['residentialHall'],
                              data[index]['status'],
                              data[index]['passengerImage']),
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
        "http://pickupandlaundry.com/hitchhiker/php/admin/loadApprovePassenger.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading Approval List");
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

  void _onApproval(
      String email,
      String fName,
      String lName,
      String gender,
      String matric,
      String phoneNum,
      String emergeNum,
      String residentialHall,
      String status,
      String passengerImage) {
    Passenger passenger = new Passenger(
        email: email,
        fName: fName,
        lName: lName,
        gender: gender,
        matric: matric,
        phoneNum: phoneNum,
        emergeNum: emergeNum,
        residentialHall: residentialHall,
        status: status,
        passengerImage: passengerImage);

    Navigator.push(context,
        SlideRightRoute(page: PassengerApprovalDetail(passenger: passenger)));
  }
}
