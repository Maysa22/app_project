import 'package:app_project/modules/login/Login_Screen.dart';
import 'package:app_project/shared/network/local/cache_helper.dart' show CacheHelper;
import 'package:app_project/shared/network/remote/dio_helper.dart' show DioHelper;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LogInAdminScreen());
  }
}
