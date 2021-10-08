import '../core/regexes.dart';

String removeHtmlTags(String contentItem) {
  final extendedItem = contentItem.replaceAll(addNewLineRegex, '</p>\n');
  return extendedItem.replaceAll(removeHtmlRegex, '');
}

convertRawHtmlToCustomField(String contentItem, Map<String, dynamic> customFields ) {
  String matchesReplaceBr = contentItem.replaceAllMapped(removeBrRegex, (match) {
    return '';
  });
  String regexMatchCustomField = customFieldsRegex.stringMatch(contentItem).toString();
  String matches = customFields[regexMatchCustomField] ??  '';
  String matchesReplace = matchesReplaceBr.replaceAllMapped(customFieldsRegex, (match) {
    return matches;
  });
  return matchesReplace;
}