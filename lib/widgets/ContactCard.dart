import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../models/general.dart';
import '../providers/details.dart';


class ContactCard extends StatelessWidget {
  final Contact contact;

  ContactCard(
    this.contact
  );


  @override
  Widget build(BuildContext context) {
    print(contact.id);

    final SuggestedGroupCampaingnContact contactDetails = context.watch<Details>().suggestedGroupContact;
    final SuggestedGroupCampaingnCompany companyDetails = context.watch<Details>().suggestedGroupCompany;


    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  contact.fullName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    height: 1.1
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset(
                    'assets/images/sf-logo.png',
                    width: 24,
                    height: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Container(
                width: double.infinity,
                child:
                  Text(
                    '${contactDetails.title} at ${companyDetails.name}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      height: 1.1
                    ),
                  ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Last activity date:',
                    style: TextStyle(
                      color: HexColor('6F78A0'),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      height: 1.1
                    ),
                  ),

                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.only(left: 8),
                      child: Text(
                        contactDetails.lastActivityAt,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          height: 1.1
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}