/// data : [{"CounterID":"a849bebd-f85e-4616-b622-626287aa72bd","StoreID":"fd2c735a-c9d8-4c30-b95f-dc4371c4c9a2","CounterName":"counter 1","CounterDescription":"counter 1","CreatedAt":"2024-07-11T00:57:17.000Z","UpdatedAt":"2024-08-04T11:04:32.000Z"},{"CounterID":"bc3853b7-6e09-437d-9bfa-925988cde31e","StoreID":"fd2c735a-c9d8-4c30-b95f-dc4371c4c9a2","CounterName":"Counter2","CounterDescription":"this is counter 2","CreatedAt":"2024-08-04T05:32:12.000Z","UpdatedAt":"2024-08-04T05:32:12.000Z"}]

class CounterResponse {
  CounterResponse({
      this.data,});

  CounterResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CounterData.fromJson(v));
      });
    }
  }
  List<CounterData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// CounterID : "a849bebd-f85e-4616-b622-626287aa72bd"
/// StoreID : "fd2c735a-c9d8-4c30-b95f-dc4371c4c9a2"
/// CounterName : "counter 1"
/// CounterDescription : "counter 1"
/// CreatedAt : "2024-07-11T00:57:17.000Z"
/// UpdatedAt : "2024-08-04T11:04:32.000Z"

class CounterData {
  CounterData({
      this.counterID, 
      this.storeID, 
      this.counterName, 
      this.counterDescription, 
      this.createdAt, 
      this.updatedAt,});

  CounterData.fromJson(dynamic json) {
    counterID = json['CounterID'];
    storeID = json['StoreID'];
    counterName = json['CounterName'];
    counterDescription = json['CounterDescription'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
  }
  String? counterID;
  String? storeID;
  String? counterName;
  String? counterDescription;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CounterID'] = counterID;
    map['StoreID'] = storeID;
    map['CounterName'] = counterName;
    map['CounterDescription'] = counterDescription;
    map['CreatedAt'] = createdAt;
    map['UpdatedAt'] = updatedAt;
    return map;
  }

}