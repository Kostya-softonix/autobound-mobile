import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../core/helpers.dart';
import '../../providers/campaigns.dart';

class SingleContact extends StatelessWidget {
  final Map<String, dynamic> contact;

  SingleContact(this.contact);

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
              padding: EdgeInsets.only(left: 12),
              alignment: Alignment.centerRight,
              child: Tooltip(
                verticalOffset: -70,
                showDuration: Duration(milliseconds: 1),
                message: data,
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
            contact['fullName'] ?? 'Unknown', context),
          getRowContact(
            'Recipient company:',
            contactCompany ?? 'Unknown', context),
          getRowContact(
            'Job title:',
            contact['title'] == null ? 'Unknown' : capitalizeFirstLetter(contact['title']), context
          ),
        ],
      ),
    );
  }
}