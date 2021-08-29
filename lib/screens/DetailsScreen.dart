import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/ActionButtons.dart';
import '../models/trigger.dart';
import '../widgets/SignalInfo.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details-screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    // final Map<String, dynamic> contact = data['contact'];
    final Trigger trigger = data['trigger'];
    final deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            trigger.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColorLight,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Stack(
          children: [
            // Contacts section
            Positioned(
              top: 0,
              width: deviceSize.width,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.slider_horizontal_3,
                          color: Colors.black87,
                          size: 22.0,
                        ),
                        Badge(
                          elevation: 3,
                          showBadge: true,
                          shape: BadgeShape.square,
                          position: BadgePosition.topEnd(top: 0, end: -50),
                          borderRadius: BorderRadius.circular(10),
                          badgeColor: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Contacts',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          badgeContent: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '3 / 12',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black87,
                      size: 22.0,
                    ),

                  ],
                ),
              ),
            ),



            // Signal info expanded card
            Positioned(
              height: deviceSize.height * 0.67,
              top: 70.0,
              width: deviceSize.width,
              child:

              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SignalInfo(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text('Mail content'),
                      ),
                    ),
                  ],
                ),

              ),
            ),

            // Approve / Reject Buttons
            Positioned(
              bottom: 0,
              width: deviceSize.width,
              child: ActionButtons(),

            ),
          ],
        ),

      ),
    );
  }
}