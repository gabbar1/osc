class LoadModel {
  String leadDate,leadType,status,comment;
  LoadModel({this.leadType,this.status,this.comment,this.leadDate});

  LoadModel.fromJson(Map<String,dynamic> json){
    leadDate = json['leadDate'];
    leadType = json['leadType'];
    status = json['status'];
    comment = json['comment'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadDate'] = this.leadDate;
    data['leadType'] = this.leadType;
    data['status'] = this.status;
    data['comment'] = this.comment;
    return data;
  }
}