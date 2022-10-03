import 'package:flutter/material.dart';
import 'package:spice_marriage/Screens/login_screen.dart';
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

class ResetPassword extends StatefulWidget {
  final String? user_id;
  const ResetPassword({Key? key, this.user_id}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isLoading = false;
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
                txt: AppStrings.RESET_PASSWORD_TEXT,
                leadingicon: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              AppTextField(
                txtController: passwordController,
                hinttxt: AppStrings.NEW_PASSWORD_TEXT,
                obscuretxt: true,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    if (val.length < 6) {
                      return AppStrings.PASSWORD_VALIDATION_TEXT;
                    }
                  } else {
                    return AppStrings.REQUIRED_TEXT;
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AppTextField(
                txtController: confirmPasswordController,
                hinttxt: AppStrings.CONFIRM_PASSWORD_TEXT,
                obscuretxt: true,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    if (passwordController.text != confirmPasswordController.text) {
                      return AppStrings.RETYPE_PASSWORD_VALIDATION_TEXT;
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
                txt: AppStrings.RESET_PASSWORD_TEXT,
                color: AppColors.RED_COLOR,
                txtcolor: Colors.white,
                iconcolor: Colors.black,
                prefixicon: false,
                onclick: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    resetPassword(widget.user_id, passwordController.text);
                    AppNavigation.navigateTo(
                        context, AppRouteName.LOGIN_SCREEN_ROUTE);
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

  resetPassword(
    String? user_id,
    String new_password,
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
      jsonData = json.decode(response.body);
      Toast_Message(jsonData['message']);
      setState(() {
        print("password reset");
        _isLoading = false;
        sharedPreferences.setString("token", jsonData['token']);
      });
      AppNavigation.navigateTo(context, AppRouteName.LOGIN_SCREEN_ROUTE);
    } else {
      Toast_Message(jsonData['message']);
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
}
