import 'dart:async';

import 'package:asadel/common/api/data/api_helper.dart';
import 'package:asadel/common/api/data/api_helper_imp.dart';

import 'package:asadel/common/api/data/interface.dart';
import 'package:asadel/common/constant/prefs.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../customErrorWidget.dart';
class Initializer {
  static final Initializer instance = Initializer._internal();
  factory Initializer() => instance;
  Initializer._internal();

  void init(VoidCallback runApp) {
    ErrorWidget.builder = (errorDetails) {
      return CustomErrorWidget(
        message: errorDetails.exceptionAsString(),
      );
    };

    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (details) {
        FlutterError.dumpErrorToConsole(details);
        printInfo(info: details.stack.toString(),);
      };

      await _initServices();
      runApp();
    }, (error, stack) {
      printInfo(info: 'runZonedGuarded: ${stack.toString()}');
    });
  }

  Future<void> _initServices() async {
    try {
      await _initStorage();
      _initScreenPreference();
      _initApis();
    } catch (err) {
      rethrow;
    }
  }

  void _initApis() {
    Get.put<ApiHelper>(
      ApiHelperImpl(),);
    Get.put(Prefs(),);
    Get.put<ApiInterfaceController>(
      ApiInterfaceController(),);
  }

  Future<void> _initStorage() async {
    await GetStorage.init();
  }

  void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}