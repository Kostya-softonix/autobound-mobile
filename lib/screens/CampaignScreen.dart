import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../widgets/AppDrawer.dart';
import '../widgets/TriggerCard.dart';
import '../screens/TriggerScreen.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({ Key key, }) : super(key: key);

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
    super.initState();
    setState(() {
      _isLoading = true;
    });

    Provider.of<Auth>(context, listen: false).fetchTriggers().then((_) => {
      setState(() {
        _isLoading = false;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final triggers = context.watch<Auth>().triggers;

    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
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
            padding: const EdgeInsets.only(
              left: 14.0,
              right: 14.0,
              top: 14.0,
              bottom: 30.0
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: triggers.length,
                    itemBuilder: (ctx, i) =>
                    GestureDetector(
                      onTap: () => {
                        Provider.of<Auth>(context, listen: false).fetchGroupsByTrigger(triggers[i].id),
                        Navigator.of(context).pushNamed(
                        TriggerScreen.routeName,
                        arguments: triggers[i]),
                      },
                      child: TriggerCard(triggers[i]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}