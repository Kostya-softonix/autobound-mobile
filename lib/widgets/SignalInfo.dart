import 'package:autobound_mobile/providers/details.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../core/helpers.dart';
import '../providers/details.dart';
import 'package:flutter/cupertino.dart';

class SignalInfo extends StatelessWidget {

  void _launchURL(String url) async => {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url'
  };

  Widget seeMoreLessButton(String title, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        color: HexColor('DFEBFF'),
      ),
      padding: EdgeInsets.symmetric(vertical: 7),
      child: ExpandableButton(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                title == 'See less'
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fixedTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      child: const Text(
        'Signal information',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    print('Signal build');

    final signalInfo = context.watch<Details>().insightInfo;
    final isLoading = context.watch<Details>().isLoading;
    print(signalInfo.confidence);

    Widget fixedInfoSection() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          right: 15.0,
          left: 15.0,
          top: 4.0,
          bottom: 15.0
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'Confidence:',
                      style: TextStyle(
                        color: HexColor('6F78A0'),
                        fontSize: 12
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${signalInfo.confidence}%',
                        style: TextStyle(
                          color: double.parse(signalInfo.confidence) > 70
                            ? Colors.green
                            : HexColor('E54C4C'),
                          fontSize: 13
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Icon(
                          double.parse(signalInfo.confidence) > 70
                          ? CupertinoIcons.arrow_up_right
                          : CupertinoIcons.arrow_down_right,
                          color: double.parse(signalInfo.confidence) > 70
                            ? Colors.green
                            : HexColor('E54C4C'),
                          size: 13.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'Signal type:',
                      style: TextStyle(
                        color: HexColor('6F78A0'),
                        fontSize: 12
                      ),
                    ),
                  ),
                  Text(
                    capitalizeFirstLetter(signalInfo.signalType),
                    style: TextStyle(
                      color: HexColor('262631'),
                      fontSize: 13
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final Widget collapsedContent = Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          fixedTitle(),
          fixedInfoSection(),
          seeMoreLessButton("See more", context)
        ],
      ),
    );

    final Widget expandedContent = Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          fixedTitle(),
          fixedInfoSection(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              bottom: 15.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                    'Title:',
                    style: TextStyle(
                      color: HexColor('6F78A0'),
                      fontSize: 12
                    ),
                  ),
                ),
                Text(
                  signalInfo.title,
                  style: TextStyle(
                    color: HexColor('262631'),
                    fontSize: 13
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,

                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              bottom: 15.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                    'Article brief:',
                    style: TextStyle(
                      color: HexColor('6F78A0'),
                      fontSize: 12
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Text(
                    signalInfo.articleSentence,
                    style: TextStyle(
                      color: HexColor('262631'),
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              bottom: 15.0
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child:  Text(
                          'Signal URL:',
                          style: TextStyle(
                            color: HexColor('6F78A0'),
                            fontSize: 12
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () => signalInfo.url != 'Unknown' ? _launchURL(signalInfo.url) : () {},
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Text(
                            signalInfo.url,
                            style: TextStyle(
                              color: signalInfo.url != 'Unknown'
                              ? Theme.of(context).primaryColor
                              : HexColor('262631'),
                              fontSize: 13,
                              decoration: signalInfo.url != 'Unknown'
                              ? TextDecoration.underline
                              : TextDecoration.none,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child:  Text(
                          'Signal date:',
                          style: TextStyle(
                            color: HexColor('6F78A0'),
                            fontSize: 12
                          ),
                        ),
                      ),
                      Text(
                        signalInfo.signalDate,
                        style: TextStyle(
                          color: HexColor('262631'),
                          fontSize: 13
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              bottom: 15.0
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child:   Text(
                          'Financing type:',
                          style: TextStyle(
                            color: HexColor('6F78A0'),
                            fontSize: 12
                          ),
                        ),
                      ),
                      Text(
                        capitalizeFirstLetter(signalInfo.financingType),
                        style: TextStyle(
                          color: HexColor('262631'),
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Text(
                          'Funding tags:',
                          style: TextStyle(
                            color: HexColor('6F78A0'),
                            fontSize: 12
                          ),
                        ),
                      ),
                      Text(
                        capitalizeFirstLetter(signalInfo.financingTypeTags),
                        style: TextStyle(
                          color: HexColor('262631'),
                          fontSize: 13
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              bottom: 15.0
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Text(
                        'Funding round:',
                          style: TextStyle(
                            color: HexColor('6F78A0'),
                            fontSize: 12
                          ),
                        ),
                      ),
                      Text(
                        capitalizeFirstLetter(signalInfo.financingRound),
                        style: TextStyle(
                          color: HexColor('262631'),
                          fontSize: 13,
                        ),

                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(bottom: 3.0),
                //         child: Text(
                //           'Initial public offering:',
                //           style: TextStyle(
                //             color: HexColor('6F78A0'),
                //             fontSize: 12
                //           ),
                //         ),
                //       ),
                //       Text(
                //         'Paycor, Inc.',
                //         style: TextStyle(
                //           color: HexColor('262631'),
                //           fontSize: 13),
                //         ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          seeMoreLessButton("See less", context)
        ],
      ),
    );

    return Container(
      child:
      isLoading
      ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          strokeWidth: 3,
        ),
      )


      : Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        borderOnForeground: false,
        child: ExpandablePanel(
            theme: const ExpandableThemeData(
              crossFadePoint: 0,
              animationDuration: const Duration(seconds: 1)
            ),
            collapsed: collapsedContent,
            expanded: expandedContent,
            builder: (_, collapsed, expanded) {
              return Expandable(
                theme: const ExpandableThemeData(
                  crossFadePoint: 0.2,
                  useInkWell: true,
                  hasIcon: false,
                  tapHeaderToExpand: false,
                  animationDuration: const Duration(milliseconds: 200),
                ),
                collapsed: collapsed,
                expanded: expanded,
              );
            },
          ),
        ),
    );
  }
}