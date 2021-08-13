import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:badges/badges.dart';

import '../providers/auth.dart';

class SingleContact extends StatelessWidget {
  final Map<String, dynamic> contact;
  final int contactsLength;
  final bool showBadge;


  SingleContact(this.contact, this.contactsLength, this.showBadge);

  Widget getRowContact (String title, String data, BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
            width: deviceSize.width * 0.35,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: HexColor('2A3256'),
                fontSize: 13.0,
              ),
            ),
          ),


          Container(
            width: deviceSize.width * 0.4,
            padding:
            title == 'Recipient name:' && showBadge && contactsLength > 1
            ?
            EdgeInsets.only(left: 12, right: 20)
            :EdgeInsets.only(left: 12, right: 0) ,
            alignment: Alignment.centerRight,

            child: Badge(
              elevation: 3,
              showBadge: title == 'Recipient name:' && showBadge && contactsLength > 1,
              shape: BadgeShape.square,
              position: BadgePosition.topEnd(top: -3, end: -30),
              borderRadius: BorderRadius.circular(10),
              badgeColor: Theme.of(context).primaryColor,
              child: Text(
                  data,
                  style: TextStyle(
                    color: HexColor('2A3256'),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              badgeContent: Text(
                '+ ${(contactsLength -1)}'.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 14),
      child: Column(
        children: [
          getRowContact('Recipient name:', contact['fullName'], context),
          getRowContact('Recipient company:', context.read<Auth>().findCompanyById(contact['company']), context),
          getRowContact('Job title:', contact['title'], context),
        ],
      ),
    );
  }
}