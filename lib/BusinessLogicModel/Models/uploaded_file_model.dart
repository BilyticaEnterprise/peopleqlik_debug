class GetUploadedFileJson {
  bool? isSuccess;
  UploadedResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetUploadedFileJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetUploadedFileJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new UploadedResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet?.toJson();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class UploadedResultSet {
  String? docPath;
  String? docName;
  String? docNameOriginal;

  UploadedResultSet({this.docPath, this.docName, this.docNameOriginal});

  UploadedResultSet.fromJson(Map<String, dynamic> json) {
    docPath = json['DocPath'];
    docName = json['DocName'];
    docNameOriginal = json['DocNameOriginal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocPath'] = this.docPath;
    data['DocName'] = this.docName;
    data['DocNameOriginal'] = this.docNameOriginal;
    return data;
  }
}