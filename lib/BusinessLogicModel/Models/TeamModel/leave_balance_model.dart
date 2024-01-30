class GetEmployeeLeaveBalanceModel {
  bool? isSuccess;
  List<LeaveBalanceResultSet>? resultSet;
  dynamic message;
  dynamic errorMessage;

  GetEmployeeLeaveBalanceModel(
      {this.isSuccess,
        this.resultSet,
        this.message,
        this.errorMessage,
      });

  GetEmployeeLeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = <LeaveBalanceResultSet>[];
      json['ResultSet'].forEach((v) {
        resultSet!.add(LeaveBalanceResultSet.fromJson(v));
      });
    }
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.map((v) => v.toJson()).toList();
    }
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class LeaveBalanceResultSet {
  String? leaveName;
  double? totalBalance;
  double? nETbalance;
  double? availedBalance;
  double? carryOverBalance;
  double? encashedBalance;
  double? policyDeduction;

  LeaveBalanceResultSet(
      {this.leaveName,
        this.totalBalance,
        this.nETbalance,
        this.availedBalance,
        this.carryOverBalance,
        this.encashedBalance,
        this.policyDeduction});

  LeaveBalanceResultSet.fromJson(Map<String, dynamic> json) {
    leaveName = json['LeaveName'];
    totalBalance = json['TotalBalance'];
    nETbalance = json['NETbalance'];
    availedBalance = json['AvailedBalance'];
    carryOverBalance = json['CarryOverBalance'];
    encashedBalance = json['EncashedBalance'];
    policyDeduction = json['PolicyDeduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeaveName'] = this.leaveName;
    data['TotalBalance'] = this.totalBalance;
    data['NETbalance'] = this.nETbalance;
    data['AvailedBalance'] = this.availedBalance;
    data['CarryOverBalance'] = this.carryOverBalance;
    data['EncashedBalance'] = this.encashedBalance;
    data['PolicyDeduction'] = this.policyDeduction;
    return data;
  }
}