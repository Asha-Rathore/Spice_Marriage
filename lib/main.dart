//import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spice_marriage/Utils/app_strings.dart';
import 'package:spice_marriage/Utils/constants.dart';
import 'Utils/app_router.dart';

void main() {
  runApp(
    // DevicePreview(
    //   enabled: true,
    //   tools: [...DevicePreview.defaultTools],
    //   builder: (context) => const MyApp(),
    // ),
    const MyApp(),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.APP_TITLE_TEXT,
          onGenerateRoute: AppRouter().onGenerateRoute,
          theme: ThemeData(
            primarySwatch: Colors.grey,
            fontFamily: Constants.APP_FONT_FAMILY,
          ),
        );
      },
    );
  }
}
