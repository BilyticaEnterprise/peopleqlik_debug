class AddRemoveDeviceMapper {
  int? userID;
  MobileInfoModel? registeredDevice;
  List<InActiveDevices>? inActiveDevices;

  AddRemoveDeviceMapper(
      {this.userID, this.registeredDevice, this.inActiveDevices});

  AddRemoveDeviceMapper.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    registeredDevice = json['RegisteredDevice'] != null
        ? MobileInfoModel.fromJson(json['RegisteredDevice'])
        : null;
    if (json['InActiveDevices'] != null) {
      inActiveDevices = <InActiveDevices>[];
      json['InActiveDevices'].forEach((v) {
        inActiveDevices!.add(new InActiveDevices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    if (this.registeredDevice != null) {
      data['RegisteredDevice'] = this.registeredDevice!.toJson();
    }
    if (this.inActiveDevices != null) {
      data['InActiveDevices'] =
          this.inActiveDevices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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
        this.sysName,
        this.brand
      });

  MobileInfoModel.fromJson(Map<String, dynamic> json) {
    deviceID = json['DeviceID'];
    name = json['Name'];
    deviceType = json['DeviceType'];
    systemVersion = json['SystemVersion'];
    version = json['Version'];
    sysName = json['SysName'];
    brand = json['Brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DeviceID'] = deviceID;
    data['Name'] = name;
    data['DeviceType'] = deviceType;
    data['SystemVersion'] = systemVersion;
    data['Version'] = version;
    data['SysName'] = sysName;
    data['Brand'] = brand;
    return data;
  }
}

class InActiveDevices {
  String? iD;

  InActiveDevices({this.iD});

  InActiveDevices.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    return data;
  }
}