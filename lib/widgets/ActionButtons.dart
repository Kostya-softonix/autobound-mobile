import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../core/helpers.dart';
import '../screens/CampaignScreen.dart';
import '../providers/details.dart';


class ActionButtons extends StatefulWidget {
  @override
  _ActionButtonsState createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool isLoading = false;

  Future<void> approveCampaignAndRedirectToTriggerScreen() async {
      setState(() { isLoading = true; });

      await context.read<Details>().approveCampaign();

      setState(() { isLoading = false; });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => CampaignScreen()),
        (Route<dynamic> route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(generateSnackBar(
        'Success!',
        'Email sent! The campaign will be removed from your feed.'
        )
      );
    }

    Future<void> rejectCampaignAndRedirectToTriggerScreen() async {
      setState(() { isLoading = true; });
      await context.read<Details>().rejectCampaign();

      setState(() { isLoading = false; });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => CampaignScreen()),
        (Route<dynamic> route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(generateSnackBar(
        'Success!',
        'Campaign Rejected! This campaign was removed from your feed, and the contact will not be suggested again for up to 30 days.'
        )
      );
    }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: isLoading
      ? Center(
        child: CupertinoActivityIndicator(
          animating: true,
          radius: 16,
        ),
      )
      : Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: deviceSize.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).primaryColor
              ),
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              minSize: kMinInteractiveDimensionCupertino,
              child: Text(
                'Reject',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              color: Colors.white,
              onPressed: rejectCampaignAndRedirectToTriggerScreen,
            ),
          ),

          Container(
            width: deviceSize.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child:
            CupertinoButton(
              pressedOpacity: 0.5,
              padding: EdgeInsets.all(0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              minSize: kMinInteractiveDimensionCupertino,
              onPressed: approveCampaignAndRedirectToTriggerScreen,
              child: Text(
                'Approve',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}