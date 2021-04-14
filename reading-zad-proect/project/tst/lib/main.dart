import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';
import 'pages/settings_page.dart';
import 'pages/compass/compass.dart';
import 'pages/azkar.dart';

void main() {
  runApp(MaterialApp(
    title: 'Bottom Nav Demo',
    home: MainWidget(),
    routes: <String, WidgetBuilder>{
      //     AGENDA: (BuildContext context) => AgendaScreen(),
    },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}


class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => MainWidgetState();
} 

class MainWidgetState extends State<MainWidget> {
  int currentTab = 0;
  final List<Widget> screens = [
    MainPage(),
    Compass(),
    AzkarElsabaah(),
    SettingsPage()
  ];
  Widget currentScreen = MainPage();

  final PageStorageBucket bucket = PageStorageBucket();

////////////////
  @override
  void initState() {
    super.initState();
  }

//////////////////



  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(child: currentScreen, bucket: bucket),
      bottomNavigationBar: bmnav.BottomNav(
        index: currentTab,
        labelStyle: bmnav.LabelStyle(visible: false),
        onTap: (i) {
          setState(() {
            currentTab = i;
            currentScreen = screens[i];
          });
        },
        items: [
          bmnav.BottomNavItem(Icons.home, label: 'Home'),
          bmnav.BottomNavItem(Icons.fitness_center, label: 'Workouts'),
          bmnav.BottomNavItem(Icons.person, label: 'Account'),
          bmnav.BottomNavItem(Icons.view_headline, label: 'Settings')
        ],
      ),
    );
  }
}




// Workouts Screen
class WorkoutsScreen extends StatefulWidget {
  WorkoutsScreen();
  @override
 WorkoutsScreenState createState() => WorkoutsScreenState();
}

class WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  Widget build(BuildContext ctx) {
    return Center(
      child: Container(
        color: Colors.red,
        padding: EdgeInsets.all(50.0),
        child: Text('Workouts', style: TextStyle(color: Colors.white, fontSize: 24.0)),
      ),
    );
  }
}

// Account Screen
class AccountScreen extends StatefulWidget {
  AccountScreen();
  @override
 AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext ctx) {
    return Center(
      child: Container(
        color: Colors.yellow[600],
        padding: EdgeInsets.all(50.0),
        child: Text('Account', style: TextStyle(color: Colors.white, fontSize: 24.0)),
      ),
    );
  }
}
