import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './screens/AuthScreen.dart';
import './screens/DasboardScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
      ],
      child: MyApp(),
    )
  );
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
          body: context.watch<Auth>().token == null
          ? AuthScreen()
          : DashboardScreen()
        ),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          DashboardScreen.routeName: (ctx) => DashboardScreen()
        },
      );

  }
}



