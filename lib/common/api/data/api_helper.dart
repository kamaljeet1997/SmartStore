
import 'package:asadel/app/data/AppResponse.dart';
import 'package:asadel/app/data/CameraResponse.dart';
import 'package:asadel/app/data/CounterResponse.dart';
import 'package:asadel/app/data/StoreResponse.dart';
import 'package:asadel/app/data/ZoneResponse.dart';
import 'package:get/get.dart';
export 'package:asadel/common/api/utils/extension.dart';
export 'package:asadel/common/api/utils/utils.dart';
import '../../../app/data/Alert2Response.dart';
import '../../../app/data/UsersResponse.dart';

mixin ApiHelper {
  // Future<Response<UsersResponse>> Login(FormData formData, Map<String, String> data);
  Future<Response<UsersResponse>> getUsers();
  Future<Response<Alert2Response>> getAlerts();
  Future<Response<Alert2Response>> getAdminAlerts();
  Future<Response<Alert2Response>> getStore();
  Future<Response<Alert2Response>> getZone();
  Future<Response<CounterResponse>> getCounter();
  Future<Response<CameraResponse>> getCamera();
  Future<Response<AppResponse>> getApp();


}
