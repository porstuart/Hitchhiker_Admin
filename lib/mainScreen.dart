import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitchhiker_admin/driverApproval.dart';
import 'package:hitchhiker_admin/driverBlacklist.dart';
import 'package:hitchhiker_admin/passengerApproval.dart';
import 'package:hitchhiker_admin/passengerBlacklist.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key key}) : super(key: key);

  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      PassengerApproval(),
      DriverApproval(),
      PassengerBlacklist(),
      DriverBlacklist(),
    ];
  }

  String $pagetitle = "Hitchhiker";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Text("Passenger Approval", style: TextStyle(fontSize: 10)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Text("Driver Approval", style: TextStyle(fontSize: 10)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
            title: Text("Passenger Blacklist", style: TextStyle(fontSize: 10)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
            title: Text("Driver Blacklist", style: TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
