/// data : [{"StoreID":"88e7da3b-7fc7-4bf2-ae3b-c1b52784f1cb","ZoneID":"f9734195-8a87-481d-abf2-ae12c4b2c644","StoreName":"shop4","StoreDescription":"this is shop 4","CreatedAt":"2024-08-04T02:49:13.000Z","UpdatedAt":"2024-08-04T10:59:13.000Z","UserId":"644253c6-73fc-4947-84ff-2e02612c82fc"},{"StoreID":"baff8489-b924-4f2e-b6de-77fbd4365aa8","ZoneID":"f9734195-8a87-481d-abf2-ae12c4b2c644","StoreName":"shop 1","StoreDescription":"shop 1","CreatedAt":"2024-07-11T00:56:53.000Z","UpdatedAt":"2024-08-04T10:59:13.000Z","UserId":"644253c6-73fc-4947-84ff-2e02612c82fc"},{"StoreID":"fd2c735a-c9d8-4c30-b95f-dc4371c4c9a2","ZoneID":"f9734195-8a87-481d-abf2-ae12c4b2c644","StoreName":"shop 2","StoreDescription":"this is shop 2","CreatedAt":"2024-08-04T02:55:55.000Z","UpdatedAt":"2024-08-04T02:55:55.000Z","UserId":"644253c6-73fc-4947-84ff-2e02612c82fc"}]

class StoreResponse {
  StoreResponse({
      this.data,});

  StoreResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(StoreData.fromJson(v));
      });
    }
  }
  List<StoreData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// StoreID : "88e7da3b-7fc7-4bf2-ae3b-c1b52784f1cb"
/// ZoneID : "f9734195-8a87-481d-abf2-ae12c4b2c644"
/// StoreName : "shop4"
/// StoreDescription : "this is shop 4"
/// CreatedAt : "2024-08-04T02:49:13.000Z"
/// UpdatedAt : "2024-08-04T10:59:13.000Z"
/// UserId : "644253c6-73fc-4947-84ff-2e02612c82fc"

class StoreData {
  StoreData({
      this.storeID, 
      this.zoneID, 
      this.storeName, 
      this.storeDescription, 
      this.createdAt, 
      this.updatedAt, 
      this.userId,});

  StoreData.fromJson(dynamic json) {
    storeID = json['StoreID'];
    zoneID = json['ZoneID'];
    storeName = json['StoreName'];
    storeDescription = json['StoreDescription'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    userId = json['UserId'];
  }
  String? storeID;
  String? zoneID;
  String? storeName;
  String? storeDescription;
  String? createdAt;
  String? updatedAt;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StoreID'] = storeID;
    map['ZoneID'] = zoneID;
    map['StoreName'] = storeName;
    map['StoreDescription'] = storeDescription;
    map['CreatedAt'] = createdAt;
    map['UpdatedAt'] = updatedAt;
    map['UserId'] = userId;
    return map;
  }

}