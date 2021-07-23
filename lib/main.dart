import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

import './providers/auth.dart';
import './providers/triggers.dart';
import './screens/AuthScreen.dart';
import './screens/DasboardScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Triggers()),
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
          primaryColor: HexColor('1A72DD'),
          // primaryColor: Color(0xFF1d81cf),
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.rubikTextTheme(
            Theme.of(context).textTheme,
          ),
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



