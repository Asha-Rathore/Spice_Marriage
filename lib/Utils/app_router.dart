import 'package:flutter/material.dart';
import 'package:spice_marriage/Screens/detail_screen.dart';
import 'package:spice_marriage/Screens/forgot_password.dart';
import 'package:spice_marriage/Screens/game_setting.dart';
import 'package:spice_marriage/Screens/login_screen.dart';
import 'package:spice_marriage/Screens/menu_screen.dart';
import 'package:spice_marriage/Screens/otp_verification.dart';
import 'package:spice_marriage/Screens/pre_login.dart';
import 'package:spice_marriage/Screens/reset_password.dart';
import 'package:spice_marriage/Screens/signup_screen.dart';
import 'package:spice_marriage/Screens/splash_screen.dart';
import 'package:spice_marriage/Utils/app_route_name.dart';

class AppRouter{
  Route onGenerateRoute(RouteSettings routeSettings){
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context){
        switch (routeSettings.name){
          case AppRouteName.SPLASH_SCREEN_ROUTE:
            return const SplashScreen();
          
          case AppRouteName.PRE_LOGIN_SCREEN_ROUTE:
            return const PreLogin();

          case AppRouteName.LOGIN_SCREEN_ROUTE:
            return const LoginScreen();

          case AppRouteName.FORGOT_PASSWORD_SCREEN_ROUTE:
            return const ForgotPasswordScreen();

          case AppRouteName.SIGNUP_SCREEN_ROUTE:
            return const SignupScreen();

          case AppRouteName.MENU_SCREEN_ROUTE:
            return const MenuScreen();

          case AppRouteName.DETAILS_SCREEN_ROUTE:
            return const DetailsScreen();

          case AppRouteName.GAME_SETTING_SCREEN_ROUTE:
            return const GameSetting();

          case AppRouteName.OTP_VERIFICATION_SCREEN_ROUTE:
            final args = routeSettings.arguments as String;
            return OtpVerification(
              user_id: args,
            );

          case AppRouteName.RESET_PASSWORD_SCREEN_ROUTE:
            final args = routeSettings.arguments as String;
            return ResetPassword(
              user_id: args,
            );  

          default:
            return Container();
        }
      }
    );
  }
}