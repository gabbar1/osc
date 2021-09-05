class UserBankDetailModel {
  String bankName;
  String accHolderName;
  String accHolderNumber;
  String accHolderIfsc;
  String accHolderDocType;
  String accHolderDocUrl;
  bool docVerification;

  UserBankDetailModel(
      {this.bankName,
        this.accHolderName,
        this.accHolderNumber,
        this.accHolderIfsc,
        this.accHolderDocType,
        this.accHolderDocUrl,
        this.docVerification});

  UserBankDetailModel.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    accHolderName = json['acc_holder_name'];
    accHolderNumber = json['acc_holder_number'];
    accHolderIfsc = json['acc_holder_ifsc'];
    accHolderDocType = json['acc_holder_doc_type'];
    accHolderDocUrl = json['acc_holder_doc_url'];
    docVerification = json['doc_verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = this.bankName;
    data['acc_holder_name'] = this.accHolderName;
    data['acc_holder_number'] = this.accHolderNumber;
    data['acc_holder_ifsc'] = this.accHolderIfsc;
    data['acc_holder_doc_type'] = this.accHolderDocType;
    data['acc_holder_doc_url'] = this.accHolderDocUrl;
    data['doc_verification'] = this.docVerification;
    return data;
  }
}
