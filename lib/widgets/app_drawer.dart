import 'package:daily_spending/screens/home_screen.dart';
import 'package:daily_spending/screens/stats_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Daily Spendings'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text("Stats"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(StatsScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
