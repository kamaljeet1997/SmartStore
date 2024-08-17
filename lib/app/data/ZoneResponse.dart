/// data : [{"ZoneID":"f9734195-8a87-481d-abf2-ae12c4b2c644","ZoneName":"zone 1","ZoneDescription":"zone 1","CreatedAt":"2024-07-11T00:56:35.000Z","UpdatedAt":"2024-07-11T00:56:35.000Z"}]

class ZoneResponse {
  ZoneResponse({
      this.data,});

  ZoneResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ZoneData.fromJson(v));
      });
    }
  }
  List<ZoneData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ZoneID : "f9734195-8a87-481d-abf2-ae12c4b2c644"
/// ZoneName : "zone 1"
/// ZoneDescription : "zone 1"
/// CreatedAt : "2024-07-11T00:56:35.000Z"
/// UpdatedAt : "2024-07-11T00:56:35.000Z"

class ZoneData {
  ZoneData({
      this.zoneID, 
      this.zoneName, 
      this.zoneDescription, 
      this.createdAt, 
      this.updatedAt,});

  ZoneData.fromJson(dynamic json) {
    zoneID = json['ZoneID'];
    zoneName = json['ZoneName'];
    zoneDescription = json['ZoneDescription'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
  }
  String? zoneID;
  String? zoneName;
  String? zoneDescription;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ZoneID'] = zoneID;
    map['ZoneName'] = zoneName;
    map['ZoneDescription'] = zoneDescription;
    map['CreatedAt'] = createdAt;
    map['UpdatedAt'] = updatedAt;
    return map;
  }

}