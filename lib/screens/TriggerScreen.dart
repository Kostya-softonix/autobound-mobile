import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/ExpandedCard.dart';
import '../models/trigger.dart';
import '../providers/auth.dart';

class TriggerScreen extends StatefulWidget {
  const TriggerScreen({ Key key, }) : super(key: key);
  static const routeName = '/trigger-screen';

  @override
  _TriggerScreenState createState() => _TriggerScreenState();
}

class _TriggerScreenState extends State<TriggerScreen> {
  var _textController = TextEditingController();

  void initState() {
    super.initState();
    print('Init');
    context.read<Auth>().setSearchContent('');
  }

  @override
  void didChangeDependencies() {
    print('Dep');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<Auth>().isLoading;
    final deviceSize = MediaQuery.of(context).size;

    final Trigger trigger = ModalRoute.of(context).settings.arguments;

    final _selectedCampaign = context.watch<Auth>().filteredCampaign;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            trigger.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColorLight,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            height: deviceSize.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
                      child: Text(
                        'Contacts: ${trigger.contacts} / Companies: ${trigger.companies} / Groups: ${trigger.groups}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CupertinoSearchTextField(
                        prefixInsets: const EdgeInsets.only(left: 14.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.8,
                            color: CupertinoColors.inactiveGray,
                          ),
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),

                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),


                        placeholder: 'Search',
                        placeholderStyle: TextStyle(
                          fontSize: 18,
                          height: 1.2,
                          color: CupertinoColors.inactiveGray
                        ),
                        controller: _textController,
                        onChanged: (String value) {
                          setState(() {
                            _textController.value.copyWith(
                              text: value,
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: value.length),
                              ),
                            );
                          });
                          context.read<Auth>().setSearchContent(value);
                        },
                        onSubmitted: (String value) {
                          setState(() {
                            _textController.value.copyWith(
                              text: value,
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: value.length),
                              ),
                            );
                          });
                          context.read<Auth>().setSearchContent(value);
                          print('Submitted text: $value');
                        },
                      ),
                    ),
                  ],
                ),

                isLoading
                ? Container(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.7,
                  margin: EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                      strokeWidth: 3,
                    ),
                  ),)
                : Container(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.7,
                  margin: EdgeInsets.only(top: 10.0),
                  child:
                  _selectedCampaign.groups.length > 0
                  ? Column(
                    children: [
                        Expanded(
                          child: ListView.builder(
                          itemCount: _selectedCampaign.groups.length,
                          itemBuilder: (ctx, i) =>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ExpandedCard(
                                  _selectedCampaign.groups[i],
                                  trigger,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                    : Container(
                      padding: EdgeInsets.only(top: 50),
                      width: double.infinity,
                      child: Text('No contact found.', textAlign: TextAlign.center,)
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