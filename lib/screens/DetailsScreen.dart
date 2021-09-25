import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../models/trigger.dart';
import '../widgets/ContactCard.dart';
import '../widgets/ActionButtons.dart';
import '../widgets/SignalInfo.dart';
import '../screens/ContactDetailsScreen.dart';
import '../core/helpers.dart';

import '../models/general.dart';
import '../providers/details.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'package:url_launcher/url_launcher.dart';


void _launchURL(String url) async => {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url'
  };

class DetailsScreen extends StatelessWidget {
  static const routeName = '/details-screen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    final isLoading = context.watch<Details>().isLoading;

    final String insight = context.watch<Details>().insight;
    final bool isInsight = insight == 'insight';

    final Map<String, dynamic> customFields = context.watch<Details>().customFields;

    // print('insight');
    // print(insight);

    final Contact contact = data['contact'];
    final Trigger trigger = data['trigger'];
    final Group group = data['group'];

    final content = context.watch<Details>().content;

    final appBar = generateAppBar(trigger.name);

    void pushToContactDetailsScreen() {
      Navigator.of(context).pushNamed(
        ContactDetailsScreen.routeName,
        arguments: contact,
      );
    }
    // print(trigger.toMap());
    // print(contact.toMap());
    print(group.toMap());

    RegExp exp = new RegExp(
      r'{{\s*[\w.]+\s*}}',
      caseSensitive: false,
      multiLine: false,
    );



    convertRawHtmlToCustomField(String contentItem) {
      print('Content item');
      print(contentItem);

      final String regexMatch = exp.stringMatch(contentItem).toString();
      print(regexMatch);

      String matches = customFields[regexMatch] != null ? customFields[regexMatch] : '';

      String matchesReplace = contentItem.replaceAllMapped(exp, (match) {
        return matches;
      });

      print(matchesReplace);
      return matchesReplace;
    }


    final _htmlContent = """
      <div>
        <div id="subject">
          <span> Subject: </span>
          <span id="subject-title"> ${convertRawHtmlToCustomField(content[0].text)} </span>
        </div>
        <div id="content">
          ${convertRawHtmlToCustomField(content[1].text)}
          ${convertRawHtmlToCustomField(content[2].text)}
          ${convertRawHtmlToCustomField(content[3].text)}
          ${convertRawHtmlToCustomField(content[4].text)}
          ${convertRawHtmlToCustomField(content[5].text)}
        </div>
      </div>
    """;

    Widget emailContentSection = Html(
      data: _htmlContent,
      onLinkTap: _launchURL,
      style: {
        "#subject-title": Style(
          fontWeight: FontWeight.bold,
          display: Display.INLINE
        ),
        "#subject": Style(
          border: Border(bottom: BorderSide(color: Colors.grey)),
          padding: EdgeInsets.only(bottom: 2, left: 5, right: 5, top: 2)
        ),
        "#content": Style(
          padding: EdgeInsets.only(bottom: 2, left: 5, right: 5, top: 2)
        ),
      },
    );



    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: appBar,

      body: isLoading
      ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          strokeWidth: 3,
        ),
      )

      : Stack(
        children: [
          Positioned(
            height: calculateHeight(context, appBar, 0.9),
            // height: deviceSize.height * 0.8,
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
                        onTap: () => pushToContactDetailsScreen(),
                        child: ContactCard(contact),
                      ),
                    ),
                    // Email content
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Card(
                        child: SingleChildScrollView(
                          child: emailContentSection,
                        )
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