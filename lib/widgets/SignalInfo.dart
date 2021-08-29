import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:hexcolor/hexcolor.dart';

class SignalInfo extends StatefulWidget {
  @override
  _SignalInfoState createState() => _SignalInfoState();
}

class _SignalInfoState extends State<SignalInfo> {

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



  @override
  Widget build(BuildContext context) {

    // final deviceSize = MediaQuery.of(context).size;

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
                  Text('Confidence:', style: TextStyle(color: HexColor('6F78A0'), fontSize: 12),),
                  Text('48.8%', style: TextStyle(color: HexColor('E54C4C'), fontSize: 13),),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Signal type:', style: TextStyle(color: HexColor('6F78A0'), fontSize: 12),),
                  Text('Initial Public Offering (IPO)', style: TextStyle(color: HexColor('262631'), fontSize: 13),),
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
              top: 4.0,
              bottom: 15.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title:', style: TextStyle(color: HexColor('6F78A0'), fontSize: 12),),
                Text('Initial Public Offering (IPO)', style: TextStyle(color: HexColor('262631'), fontSize: 13),),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              top: 4.0,
              bottom: 15.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Article brief:',
                  style: TextStyle(
                    color: HexColor('6F78A0'),
                    fontSize: 12
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Text(
                    'Paycor, a Saas (Software-as-a-Sercive), HCM (Human Capital Management) software, HCM (Human Capital Management) software, HCM (Human Capital Management) software, and online payroll services leader, ai',
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
                      Text('Signal URL:', style: TextStyle(color: HexColor('6F78A0'), fontSize: 12),),
                      Text('autobound.ai', style: TextStyle(color: Colors.blue, fontSize: 13, decoration: TextDecoration.underline), ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Signal date:', style: TextStyle(color: HexColor('6F78A0'), fontSize: 12),),
                      Text('March 30, 2021', style: TextStyle(color: HexColor('262631'), fontSize: 13),),
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
              top: 4.0,
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
                      Text('Financing type:', style: TextStyle(color: HexColor('6F78A0'), fontSize: 12),),
                      Text('IPO (Initial publicoffering) ', style: TextStyle(color: HexColor('262631'), fontSize: 13,),),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Funding tags:', style: TextStyle(color: HexColor('6F78A0'), fontSize: 12),),
                      Text('IPO', style: TextStyle(color: HexColor('262631'), fontSize: 13),),
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
              top: 4.0,
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
                      Text('Funding round:', style: TextStyle(color: HexColor('6F78A0'), fontSize: 12),),
                      Text('IPO (Initial publicoffering) ', style: TextStyle(color: HexColor('262631'), fontSize: 13,),),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Initial public offering (IPO):', style: TextStyle(color: HexColor('6F78A0'), fontSize: 12),),
                      Text('Paycor, Inc.', style: TextStyle(color: HexColor('262631'), fontSize: 13),),
                    ],
                  ),
                ),
              ],
            ),
          ),


          seeMoreLessButton("See less", context)
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
      child: Card(
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
                  hasIcon: false,
                  tapHeaderToExpand: false,
                  animationDuration: const Duration(milliseconds: 350),
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