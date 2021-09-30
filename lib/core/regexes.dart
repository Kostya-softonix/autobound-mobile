// Custom fields regex
RegExp customFieldsRegex = new RegExp(
  r'{{\s*[\w.]+\s*}}',
  caseSensitive: true,
  multiLine: false,
);

// Br regex
RegExp removeBrRegex = new RegExp(
  r'<p>[<br>|\s]*</p>',
  caseSensitive: true,
  multiLine: false,
);

// Remove html regex
RegExp removeHtmlRegex = RegExp(
  r"<[^>]*>",
  multiLine: true,
  caseSensitive: true
);

// Add New line Regex
RegExp addNewLineRegex = RegExp(
  r"</p>*>",
  multiLine: true,
  caseSensitive: true
);

//Email validation Regex
RegExp emailValidation = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  multiLine: false,
  caseSensitive: true
);