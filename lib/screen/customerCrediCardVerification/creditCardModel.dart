class CheckEligibilityModel {
  String phone;
  String name;
  String pan;
  String email;
  String dob;
  String address;
  String pinCode;
  String companyName;
  String monthlySalary;
  String designation;
  String firmName;
  String itr;
  bool salaried;
  bool alreadyCreditCard;
  List<CreditCardModel> creditCardModel;

  CheckEligibilityModel(
      {this.phone,
        this.name,
        this.pan,
        this.email,
        this.dob,
        this.address,
        this.pinCode,
        this.companyName,
        this.monthlySalary,
        this.designation,
        this.firmName,
        this.itr,
        this.salaried,
        this.alreadyCreditCard,
        this.creditCardModel});

  CheckEligibilityModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    pan = json['pan'];
    email = json['email'];
    dob = json['dob'];
    address = json['address'];
    pinCode = json['pinCode'];
    companyName = json['companyName'];
    monthlySalary = json['monthlySalary'];
    designation = json['designation'];
    firmName = json['firmName'];
    itr = json['itr'];
    salaried = json['salaried'];
    alreadyCreditCard = json['alreadyCreditCard'];
    if (json['CreditCardModel'] != null) {
      creditCardModel = new List<CreditCardModel>();
      json['CreditCardModel'].forEach((v) {
        creditCardModel.add(new CreditCardModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['pan'] = this.pan;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['pinCode'] = this.pinCode;
    data['companyName'] = this.companyName;
    data['monthlySalary'] = this.monthlySalary;
    data['designation'] = this.designation;
    data['firmName'] = this.firmName;
    data['itr'] = this.itr;
    data['salaried'] = this.salaried;
    data['alreadyCreditCard'] = this.alreadyCreditCard;
    if (this.creditCardModel != null) {
      data['CreditCardModel'] =
          this.creditCardModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreditCardModel {
  String totalLimit;
  String availableLimit;
  String bankName;
  String vintage;

  CreditCardModel(
      {this.totalLimit, this.availableLimit, this.bankName, this.vintage});

  CreditCardModel.fromJson(Map<String, dynamic> json) {
    totalLimit = json['total_Limit'];
    availableLimit = json['available_Limit'];
    bankName = json['bank_name'];
    vintage = json['vintage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_Limit'] = this.totalLimit;
    data['available_Limit'] = this.availableLimit;
    data['bank_name'] = this.bankName;
    data['vintage'] = this.vintage;
    return data;
  }
}
