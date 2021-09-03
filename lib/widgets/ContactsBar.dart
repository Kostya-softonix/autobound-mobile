import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';

class ContactsBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return
    Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
      ),

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
    );
  }
}