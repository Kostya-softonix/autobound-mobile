import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import './providers/campaigns.dart';
import './providers/auth.dart';
import './providers/triggers.dart';
import './providers/details.dart';
import './screens/ContactDetailsScreen.dart';
import './screens/AuthScreen.dart';
import './screens/CampaignScreen.dart';
import './screens/TriggerScreen.dart';
import './screens/DetailsScreen.dart';
import './widgets/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Triggers()),
        ChangeNotifierProvider(create: (_) => Campaigns()),
        ChangeNotifierProvider(create: (_) => Details()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Consumer<Auth>(
      builder: (ctx, auth, _) =>

      MaterialApp(
        title: 'Autobound App',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: HexColor('1A72DD'),
          accentColor: Colors.amber,
          primaryColorLight: CupertinoColors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.rubikTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: CupertinoColors.white,
            elevation: 1,
            shadowColor: Colors.black26,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            foregroundColor: Colors.black,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),

        home: auth.isAuth
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
          DetailsScreen.routeName: (ctx) => DetailsScreen(),
          ContactDetailsScreen.routeName: (ctx) => ContactDetailsScreen(),
        },
      ),
    );
  }
}
