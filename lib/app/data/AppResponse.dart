/// data : [{"idApp":1,"base_url":"122.160.201.198:3032","login":"Login","admin":"Admin","zone":"Zone","store":"Store","counter":"Counter","limit":50}]

class AppResponse {
  AppResponse({
      this.data,});

  AppResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// idApp : 1
/// base_url : "122.160.201.198:3032"
/// login : "Login"
/// admin : "Admin"
/// zone : "Zone"
/// store : "Store"
/// counter : "Counter"
/// limit : 50

class Data {
  Data({
      this.idApp, 
      this.baseUrl, 
      this.login, 
      this.admin, 
      this.zone, 
      this.store, 
      this.counter, 
      this.limit,});

  Data.fromJson(dynamic json) {
    idApp = json['idApp'];
    baseUrl = json['base_url'];
    login = json['login'];
    admin = json['admin'];
    zone = json['zone'];
    store = json['store'];
    counter = json['counter'];
    limit = json['limit'];
  }
  num? idApp;
  String? baseUrl;
  String? login;
  String? admin;
  String? zone;
  String? store;
  String? counter;
  int? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idApp'] = idApp;
    map['base_url'] = baseUrl;
    map['login'] = login;
    map['admin'] = admin;
    map['zone'] = zone;
    map['store'] = store;
    map['counter'] = counter;
    map['limit'] = limit;
    return map;
  }

}