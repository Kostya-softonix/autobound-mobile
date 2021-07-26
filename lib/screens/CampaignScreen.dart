import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/AppDrawer.dart';
import '../widgets/TriggerCard.dart';
import '../providers/auth.dart';
import '../screens/TriggerScreen.dart';



class CampaignScreen extends StatefulWidget {
  static const routeName = '/campaigns-screen';

  @override
  _CampaignScreenState createState() => _CampaignScreenState();

}

class _CampaignScreenState extends State<CampaignScreen> {
  var _isLoading = false;



  Future<void> _pullTriggersRefresh (BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).fetchTriggers();
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Auth>(context, listen: false).fetchTriggers().then((_) => {
      setState(() {
        _isLoading = false;
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final triggers = context.watch<Auth>().triggers;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suggested campaigns',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 1,
      ),
      drawer: AppDrawer(),

      body: _isLoading
      ? Center(child:
        CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          strokeWidth: 3,
        ),
      )
      : RefreshIndicator(
        color: Theme.of(context).primaryColor,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () => _pullTriggersRefresh(context),
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6,
          ),
          width: deviceSize.width,
          height: deviceSize.height,
          padding: EdgeInsets.only(
            left: 14,
            right: 14,
            top: 14,
            bottom: 52
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: triggers.length,
                  itemBuilder: (ctx, i) =>
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                      TriggerScreen.routeName,
                      arguments: triggers[i]),
                    child: TriggerCard(triggers[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}