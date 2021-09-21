import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../widgets/SingleContact.dart';
import '../models/trigger.dart';
import '../models/general.dart';
import '../screens/DetailsScreen.dart';
import '../providers/campaigns.dart';
import '../providers/auth.dart';
import '../providers/details.dart';



class ExpandedCard extends StatefulWidget {
  final Group group;
  final Trigger trigger;

  ExpandedCard(
    this.group,
    this.trigger
  );

  @override
  _ExpandedCardState createState() => _ExpandedCardState();
}

class _ExpandedCardState extends State<ExpandedCard> {

  void pushToDetailScreen (
    BuildContext context,
    Map<String, dynamic> contact,
    Trigger trigger,
    Group group
  ) {
    final token = context.read<Auth>().token;

    Provider.of<Details>(context, listen: false).fetchSuggestedGroup(group.id, token);
    Navigator.of(context).pushNamed(
      DetailsScreen.routeName,
      arguments:
        {
          'contact': new Contact(
            id: contact['id'],
            company: Provider.of<Campaigns>(context, listen: false).findCompanyById(contact['company']),
            firstName: contact['firstName'],
            fullName: contact['fullName'],
            lastName: contact['lastName'],
            title: contact['title'],
            lastActivityAt: contact['lastActivityAt'],
            lastCampaignStartedAt: contact['lastCampaignStartedAt'],
          ),
          'trigger': trigger,
          'group': group
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      key: UniqueKey(),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        borderOnForeground: false,
        child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: HexColor('B7BED8'),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          // Text(group.campaigns[0].contactName),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleContact(widget.group.campaigns[0].contact),

              GestureDetector(
                onTap: () => pushToDetailScreen(
                  context,
                  widget.group.campaigns[0].contact,
                  widget.trigger,
                  widget.group
                ),
                child: Container(
                height: 90,
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: HexColor('B7BED8')),
                  )
                ),
                child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black87,
                    size: 20.0,
                  ),
                ),
              ),
              ],
            ),
          ],
        ),
      ),

      ),
    );
  }
}