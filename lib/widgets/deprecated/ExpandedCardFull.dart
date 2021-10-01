import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'SingleContactFull.dart';
import '../../models/trigger.dart';

import '../../models/general.dart';

import '../../screens/DetailsScreen.dart';
import '../../providers/campaigns.dart';
import '../../providers/auth.dart';
import '../../providers/details.dart';



class ExpandedCardFull extends StatefulWidget {
  final Group group;
  final Trigger trigger;

  ExpandedCardFull(
    this.group,
    this.trigger
  );

  @override
  _ExpandedCardFullState createState() => _ExpandedCardFullState();
}

class _ExpandedCardFullState extends State<ExpandedCardFull> {
  final ScrollController _scrollController = ScrollController();

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
          // Text(group.campaigns[0].contactName),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleContactFull(widget.group.campaigns[0].contact, widget.group.campaigns.length, true),

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
          widget.group.campaigns.length != 1
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
      height: widget.group.campaigns.length == 1 ? 120 : widget.group.campaigns.length == 2 ? 260 : 375,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.group.campaigns.length,
              itemBuilder: (ctx, index) =>
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: index != widget.group.campaigns.length - 1
                    ? BorderSide(width: 0.8, color: Theme.of(context).primaryColor,)
                    : BorderSide.none
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleContactFull(widget.group.campaigns[index].contact, widget.group.campaigns.length, false),
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
              ),
            ),
          ),
          widget.group.campaigns.length != 1
            ? seeMoreLessButton("See less", context)
            : SizedBox(height: 0,)
        ],
      ),
    );


    return Container(

      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
      // key: UniqueKey(),
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