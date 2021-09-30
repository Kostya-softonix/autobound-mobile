import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../providers/campaigns.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  var _textController = TextEditingController();

  void useTextSearchController(String value) {
    setState(() {
      _textController.value.copyWith(
        text: value,
        selection: TextSelection.fromPosition(
          TextPosition(offset: value.length),
        ),
      );
    });
    context.read<Campaigns>().setSearchContent(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CupertinoSearchTextField(
        prefixInsets: const EdgeInsets.only(left: 12.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.8,
            color: CupertinoColors.inactiveGray,
          ),
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        placeholder: 'Search',
        suffixInsets: const EdgeInsets.only(right: 6.0),
        suffixIcon: Icon(
          CupertinoIcons.xmark_circle,
          // CupertinoIcons.delete_left_fill,
          size: 18,
        ),
        itemColor: Colors.black54,
        placeholderStyle: const TextStyle(
          fontSize: 15,
          height: 1.3,
          color: CupertinoColors.inactiveGray
        ),
        controller: _textController,
        onChanged: useTextSearchController,
        onSubmitted: useTextSearchController,
      ),
    );
  }
}