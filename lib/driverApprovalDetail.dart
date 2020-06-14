import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitchhiker_admin/driver.dart';
import 'package:hitchhiker_admin/mainScreen.dart';
import 'package:hitchhiker_admin/driverApproval.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

String urlapproveDriver =
    "http://pickupandlaundry.com/hitchhiker/php/admin/approveDriver.php";

class DriverApprovalDetail extends StatefulWidget {
  final Driver driver;

  const DriverApprovalDetail({Key key, this.driver}) : super(key: key);

  @override
  _DriverApprovalDetailState createState() => _DriverApprovalDetailState();
}

class _DriverApprovalDetailState extends State<DriverApprovalDetail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('Driver DETAILS'),
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: DetailInterface(
                driver: widget.driver,
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => DriverApproval(
            driver: widget.driver,
          ),
        ));
    return Future.value(false);
  }
}

class DetailInterface extends StatefulWidget {
  final Driver driver;
  DetailInterface({this.driver});

  @override
  _DetailInterfaceState createState() => _DetailInterfaceState();
}

class _DetailInterfaceState extends State<DetailInterface> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(),
        Container(
          width: 280,
          height: 200,
          child: Image.network(
              'http://pickupandlaundry.com/hitchhiker/license/${widget.driver.driverImage}.jpg',
              fit: BoxFit.fill),
        ),
        SizedBox(
          height: 10,
        ),
        Text(widget.driver.email.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Table(children: [
                TableRow(children: [
                  Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.driver.fName + widget.driver.lName),
                ]),
                TableRow(children: [
                  Text("Phone Number",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.driver.phoneNum),
                ]),
                TableRow(children: [
                  Text("Residential Hall",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.driver.residentialHall)
                ]),
                TableRow(children: [
                  Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.driver.status)
                ]),
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  height: 40,
                  child: Text(
                    'APPROVE DRIVER',
                    style: TextStyle(fontSize: 16),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 5,
                  onPressed: _onApproval,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _onApproval() {
    if (widget.driver.email == "user@noregister") {
      Toast.show("Please register to approve driver", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      _showDialog();
    }
    print("Approve Driver");
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Approve " + widget.driver.email),
          content: new Text("Are your sure?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                approveDriver();
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

  Future<String> approveDriver() async {
    String urlapproveDriver =
        "http://pickupandlaundry.com/hitchhiker/php/admin/approveDriver.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Approving Driver");
    pr.show();
    http.post(urlapproveDriver, body: {
      "email": widget.driver.email,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        pr.dismiss();
        _onLogin(widget.driver.email, context);
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        pr.dismiss();
      }
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }

  void _onLogin(String email, BuildContext ctx) {
    String urlgetuser =
        "http://pickupandlaundry.com/hitchhiker/php/getUser.php";

    http.post(urlgetuser, body: {
      "email": email,
    }).then((res) {
      print(res.statusCode);
      var string = res.body;
      List dres = string.split(",");
      print(dres);
      if (dres[0] == "success") {
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(builder: (context) => AdminMainPage()));
      }
    }).catchError((err) {
      print(err);
    });
  }
}
