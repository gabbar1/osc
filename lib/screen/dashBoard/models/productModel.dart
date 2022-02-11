class ProductModel {
  String id;
  String steps;

  ProductModel({this.id,this.steps});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    steps = json['steps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['steps'] = this.steps;
    return data;
  }
}
