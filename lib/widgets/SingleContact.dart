import '../providers/campaigns.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:badges/badges.dart';

class SingleContact extends StatelessWidget {
  final Map<String, dynamic> contact;
  final int contactsLength;
  final bool showBadge;


  SingleContact(this.contact, this.contactsLength, this.showBadge);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget getRowContact (String title, String data, BuildContext context) {

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
              width: deviceSize.width * 0.42,
              padding:
              title == 'Recipient name:' && showBadge && contactsLength > 1
              ?
              EdgeInsets.only(left: 12, right: 25)
              :EdgeInsets.only(left: 12, right: 0) ,
              alignment: Alignment.centerRight,

              child: Badge(
                elevation: 3,
                showBadge: title == 'Recipient name:' && showBadge && contactsLength > 1,
                shape: BadgeShape.square,
                position: BadgePosition.topEnd(top: -3, end: -32),
                borderRadius: BorderRadius.circular(10),
                badgeColor: Theme.of(context).primaryColor,
                child:
                Text(
                    data,
                    style: TextStyle(
                      color: HexColor('2A3256'),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                badgeContent:
                Container(
                  width: 20,
                  child: Text(
                    '+ ${(contactsLength -1)}'.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,

                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final String contactCompany = context.read<Campaigns>().findCompanyById(contact['company']);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 14),
      child: Column(
        children: [
          getRowContact(
            'Recipient name:',
            contact['fullName'] == null  ? 'Unknown' : contact['fullName'], context),
          getRowContact(
            'Recipient company:',
            contactCompany == null ? 'Unknown' : contactCompany, context),
          getRowContact(
            'Job title:',
            contact['title'] == null ? 'Unknown' : contact['title'], context
          ),
        ],
      ),
    );
  }
}