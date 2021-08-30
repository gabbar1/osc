class SubmitLoadModel{
  String salary,cName,designation,exp,cEmail,cAdd,cState,cCity,cPincode;
  LoanModel loanModel;

  SubmitLoadModel({this.designation,this.salary,this.cAdd,this.cCity,this.cEmail,this.cName,this.cPincode,this.cState,this.exp,this.loanModel});

  SubmitLoadModel.fromJson(Map<String,dynamic> json){
    salary = json['salary'];
    cName = json['cName'];
    designation = json['designation'];
    exp = json['exp'];
    cEmail = json['cEmail'];
    cAdd = json['cAdd'];
    cState = json['cState'];
    cCity = json['cCity'];
    cPincode = json['cPincode'];
    loanModel = json['loanModel'];

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['salary'] = this.salary;
      data['cName'] = this.cName;
      data['designation'] = this.designation;
      data['exp'] = this.exp;
      data['cEmail'] = this.cEmail;
      data['cAdd'] = this.cAdd;
      data['cState'] = this.cState;
      data['cCity'] = this.cCity;
      data['cPincode'] = this.cPincode;
      data['loanModel'] = this.loanModel;
      return data;
    }
  }
}

class LoanModel {
  String mobile;
  String loanType;
  String name,email,dob,address,state,city,pincode;

  LoanModel(
      {this.mobile, this.loanType, this.name,this.dob,this.email,this.address,this.pincode,this.city,this.state});

  LoanModel.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    loanType = json['loanType'];
    name = json['name'];
    email = json['email'];
    dob = json['dob'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['loanType'] = this.loanType;
    data['name'] = this.name;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    return data;
  }
}