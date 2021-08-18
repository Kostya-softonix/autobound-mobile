import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';

import '../models/trigger.dart';

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

            Positioned(
              bottom: 20,
              width: deviceSize.width,
              child: Container(
                margin: EdgeInsets.only(top: 12, bottom: 6.0),
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).primaryColor
                        ),
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: CupertinoButton(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        minSize: kMinInteractiveDimensionCupertino,
                        onPressed: () => {
                          // Navigator.of(context).pushNamed(AuthScreen.routeName),
                        },
                        child: Text('Reject', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
                        color: Colors.white,
                      ),
                    ),
                    CupertinoButton(
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      minSize: kMinInteractiveDimensionCupertino,
                      onPressed: () => {

                        // Navigator.of(context).pushNamed(AuthScreen.routeName),
                      },
                      child: Text('Approve', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,), ),
                      color: Theme.of(context).primaryColor,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}