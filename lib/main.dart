import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import './providers/auth.dart';
import './widgets/SplashScreen.dart';
import './screens/AuthScreen.dart';
import './screens/CampaignScreen.dart';
import './screens/TriggerScreen.dart';
import './providers/triggers.dart';

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
    return Consumer<Auth>(
      builder: (ctx, auth, _) => MaterialApp(
        title: 'Autobound App',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: HexColor('1A72DD'),
          // primaryColor: Color(0xFF1d81cf),
          accentColor: Colors.amber,
          primaryColorLight: CupertinoColors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.rubikTextTheme(
            Theme.of(context).textTheme,
          ),
        ),

        home: context.watch<Auth>().isAuth
          ? CampaignScreen()
          : FutureBuilder(
            future: auth.tryAutologin(),
            builder: (ctx, authResultSnapshot) =>
            authResultSnapshot.connectionState == ConnectionState.waiting
              ? SplashScreen()
              : AuthScreen()
          ),

        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          CampaignScreen.routeName: (ctx) => CampaignScreen(),
          TriggerScreen.routeName: (ctx) => TriggerScreen(),
        },
      ),
    );

  }
}
