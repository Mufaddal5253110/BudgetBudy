import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './screens/home_screen.dart';
import './screens/splash_screen.dart';
import './screens/new_transaction.dart';
import './models/transaction.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Transactions(),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Money Tracker',
            theme: ThemeData(
              primaryColor: Colors.amber,
              accentColor: Colors.amberAccent,
              fontFamily: 'Quicksand',
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline1: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    button: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
              appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline1: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
              ),
            ),
            home: FutureBuilder(
              future: Provider.of<Transactions>(context, listen: false)
                  .fetchTransactions(),
              builder: (ctx, snapshot) =>
                  (snapshot.connectionState == ConnectionState.waiting)
                      ? SplashScreen()
                      : HomeScreen(),
            ),
            routes: {
              NewTransaction.routeName: (_) => NewTransaction(),
            },
          );
        });
  }
}
