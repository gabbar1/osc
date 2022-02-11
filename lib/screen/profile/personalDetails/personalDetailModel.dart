class UserDetailModel {
  String advisor;
  String advisorEmail;
  String advisorName;
  String advisorPhoneNumber;
  String referedBy;
  String advisorDob;
  String advisorAdd1;
  String advisorAdd2;
  String advisorCity;
  String advisorState;
  int advisorPincode;
  String advisorOccupation;
  String advisorUrl;
  String total_wallet;
  String current_wallet;
  bool isAdmin;
  bool isEnabled;

  UserDetailModel(
      {this.advisor,
        this.advisorEmail,
        this.advisorName,
        this.advisorPhoneNumber,
        this.referedBy,
        this.advisorDob,
        this.advisorAdd1,
        this.advisorAdd2,
        this.advisorCity,
        this.advisorState,
        this.advisorPincode,
        this.advisorOccupation,
        this.advisorUrl,
        this.total_wallet,
        this.current_wallet,
        this.isEnabled,
      this.isAdmin});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    advisor = json['advisor'];
    advisorEmail = json['advisor_email'];
    advisorName = json['advisor_name'];
    advisorPhoneNumber = json['advisor_phone_number'];
    referedBy = json['refered_By'];
    advisorDob = json['advisor_dob'];
    advisorAdd1 = json['advisor_add1'];
    advisorAdd2 = json['advisor_add2'];
    advisorCity = json['advisor_city'];
    advisorState = json['advisor_state'];
    advisorPincode = json['advisor_pincode'];
    advisorOccupation = json['advisor_occupation'];
    advisorUrl = json['advisor_Url'];
    total_wallet = json['total_wallet'];
    current_wallet = json['current_wallet'];
    isAdmin = json['isAdmin'];
     isEnabled = json['isEnabled'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advisor'] = this.advisor;
    data['advisor_email'] = this.advisorEmail;
    data['advisor_name'] = this.advisorName;
    data['advisor_phone_number'] = this.advisorPhoneNumber;
    data['refered_By'] = this.referedBy;
    data['advisor_dob'] = this.advisorDob;
    data['advisor_add1'] = this.advisorAdd1;
    data['advisor_add2'] = this.advisorAdd2;
    data['advisor_city'] = this.advisorCity;
    data['advisor_state'] = this.advisorState;
    data['advisor_pincode'] = this.advisorPincode;
    data['advisor_occupation'] = this.advisorOccupation;
    data['advisor_Url'] = this.advisorUrl;
    data['total_wallet'] = this.total_wallet;
    data['current_wallet'] = this.current_wallet;
    data['isAdmin'] = this.isAdmin;
    data['isEnabled'] = this.isEnabled;

    return data;
  }
}
