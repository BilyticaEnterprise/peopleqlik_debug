class ApprovalList {
  String? documentNo;
  int? hierarchyID;
  String? userName;
  String? company;
  String? modifiedDate;
  String? statusName;
  String? approverName;
  String? approverCompany;
  String? remarks;

  ApprovalList(
      {this.documentNo,
        this.hierarchyID,
        this.userName,
        this.company,
        this.modifiedDate,
        this.statusName,
        this.approverName,
        this.approverCompany,
        this.remarks});

  ApprovalList.fromJson(Map<String, dynamic> json) {
    documentNo = json['DocumentNo'];
    hierarchyID = json['HierarchyID'];
    userName = json['UserName'];
    company = json['Company'];
    modifiedDate = json['ModifiedDate'];
    statusName = json['StatusName'];
    approverName = json['ApproverName'];
    approverCompany = json['ApproverCompany'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentNo'] = this.documentNo;
    data['HierarchyID'] = this.hierarchyID;
    data['UserName'] = this.userName;
    data['Company'] = this.company;
    data['ModifiedDate'] = this.modifiedDate;
    data['StatusName'] = this.statusName;
    data['ApproverName'] = this.approverName;
    data['ApproverCompany'] = this.approverCompany;
    data['Remarks'] = this.remarks;
    return data;
  }
}