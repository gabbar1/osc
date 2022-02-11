class CategoryModel {
  String categoryName;
  String earnUpto;
  bool isEnabled;
  String categoryUrl;
  String key;

  CategoryModel({this.categoryName, this.isEnabled, this.categoryUrl,this.key});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    isEnabled = json['isEnabled'];
    categoryUrl = json['categoryUrl'];
    earnUpto = json['earnUpto'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['isEnabled'] = this.isEnabled;
    data['categoryUrl'] = this.categoryUrl;
    data['earnUpto'] = this.earnUpto;
    data['key'] = this.key;
    return data;
  }
}
