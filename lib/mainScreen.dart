import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitchhiker_admin/passengerListPage.dart';
import 'package:hitchhiker_admin/driverListPage.dart';

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
      PassengerList(),
      DriverList(),
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
        //backgroundColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Passenger"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
            title: Text("Driver"),
          ),
        ],
      ),
    );
  }
}
