import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../helpers/helpers.dart';
import '../models/general.dart';
import '../models/trigger.dart';
import '../providers/details.dart';
import '../screens/ContactDetailsScreen.dart';
import '../widgets/details/ContactCard.dart';
import '../widgets/details/ActionButtons.dart';
import '../widgets/details/SignalInfo.dart';
import '../widgets/details/HtmlMailSection.dart';
import '../widgets/details/EditInMailAppButton.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/details-screen';

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<Details>().isLoading;
    final deviceSize = MediaQuery.of(context).size;

    final Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    final Trigger trigger = data['trigger'];

    final appBar = generateAppBar(trigger.name);

    final String insight = context.watch<Details>().insight;
    final bool isInsight = insight == 'insight';

    final Map<String, dynamic> customFields = context.watch<Details>().customFields;

    final content = context.watch<Details>().content;

    final SuggestedGroupCampaingnContact contactDetails = context.watch<Details>().suggestedGroupContact;


    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: appBar,

      body: isLoading
      ? Center(
        child: CupertinoActivityIndicator(
          animating: true,
          radius: 16,
        ),
      )

      : Stack(
        children: [
          Positioned(
            height: calculateHeight(context, appBar, 0.9),
            top: 0,
            child: Container(
              width: deviceSize.width,
              decoration: BoxDecoration(
                color: HexColor('E5E5E5'),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Signal info expanded card
                    if(isInsight) Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: SignalInfo(),
                    ),
                    // Contact Card
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.of(context).pushNamed(
                            ContactDetailsScreen.routeName,
                          )
                        },
                        child: ContactCard(),
                      ),
                    ),
                    // Email content
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: HtmlMailSection(
                        content,
                        customFields
                      ),
                    ),
                    Container(
                      width: deviceSize.width * 0.45,
                      height: 40,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.red,
                        ),
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: EditInMailAppButton(
                        contactDetails.email,
                        content,
                        customFields
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Approve / Reject Buttons
          Positioned(
            bottom: 0,
            height: calculateHeight(context, appBar, 0.1),
            width: deviceSize.width,
            child: ActionButtons(),
          ),
        ],
      ),
    );
  }
}