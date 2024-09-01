import 'package:asadel/app/data/Alert2Response.dart';
import 'package:asadel/app/data/UsersResponse.dart';
import 'package:get_storage/get_storage.dart';

import '../constant/Constant.dart';




class Storage {
  const Storage._();

  static final GetStorage _storage = GetStorage();

  static GetStorage get storage => _storage;
  static Future<void> saveValue(String key, dynamic value) =>
      _storage.writeIfNull(key, value);

  static T? getValue<T>(String key) => _storage.read<T>(key);

  static bool hasData(String key) => _storage.hasData(key);

  static Future<void> removeValue(String key) => _storage.remove(key);

  static Future<void> clearStorage() => _storage.erase();


  static UsersResponse? get userData {
    final d = _storage.read(Constants.USER_DATA);
    if (d != null) {
      if (d is UsersResponse) {
        return d;
      } else {
        return UsersResponse.fromJson(d);
      }
    }
    return null;
  }

  static UsersData? get oneUserData {
    final d = _storage.read(Constants.USER_DATA_LIST
    );
    if (d != null) {
      if (d is UsersData) {
        return d;
      } else {
        return UsersData.fromJson(d);
      }
    }
    return null;
  }






}