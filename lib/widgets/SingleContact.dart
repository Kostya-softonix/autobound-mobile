import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import '../providers/auth.dart';

class SingleContact extends StatelessWidget {
  final Map<String, dynamic> contact;

  SingleContact(this.contact);

  Widget getRowContact (String title, String data) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
            width: 120,
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
            width: 210,
            padding: EdgeInsets.only(left: 12),
            alignment: Alignment.centerRight,
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
          getRowContact('Recipient name:', contact['fullName']),
          getRowContact('Recipient company:', context.read<Auth>().findCompanyById(contact['company'])),
          getRowContact('Job title:', contact['title']),
        ],
      ),
    );
  }
}