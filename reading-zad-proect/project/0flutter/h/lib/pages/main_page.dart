import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bmnav/bmnav.dart' as bmnav;

import '../providers/reminder_provider.dart';
import '../providers/city_transition_provider.dart';
import '../widgets/background.dart';
import '../widgets/notification_button.dart';
import '../widgets/day_summary.dart';
import '../widgets/temperature_summary.dart';
import '../widgets/top_bar.dart';
import '../widgets/week_table.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
       body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              builder: (context) => CityTransitionProvider(2)),
          ChangeNotifierProvider(builder: (context) => ReminderProvider()),
        ],
        child: Stack(
          children: <Widget>[
            Background(),
            TopBar(),
            DaySummary(),
            TemperatureSummary(),
            NotificationButton(),
            WeekTable(),
          ],
        ),
      ),
      	bottomNavigationBar: bmnav.BottomNav(
			items: [
				bmnav.BottomNavItem(Icons.home),
				bmnav.BottomNavItem(Icons.fitness_center),
				bmnav.BottomNavItem(Icons.person),
				bmnav.BottomNavItem(Icons.view_headline)
			],
		),
    );
  }
}
