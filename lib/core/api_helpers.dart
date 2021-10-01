const apiUrl = 'https://dev.autobound.ai/api/';

class JsonIdPayload {
  String id;

  JsonIdPayload(
    this.id
  );

  Map toJson() => {'id': id};
}

class JsonApprovePayload {
  String campaignID;
  String rawBody;
  String rawSubject;

  JsonApprovePayload(
    this.campaignID,
    this.rawBody,
    this.rawSubject

  );

  Map toJson() => {
    'id': campaignID,
    'body': rawBody,
    'subject': rawSubject,
    'previewSubject': rawSubject
  };
}
