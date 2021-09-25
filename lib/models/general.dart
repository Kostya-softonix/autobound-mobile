
class EmailContent {
  final String paragraph;
  final String snippet;
  final dynamic logicSet;
  final String text;

  EmailContent({
    this.paragraph,
    this.snippet,
    this.logicSet,
    this.text,
  });

}
class SuggestedGroupCampaingnContact {
    final String email;
    final String department;
    final String externalCreatedAt;
    final String externalDeletedAt;
    final String firstName;
    final String fullName;
    final String lastActivityAt;
    final String lastCampaignStartedAt;
    final String lastName;
    final dynamic mobilePhoneNumber;
    final dynamic phoneNumber;
    final String title;
    final String id;

  SuggestedGroupCampaingnContact({
    this.email,
    this.department,
    this.externalCreatedAt,
    this.externalDeletedAt,
    this.firstName,
    this.fullName,
    this.lastActivityAt,
    this.lastCampaignStartedAt,
    this.lastName,
    this.mobilePhoneNumber,
    this.phoneNumber,
    this.title,
    this.id,
  });
}

class SuggestedGroupCampaingnCompany {
  final String name;
  final String externalId;
  final String industry;
  final String metaCompany;
  final String websiteUrl;
  final String id;

  SuggestedGroupCampaingnCompany({
    this.name,
    this.externalId,
    this.industry,
    this.metaCompany,
    this.websiteUrl,
    this.id,
  });
}


class SuggestedGroupCampaingn {
  final String trigger;
  final String type;
  final SuggestedGroupCampaingnContact contact;
  final SuggestedGroupCampaingnCompany company;
  final List<EmailContent> content;
  final String user;
  final String suggestedGroup;
  final String contentHash;
  final bool isRejected;
  final bool isStarted;
  final String expiredAt;
  final bool isDirty;
  final bool isContactUsed;
  final double score;
  final dynamic insight;
  final dynamic organization;
  final String createdAt;
  final String updatedAt;
  final String id;

  SuggestedGroupCampaingn({
    this.trigger,
    this.type,
    this.contact,
    this.company,
    this.content,
    this.user,
    this.suggestedGroup,
    this.contentHash,
    this.isRejected,
    this.isStarted,
    this.expiredAt,
    this.isDirty,
    this.isContactUsed,
    this.score,
    this.insight,
    this.organization,
    this.createdAt,
    this.updatedAt,
    this.id,
  });
}

class SuggestedGroupTriggerPersona {
  final String type;
  final List<dynamic> values;

  SuggestedGroupTriggerPersona({
    this.type,
    this.values
  });

}

class SuggestedGroupTrigger {
  final dynamic description;
  final String type;
  final String user;
  final dynamic logicSet;
  final dynamic insight;
  final dynamic deletedAt;
  final dynamic parent;
  final dynamic isModifiedByUser;
  final dynamic organization;
  final dynamic organizationUpdatedBy;
  final dynamic organizationUser;
  final double score;
  final bool isEnabled;
  final String name;
  final SuggestedGroupTriggerPersona persona;
  final String createdAt;
  final String updatedAt;
  final String id;

  SuggestedGroupTrigger({
    this.description,
    this.type,
    this.user,
    this.logicSet,
    this.insight,
    this.deletedAt,
    this.parent,
    this.isModifiedByUser,
    this.organization,
    this.organizationUpdatedBy,
    this.organizationUser,
    this.score,
    this.isEnabled,
    this.name,
    this.persona,
    this.createdAt,
    this.updatedAt,
    this.id,
  });
}


class SuggestedGroup {
  final String id;
  final String type;
  final String contentHash;
  final String expiredAt;
  final dynamic organization;
  final double score;
  final SuggestedGroupTrigger trigger;
  final List<EmailContent> content;
  final Map<String, dynamic> tryToUpdateContent;
  final List<SuggestedGroupCampaingn> suggestedCampaigns;


  SuggestedGroup({
    this.id,
    this.type,
    this.contentHash,
    this.expiredAt,
    this.organization,
    this.score,
    this.trigger,
    this.content,
    this.tryToUpdateContent,

    this.suggestedCampaigns
  });
}


class IsightInfo {
  final String title;
  final String confidence;
  final String domain;
  final String url;
  final String articleSentence;
  final String signalDate;
  final String financingType;
  final String financingRound;
  final String signalType;
  final String financingTypeTags;


  IsightInfo({
    this.title,
    this.confidence,
    this.domain,
    this.url,
    this.articleSentence,
    this.signalDate,
    this.financingType,
    this.financingRound,
    this.signalType,
    this.financingTypeTags
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'confidence': confidence,
      'domain': domain,
      'url': url,
      'articleSentence': articleSentence,
      'signalDate': signalDate,
      'financingType': financingType,
      'financingRound': financingRound,
      'signalType': signalType,
      'financingTypeTags': financingTypeTags
    };
  }

}




class Contact {
  final String id;
  final String company;
  final String firstName;
  final String fullName;
  final String lastName;
  final String title;
  final String lastActivityAt;
  final String lastCampaignStartedAt;

  Contact({
    this.id,
    this.company,
    this.firstName,
    this.fullName,
    this.lastName,
    this.title,
    this.lastActivityAt,
    this.lastCampaignStartedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company': company,
      'firstName': firstName,
      'fullName': fullName,
      'lastName': lastName,
      'title': title,
      'lastActivityAt': lastActivityAt,
      'lastCampaignStartedAt': lastCampaignStartedAt,
    };
  }
}

class Company {
  final String name;
  final String id;

  Company({
    this.name,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }
}

class Campaign {
  final String id;
  final int score;
  final Map<String, dynamic> contact;
  final String contactName;
  final String companyName;

  Campaign({
    this.id,
    this.score,
    this.contact,
    this.contactName,
    this.companyName
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'contact': contact,
      'contactName': contactName,
      'companyName': companyName

    };
  }
}

class Group {
  final String id;
  final int score;
  final List<Campaign> campaigns;

  Group({
    this.id,
    this.score,
    this.campaigns

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'campaigns': campaigns
    };
  }
}

class SelectedCampaign {
  final List<Group> groups;
  final List<Contact> contacts;
  final List<Company> companies;

  SelectedCampaign({
    this.groups,
    this.contacts,
    this.companies,
  });

  Map<String, dynamic> toMap() {
    return {
      'groups': groups,
      'contacts': contacts,
      'companies': companies
    };
  }
}