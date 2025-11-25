import 'package:app_project/modules/employee/add/add_employee_screen.dart';
import 'package:app_project/modules/login/Login_Screen.dart';
import 'package:app_project/shared/network/local/cache_helper.dart'
    show CacheHelper;
import 'package:app_project/shared/network/remote/dio_helper.dart'
    show DioHelper;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:window_manager/window_manager.dart';

import 'modules/employee/show/show_employee_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(600, 500), // ← أقل حجم ممكن
    size: Size(1000, 700), // ← الحجم الافتراضي
    center: true, // ← يفتح في الوسط
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: LogInAdminScreen(),
    );
  }
}
