class GetEncashmentRequestBalanceJson {
  bool? isSuccess;
  List<SpecialBalanceResultSet>? resultSet;
  String? errorMessage;

  GetEncashmentRequestBalanceJson(
      {
        this.isSuccess,
        this.resultSet,
        this.errorMessage
      });

  GetEncashmentRequestBalanceJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = <SpecialBalanceResultSet>[];
      json['ResultSet'].forEach((v) {
        resultSet!.add(new SpecialBalanceResultSet.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class SpecialBalanceResultSet {
  dynamic balance;
  dynamic maxEncashmentUnit;
  String? createdDate;

  SpecialBalanceResultSet({this.balance, this.maxEncashmentUnit, this.createdDate});

  SpecialBalanceResultSet.fromJson(Map<String, dynamic> json) {
    balance = json['Balance'];
    maxEncashmentUnit = json['MaxEncashmentUnit'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Balance'] = this.balance;
    data['MaxEncashmentUnit'] = this.maxEncashmentUnit;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}