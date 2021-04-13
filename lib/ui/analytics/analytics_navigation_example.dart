// Import the firebase_core plugin
import 'package:exampleapp/core/services/analytics_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    AnalyticsManager(
      analytics: FirebaseAnalytics(),
      child: Builder(
        builder: (BuildContext context) {
          final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
            analytics: AnalyticsManager.of(context).analytics,
          );
          return MaterialApp(
            home: Home2(),
            navigatorObservers: [
              observer,
            ],
            routes: {
              ScreenA.name: (BuildContext context) => ScreenA(),
            },
          );
        },
      ),
    ),
  );
}

class Home2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Go to screen a"),
                onPressed: () {
                  Navigator.of(context).pushNamed(ScreenA.name);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenA extends StatelessWidget {
  static String name = "/ScreenA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Screen A"),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Go Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
