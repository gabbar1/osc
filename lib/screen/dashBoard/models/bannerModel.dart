class BannerModel {
  String image;
  String name;
  String url;

  BannerModel({this.image, this.name, this.url});

  BannerModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
