class MobileInfoModel {
  String? deviceID;
  String? name;
  String? deviceType;
  String? systemVersion;
  String? version;
  String? sysName;
  String? brand;

  MobileInfoModel(
      {this.deviceID,
        this.name,
        this.deviceType,
        this.systemVersion,
        this.version,
        this.brand,
        this.sysName});

  MobileInfoModel.fromJson(Map<String, dynamic> json) {
    deviceID = json['DeviceID'];
    name = json['Name'];
    deviceType = json['DeviceType'];
    systemVersion = json['SystemVersion'];
    version = json['Version'];
    sysName = json['SysName'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DeviceID'] = deviceID;
    data['Name'] = name;
    data['DeviceType'] = deviceType;
    data['SystemVersion'] = systemVersion;
    data['Version'] = version;
    data['SysName'] = sysName;
    data['brand'] = brand;
    return data;
  }
}