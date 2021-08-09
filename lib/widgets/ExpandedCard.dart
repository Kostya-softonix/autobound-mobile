import 'package:autobound_mobile/widgets/SingleContact.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/SingleContact.dart';
import '../models/general.dart';
import '../screens/DetailsScreen.dart';

class ExpandedCard extends StatelessWidget {
  final Group group;

  ExpandedCard(this.group);

  final ScrollController _scrollController = ScrollController();

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
          onPanDown: (_) {
            if(title == 'See less') {
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn
              );
            }
          },
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

    final Widget collapsedContent = Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleContact(group.campaigns[0].contact),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  DetailsScreen.routeName,
                  arguments: group.campaigns[0].contact
                ),
                child: Container(
                height: 70,
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
          group.campaigns.length > 1
            ? seeMoreLessButton("See more", context)
            : SizedBox(height: 0,)
        ],
      ),
    );

    final Widget expandedContent = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      height: group.campaigns.length == 2 ? 230 : 320,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: group.campaigns.length,
              itemBuilder: (ctx, index) =>
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: index != group.campaigns.length - 1
                    ? BorderSide(width: 0.8, color: Theme.of(context).primaryColor,)
                    : BorderSide.none
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleContact(group.campaigns[index].contact),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                        DetailsScreen.routeName,
                        arguments: group.campaigns[index].contact
                      ),
                      child: Container(
                      height: 70,
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
              ),
            ),
          ),
          seeMoreLessButton("See less", context)
        ],
      ),
    );

    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        borderOnForeground: false,
        child: Container(
          padding: EdgeInsets.only(top: 10.0,),
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