import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'servers/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        StreamProvider<FirebaseUser>.value(value: AuthService().user)
      ],

      child: MaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
        ],

        routes: {
          '/': (context) => LandingScreen(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/temp': (context) => TempPage()
        }
      )
    );
  }
}

