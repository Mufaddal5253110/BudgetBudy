
import 'package:daily_spending/screens/home_screen.dart';
import 'package:daily_spending/screens/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart' as preview;

import './models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(preview.DevicePreview(

    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => Transactions(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Spending',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                ),
                button:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
          ),
        ),
        // home: HomeScreen(),
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
          StatsScreen.routeName: (_) => StatsScreen(),
        },
      ),
    );
  }
}