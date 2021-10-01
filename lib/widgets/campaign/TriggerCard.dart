import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../models/trigger.dart';

class TriggerCard extends StatelessWidget {
  final Trigger trigger;

  TriggerCard(this.trigger);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: deviceSize.width * 0.65,
                  child: Text(
                    '${trigger.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      color: CupertinoColors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      height: 1.1
                    ),
                  ),
                ),
                Text(
                  '${trigger.contacts} contacts / ${trigger.companies} companies / ${trigger.groups} groups',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    height: 1.8
                  ),
                ),
              ],
            ),
            Container(
              width: 66,
              height: 22,
              alignment: Align().alignment,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 7.0),
                    child: Image.asset(
                      'assets/images/autobound-icon.png',
                      width: 12,
                      height: 12,
                    ),
                  ),
                  Text(
                    '${trigger.score}',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey2
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