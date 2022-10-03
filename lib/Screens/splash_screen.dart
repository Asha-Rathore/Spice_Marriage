import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spice_marriage/Utils/app_navigation.dart';
import 'package:spice_marriage/Utils/app_route_name.dart';
import 'package:spice_marriage/Widgets/app_logo.dart';
import 'package:spice_marriage/Widgets/app_template.dart';
import '../Utils/assets_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

      late AnimationController rotationController;
    late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    //checkLoginStatus();
    // rotationController = AnimationController(
    //   duration: const Duration(milliseconds: 500),
    //   vsync: this,
    // );
    // rotationController.repeat();
    Timer(
      const Duration(seconds: 3),
      () => checkLoginStatus()
      // () => Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const MenuScreen(),
      //   ),
      // ),
    );
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null){
      AppNavigation.navigateTo(context, AppRouteName.PRE_LOGIN_SCREEN_ROUTE);
    }
    else {
      AppNavigation.navigateTo(context, AppRouteName.MENU_SCREEN_ROUTE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppTemplate(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 50,
                right: 50,
              ),
              child: AppLogo(),
            ),
            //RotationTransition(
              //turns: Tween(begin: 1.0, end: 0.9).animate(rotationController),
              //child: 
              Image.asset(
                AssetPaths.LOADER_ICON,
                height: 50,
                width: 50,
              ),
            //),
          ],
        ),
      ),
    );
  }
}
