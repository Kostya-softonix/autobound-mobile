import 'package:flutter/material.dart';
import './screens/AuthScreen.dart';
import './screens/DasboardScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autobound App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Color(0xFF1d81cf),
        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: AuthScreen(),
      ),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        DashboardScreen.routeName: (ctx) => DashboardScreen()
      },
    );
  }
}



