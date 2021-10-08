import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter/material.dart';

import '../../helpers/html_helpers.dart';
import '../../helpers/helpers.dart';
import '../../models/general.dart';

class HtmlMailSection extends StatelessWidget {
  final List<CustomEmailContent> content;
  final Map<String, dynamic> customFields;

  HtmlMailSection(
    this.content,
    this.customFields
  );

  @override
  Widget build(BuildContext context) {


    final _htmlContent = content != null
      ? """
        <div>
          <div id="subject">
            <span>Subject:
              <strong #subject-title">
                ${convertRawHtmlToCustomField(content[0].text, customFields)}
              </strong>
            </span>
          </div>

          <div id="content">
            ${convertRawHtmlToCustomField(content[1].text, customFields)}
            <p></p>
            ${convertRawHtmlToCustomField(content[2].text, customFields)}
            ${convertRawHtmlToCustomField(content[3].text, customFields)}
            ${convertRawHtmlToCustomField(content[4].text, customFields)}
            ${convertRawHtmlToCustomField(content[5].text, customFields)}
          </div>
        </div>
      """
      : """ """
    ;

  final Widget emailContentSection = Html(
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

    return Card(
      child: SingleChildScrollView(
        child: emailContentSection,
      ),
    );
  }
}