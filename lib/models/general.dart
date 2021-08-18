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
  final  String contactName;

  Campaign({
    this.id,
    this.score,
    this.contact,
    this.contactName
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'contact': contact,
      'contactName': contactName
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