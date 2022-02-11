class ReferModel {
  int price;
  bool isEnabled;
  String name;
  String banner;
  String type;
  String url;
  String key;
  String youtube;
  List<About> about;
  List<Faq> faq;
  List<HowToEarn> howToEarn;
  List<KnowMore> knowMore;

  ReferModel(
      {this.price,
        this.isEnabled,
        this.name,
        this.banner,
        this.type,
        this.url,
        this.key,
        this.youtube,
        this.about,
        this.faq,
        this.howToEarn,
        this.knowMore});

  ReferModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    isEnabled = json['isEnabled'];
    name = json['name'];
    banner = json['banner'];
    type = json['type'];
    url = json['url'];
    key = json['key'];
    youtube = json['youtube'];
    if (json['about'] != null) {
      about = <About>[];
      json['about'].forEach((v) {
        about.add(new About.fromJson(v));
      });
    }
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq.add(new Faq.fromJson(v));
      });
    }
    if (json['how-to-earn'] != null) {
      howToEarn = <HowToEarn>[];
      json['how-to-earn'].forEach((v) {
        howToEarn.add(new HowToEarn.fromJson(v));
      });
    }
    if (json['know-more'] != null) {
      knowMore = <KnowMore>[];
      json['know-more'].forEach((v) {
        knowMore.add(new KnowMore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['isEnabled'] = this.isEnabled;
    data['name'] = this.name;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['url'] = this.url;
    data['key'] = this.key;
    data['youtube'] = this.youtube;
    if (this.about != null) {
      data['about'] = this.about.map((v) => v.toJson()).toList();
    }
    if (this.faq != null) {
      data['faq'] = this.faq.map((v) => v.toJson()).toList();
    }
    if (this.howToEarn != null) {
      data['how-to-earn'] = this.howToEarn.map((v) => v.toJson()).toList();
    }
    if (this.knowMore != null) {
      data['know-more'] = this.knowMore.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class About {
  String html;
  int index;

  About({this.html,this.index});

  About.fromJson(Map<String, dynamic> json) {
    html = json['html'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['html'] = this.html;
    data['index'] = this.index;
    return data;
  }
}
class Faq {
  String html;
  int index;

  Faq({this.html,this.index});

  Faq.fromJson(Map<String, dynamic> json) {
    html = json['html'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['html'] = this.html;
    data['index'] = this.index;
    return data;
  }
}
class HowToEarn {
  String html;
  int index;

  HowToEarn({this.html});

  HowToEarn.fromJson(Map<String, dynamic> json) {
    html = json['html'];
    index =json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['html'] = this.html;
    data['index'] = this.index;
    return data;
  }
}
class KnowMore {
  String html;
  int index;

  KnowMore({this.html});

  KnowMore.fromJson(Map<String, dynamic> json) {
    html = json['html'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['html'] = this.html;
    data['index'] = this.index;
    return data;
  }
}
