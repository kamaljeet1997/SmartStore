

import 'package:get_storage/get_storage.dart';

class Prefs {
  // final apiKey = ''.val('apiKey');
  final accessToken = ''.val('accessToken');
  final logindata = ''.val('accessToken');
  final email = ''.val('email');
  final pass = ''.val('pass');

  clear() {
    // accessToken.val = "";
    email.val="";
    pass.val="";
    // attendance.val="" as AttendanceResponse;
    // apiKey.val = "";
  }
  clearDM(){
    // dynamicModule.val.data=null;
    // dynamicModule.val.contentlibrary=null;
    // subdomain.val="";
  }
}