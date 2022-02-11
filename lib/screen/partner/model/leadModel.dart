import 'package:cloud_firestore/cloud_firestore.dart';

class LeadModel {
  int referralPrice;
  int referralId;
  String product;
  String status;
  Timestamp time;
  String customerName;
  int customerPhone;
  String customerEmail;
  String key;

  LeadModel(
      {this.referralPrice,
        this.referralId,
        this.product,
        this.status,
        this.time,
        this.customerName,
        this.customerPhone,
        this.customerEmail,
        this.key});

  LeadModel.fromJson(Map<String, dynamic> json) {
    referralPrice = json['referral_price'];
    referralId = json['referral_id'];
    product = json['product'];
    status = json['status'];
    time = json['time'].runtimeType==String ?Timestamp.fromDate(DateTime.parse(json['time'])):json['time'] ;
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerEmail = json['customer_email'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referral_price'] = this.referralPrice;
    data['referral_id'] = this.referralId;
    data['product'] = this.product;
    data['status'] = this.status;
    data['time'] = this.time;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_email'] = this.customerEmail;
    data['key'] = this.key;
    return data;
  }
}
