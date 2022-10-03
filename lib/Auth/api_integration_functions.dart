import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Screens/otp_verification.dart';
import '../Screens/reset_password.dart';
import '../Utils/app_navigation.dart';
import '../Utils/app_route_name.dart';
import '../Widgets/flutter_toast.dart';

class ApiIntegration{

  static bool _isLoading = false;
  static late SharedPreferences sharedPreferences;
  
  static signIn(String email, String password, BuildContext context)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': password,
    };
    print("data is " + data.toString());

    var jsonData = null;
    var url = Uri.parse("http://server.appsstaging.com:3079/api/login");
    var response = await http.post(
      url,
      body: data,
    );
    if (response.statusCode == 200) {
      Toast_Message("Login Successfully...");
      jsonData = json.decode(response.body);
      setState(() {
        print("Logged in");
        _isLoading = false;
        sharedPreferences.setString("token", jsonData['token']);
      });
      AppNavigation.navigateTo(context, AppRouteName.MENU_SCREEN_ROUTE);
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  static signUp(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    Map data = {
      'name': name,
      'email': email,
      'password': password,
    };
    print("data is " + data.toString());

    var jsonData = null;
    var url = Uri.parse("http://server.appsstaging.com:3079/api/register");
    var response = await http.post(
      url,
      body: data,
    );
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        print("Registered Successfully");
        Toast_Message("Signup Successfully...");
        _isLoading = false;
        AppNavigation.navigateTo(context, AppRouteName.LOGIN_SCREEN_ROUTE);
      });
    } else {
      print(response.body);
    }
  }

  static forgotPassword(String code, String user_id, String email, BuildContext context) async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
    };
    print("data is " + data.toString());

    var jsonData = null;
    var url =
        Uri.parse("http://server.appsstaging.com:3079/api/forgotPassword");
    var response = await http.post(
      url,
      body: data,
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      user_id = body['data']['user_id'].toString();
      Toast_Message("Code sent Successfully...");
      jsonData = json.decode(response.body);
      setState(() {
        var body = jsonDecode(response.body);
        code = body['data']['code'].toString();
        user_id = body['data']['user_id'].toString();
        print("=============" + code + "=============");
        print(response.body);
        print("code sent");
        _isLoading = false;
        //sharedPreferences.setString("token", jsonData['token']);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerification(
            user_id: user_id,
          ),
        ),
      );
      //AppNavigation.navigateTo(context, AppRouteName.OTP_VERIFICATION_SCREEN_ROUTE);
    } else {
      Toast_Message("Error...");
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  static otpVerification(
    String? user_id,
    String code,
    BuildContext context
  ) async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'user_id': user_id,
      "verification_code": code,
    };
    print("data is " + data.toString());

    var jsonData = null;
    var url = Uri.parse("http://server.appsstaging.com:3079/api/verifyCode");
    var response = await http.post(
      url,
      body: data,
    );
    if (response.statusCode == 200) {
      Toast_Message("Otp verified...");
      jsonData = json.decode(response.body);
      setState(() {
        var body = jsonDecode(response.body);
        user_id = body['data']['user_id'].toString();
        print(user_id);
        print("code sent");
        _isLoading = false;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => ResetPassword(
            user_id: user_id,
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  static resendCode(String? user_id, BuildContext context) async {
    Map data = {
      'user_id': user_id,
    };
    print("data is " + data.toString());

    var jsonData = null;
    var url = Uri.parse("http://server.appsstaging.com:3079/api/resendcode");
    var response = await http.post(
      url,
      body: data,
    );
    if (response.statusCode == 200) {
      Toast_Message("Code sent Successfully...");
      jsonData = json.decode(response.body);
      setState(() {
        var body = jsonDecode(response.body);
        user_id = body['data']['user_id'].toString();
        String code = body['data']['code'].toString();
        print("=============" + code + "=============");
        print(response.body);
        print("code sent"); 
        _isLoading = false;
      });
    } else {
      Toast_Message("Error...");
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  static resetPassword(
    String? user_id,
    String new_password,
    BuildContext context
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'user_id': user_id,
      "new_password": new_password,
    };
    print("data is " + data.toString());

    var jsonData = null;
    var url = Uri.parse("http://server.appsstaging.com:3079/api/resetPassword");
    var response = await http.post(
      url,
      body: data,
    );
    if (response.statusCode == 200) {
      Toast_Message("Password reset successfully...");
      jsonData = json.decode(response.body);
      setState(() {
        print("password reset");
        _isLoading = false;
        sharedPreferences.setString("token", jsonData['token']);
      });
      AppNavigation.navigateTo(context, AppRouteName.LOGIN_SCREEN_ROUTE);
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  static checkLoginStatus(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null){
      AppNavigation.navigateTo(context, AppRouteName.PRE_LOGIN_SCREEN_ROUTE);
    }
    else {
      AppNavigation.navigateTo(context, AppRouteName.MENU_SCREEN_ROUTE);
    }
  }
  
  static void setState(Null Function() param0) {}
}