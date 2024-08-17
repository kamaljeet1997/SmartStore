/// data : [{"UserId":"11f5eb30-c97e-4c92-9ee4-ea33fb44ee3b","UserName":"shop master 4","UserEmail":"shop4@gmail.com","Password":"$2a$08$ikgzfymxptqLt8a6vhzSB.G870JFtLyJ46Bgv5FhuUAu67vZ89dlq","Gender":"Male","Address":"abc","ContactNo":"9876543210","Role":"Station Master","Status":"active","CreatedAt":"2024-08-03T03:22:04.000Z","UpdatedAt":"2024-08-03T03:22:04.000Z"},{"UserId":"1758a059-b9c9-434a-9285-b5559fff0630","UserName":"shop master 3","UserEmail":"shop3@gmail.com","Password":"$2a$08$pqUhinAmv9kExp4TbbtjGOZxI2touB5Ip/LMydaDV8cei6BW.FRze","Gender":"Male","Address":"abc","ContactNo":"9876543210","Role":"Station Master","Status":"active","CreatedAt":"2024-08-02T13:46:44.000Z","UpdatedAt":"2024-08-02T13:46:44.000Z"},{"UserId":"29330bf2-d537-424a-8ab3-1bce4026d617","UserName":"Store Manager 1","UserEmail":"shop@gmail.com","Password":"$2a$08$cXufEee66TWu42CFJTYpVOcUv3txCy.p/sk62rVR8tOZ7eOdxnKUC","Gender":"Male","Address":"abxx","ContactNo":"9876543210","Role":"Station Master","Status":"active","CreatedAt":"2024-07-12T04:17:25.000Z","UpdatedAt":"2024-08-04T02:43:28.000Z"},{"UserId":"322a7b63-719d-41c1-b480-f9c54e604127","UserName":"zone","UserEmail":"zone@gmail.com","Password":"$2a$08$dll8Ab4ZP/Mjjk6K3WCcFeNHpi6UtP1su0UkKKJ53ECavpBS.ExCi","Gender":"Male","Address":"abc","ContactNo":"9876543210","Role":"Zone Supervisor","Status":"active","CreatedAt":"2024-07-12T04:16:52.000Z","UpdatedAt":"2024-08-02T12:05:52.000Z"},{"UserId":"3339a70c-d4e8-4c85-8438-d3bb8bb32a07","UserName":"Zone Master","UserEmail":"zone2@gmail.com","Password":"$2a$08$o6WN/IFxScfVx7lG/cR0h.Nlsjm9nNxtizmLOQSk1zSwp1cnob9yi","Gender":"Male","Address":"abc","ContactNo":"9876543210","Role":"Line Supervisor","Status":"active","CreatedAt":"2024-08-03T03:20:53.000Z","UpdatedAt":"2024-08-03T03:20:53.000Z"},{"UserId":"644253c6-73fc-4947-84ff-2e02612c82fc","UserName":"Shop Master 2","UserEmail":"shop2@gmail.com","Password":"$2a$08$QKXMlcSsUxGjTkhg9Icn2eOYmj2OFQZAION51GFOBSujzT1MQZt8e","Gender":"Male","Address":"abc","ContactNo":"9876543210","Role":"Station Master","Status":"active","CreatedAt":"2024-08-02T13:48:01.000Z","UpdatedAt":"2024-08-02T13:48:01.000Z"},{"UserId":"d41183ca-dfe3-4975-a0d6-086d7179dfd6","UserName":"Admin master","UserEmail":"admin@gmail.com","Password":"$2a$08$V2fWBRH2U735NJywVq2CTuIKp7C76qDi5/cfHt5AS.MzmQT/JhzXa","Gender":"Male","Address":"abc","ContactNo":"9876543210","Role":"Admin","Status":"active","CreatedAt":"2024-06-23T02:47:17.000Z","UpdatedAt":"2024-06-23T02:47:17.000Z"}]

class UsersResponse {
  UsersResponse({
      this.data,});

  UsersResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(UsersData.fromJson(v));
      });
    }
  }
  List<UsersData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// UserId : "11f5eb30-c97e-4c92-9ee4-ea33fb44ee3b"
/// UserName : "shop master 4"
/// UserEmail : "shop4@gmail.com"
/// Password : "$2a$08$ikgzfymxptqLt8a6vhzSB.G870JFtLyJ46Bgv5FhuUAu67vZ89dlq"
/// Gender : "Male"
/// Address : "abc"
/// ContactNo : "9876543210"
/// Role : "Station Master"
/// Status : "active"
/// CreatedAt : "2024-08-03T03:22:04.000Z"
/// UpdatedAt : "2024-08-03T03:22:04.000Z"

class UsersData {
  UsersData({
      this.userId,
      this.userName,
      this.userEmail,
      this.password,
      this.gender,
      this.address,
      this.contactNo,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt,});

  UsersData.fromJson(dynamic json) {
    userId = json['UserId'];
    userName = json['UserName'];
    userEmail = json['UserEmail'];
    password = json['Password'];
    password_D = json['Password_D'];
    gender = json['Gender'];
    address = json['Address'];
    contactNo = json['ContactNo'];
    role = json['Role'];
    status = json['Status'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
  }
  String? userId;
  String? userName;
  String? userEmail;
  String? password;
  String? password_D;
  String? gender;
  String? address;
  String? contactNo;
  String? role;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserId'] = userId;
    map['UserName'] = userName;
    map['UserEmail'] = userEmail;
    map['Password'] = password;
    map['Password_D'] = password_D;
    map['Gender'] = gender;
    map['Address'] = address;
    map['ContactNo'] = contactNo;
    map['Role'] = role;
    map['Status'] = status;
    map['CreatedAt'] = createdAt;
    map['UpdatedAt'] = updatedAt;
    return map;
  }

}