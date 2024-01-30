class CookieJson {

  String? cookie;
  CookieJson({this.cookie});

  CookieJson.fromJson(Map<String, dynamic> json) {
    cookie = json['cookie'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cookie'] = cookie;
    return data;
  }
}

