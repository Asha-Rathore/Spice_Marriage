import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spice_marriage/Screens/otp_verification.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import 'package:spice_marriage/Utils/app_navigation.dart';
import 'package:spice_marriage/Utils/app_route_name.dart';
import 'package:spice_marriage/Utils/regex_methods.dart';
import 'package:spice_marriage/Widgets/app_button.dart';
import 'package:spice_marriage/Widgets/app_logo.dart';
import 'package:spice_marriage/Widgets/app_template.dart';
import 'package:spice_marriage/Widgets/app_text_field.dart';
import 'package:spice_marriage/Widgets/screen_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utils/app_strings.dart';
import '../Widgets/flutter_toast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  String? code;
  String? user_id;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const AppLogo(),
              const ScreenAppBar(
                txt: AppStrings.FORGOT_PASSWORD_TEXT,
                leadingicon: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              AppTextField(
                txtController: emailController,
                hinttxt: AppStrings.EMAIL_TEXT,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    if (!val.isValidEmail) {
                      return AppStrings.EMIAL_VALIDATION_TEXT;
                    }
                  } else {
                    return AppStrings.REQUIRED_TEXT;
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              AppButton(
                txt: AppStrings.GET_CODE_BUTTON_TEXT,
                color: AppColors.RED_COLOR,
                txtcolor: Colors.white,
                iconcolor: Colors.black,
                prefixicon: false,
                onclick: () {
                  if (_formKey.currentState!.validate()) {
                    forgotPassword(emailController.text);
                    setState(() {
                      _isLoading = true;
                      code;
                      user_id;
                    });
                    // AppNavigation.navigateTo(
                    //   context,
                    //   AppRouteName.OTP_VERIFICATION_SCREEN_ROUTE,
                    //   arguments: user_id
                    // );
                  }
                  setState(() {
                    _isLoading = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  forgotPassword(String email) async {
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
      jsonData = json.decode(response.body);
      if (jsonData['status'] == 1) {
        Toast_Message(jsonData['message']);
        setState(() {
          var body = jsonDecode(response.body);
          code = body['data']['code'].toString();
          user_id = body['data']['user_id'].toString();
          print("=============" + code! + "=============");
          print(response.body);
          print("code sent");
          _isLoading = false;
          //sharedPreferences.setString("token", jsonData['token']);
        });
        AppNavigation.navigateTo(
          context,
          AppRouteName.OTP_VERIFICATION_SCREEN_ROUTE,
          arguments: user_id,
        );
      }
    } else {
      Toast_Message("Error...");
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
}
