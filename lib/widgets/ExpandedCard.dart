import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/SingleContact.dart';
import '../models/trigger.dart';
import '../models/general.dart';

class ExpandedCard extends StatelessWidget {
  final Group group;
  final Trigger trigger;
  final Function pushToDetailScreen;

  ExpandedCard(
    this.group,
    this.trigger,
    this.pushToDetailScreen
  );

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
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: HexColor('B7BED8'),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleContact(group.campaigns[0].contact),

                  GestureDetector(
                    onTap: () => pushToDetailScreen(
                      context,
                      group.campaigns[0].contact,
                      trigger,
                      group
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