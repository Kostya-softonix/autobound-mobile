import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import '../core/helpers.dart';
import '../core/regexes.dart';
import '../models/trigger.dart';
import '../widgets/ContactCard.dart';
import '../widgets/ActionButtons.dart';
import '../widgets/SignalInfo.dart';
import '../widgets/EditInMailAppButton.dart';
import '../screens/ContactDetailsScreen.dart';
import '../models/general.dart';
import '../providers/details.dart';

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

    convertRawHtmlToCustomField(String contentItem) {
      String matchesReplaceBr = contentItem.replaceAllMapped(removeBrRegex, (match) {
        return '';
      });
      final String regexMatchCustomField = customFieldsRegex.stringMatch(contentItem).toString();
      String matches = customFields[regexMatchCustomField] != null ? customFields[regexMatchCustomField] : '';
      String matchesReplace = matchesReplaceBr.replaceAllMapped(customFieldsRegex, (match) {
        return matches;
      });
      return matchesReplace;
    }

    final _htmlContent = content != null
      ? """
        <div>
          <div id="subject">
            <span>Subject: <strong #subject-title"> ${convertRawHtmlToCustomField(content[0].text)}</strong></span>
          </div>

          <div id="content">
            ${convertRawHtmlToCustomField(content[1].text)}
            <p></p>
            ${convertRawHtmlToCustomField(content[2].text)}
            ${convertRawHtmlToCustomField(content[3].text)}
            ${convertRawHtmlToCustomField(content[4].text)}
            ${convertRawHtmlToCustomField(content[5].text)}
          </div>
        </div>
      """
      : """ """
    ;

    Widget emailContentSection = Html(
      data: _htmlContent,
      onLinkTap: launchURL,
      style: {
        "#subject-title": Style(
          fontWeight: FontWeight.bold,
        ),
        "#subject": Style(
          border: Border(bottom: BorderSide(color: Colors.grey)),
          padding: EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 5)
        ),
        "#content": Style(
          padding: EdgeInsets.only(bottom: 2, left: 5, right: 5, top: 2)
        ),
        "p": Style(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10)
        ),
      },
    );


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
                      child: Card(
                        child: SingleChildScrollView(
                          child: emailContentSection,
                        )
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
                        convertRawHtmlToCustomField
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