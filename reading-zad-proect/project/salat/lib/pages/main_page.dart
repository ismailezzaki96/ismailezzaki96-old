import 'package:flutter/material.dart';

import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:geolocator/geolocator.dart';





class MainPage extends StatefulWidget {

 MainPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}




class _MainPageState extends State<MainPage> {


   String locationError;
  PrayerTimes prayerTimes;



    @override
  void initState() {
    getLocationData().then((locationData) {
      if (!mounted) {
        return;
      }
      if (locationData != null) {
        setState(() {
          prayerTimes = PrayerTimes(
              Coordinates(locationData.latitude, locationData.longitude),
              DateComponents.from(DateTime.now()),
              CalculationMethod.karachi.getParameters());
        });
      } else {
        setState(() {
          locationError = "Couldn't Get Your Location!";
        });
      }
    });

    super.initState();
  }
  
  
  
  Future<Position> getLocationData() async {
    return   await Geolocator.getLastKnownPosition();
  }
  
  
  
  
  
  
  
  
  

 Card topArea() => Card(
        margin: EdgeInsets.all(10.0),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Color(0xFF015FFF), Color(0xFF015FFF)])),
            padding: EdgeInsets.all(5.0),
            // color: Color(0xFF015FFF),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Text("Savings",
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(r"$ 95,940.00",
                        style: TextStyle(color: Colors.white, fontSize: 24.0)),
                  ),
                ),
                SizedBox(height: 35.0),
              ],
            )),
      );

      


  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
          child: Scaffold(
         body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                topArea(),
                
                
                Builder(
              builder: (BuildContext context) {
                if (prayerTimes != null) {
                  return Column(
                    children: [
                      Text(
                        'Prayer Times for Today'+ DateFormat.jm().format(prayerTimes.timeForPrayer(prayerTimes.nextPrayer())),
                        textAlign: TextAlign.center,
                      ),
                     ],
                  );
                }
                if (locationError != null) {
                  return Text(locationError);
                }
                return Text('Waiting for Your Location...');
              },
            ),
                
                
                
                displayAccoutList(),
              ],
            ),
          ),
        ),
		      ),

    );
  }
  
  
  Container accountItems(
          String item, String charge, String dateString, String type,
          {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontSize: 16.0)),
                Text(charge, style: TextStyle(fontSize: 16.0))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),

          ],
        ),
      );
  
   displayAccoutList() {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          accountItems("Fajr Time", DateFormat.jm().format(prayerTimes.fajr), "28-04-16", "credit",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "dhuhr Time", DateFormat.jm().format(prayerTimes.dhuhr), "26-04-16", "credit"),
          accountItems("asr Time", DateFormat.jm().format(prayerTimes.asr), "25-04-216", "Payment",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "maghrib Time", DateFormat.jm().format(prayerTimes.maghrib), "16-04-16", "Payment"),
          accountItems(
              "isha Time", DateFormat.jm().format(prayerTimes.isha), "04-04-16", "Credit",
              oddColour: const Color(0xFFF7F7F9)),
        ],
      ),
    );
  } 
  
  
  
  
}
