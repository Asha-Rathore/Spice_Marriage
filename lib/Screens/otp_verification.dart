import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spice_marriage/Screens/reset_password.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import 'package:spice_marriage/Utils/regex_methods.dart';
import 'package:spice_marriage/Widgets/app_button.dart';
import 'package:spice_marriage/Widgets/app_logo.dart';
import 'package:spice_marriage/Widgets/app_template.dart';
import 'package:spice_marriage/Widgets/app_text_field.dart';
import 'package:spice_marriage/Widgets/screen_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utils/app_navigation.dart';
import '../Utils/app_route_name.dart';
import '../Utils/app_strings.dart';
import '../Widgets/flutter_toast.dart';

class OtpVerification extends StatefulWidget {
  final String? user_id;
  const OtpVerification({Key? key, this.user_id}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController codeController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;
  //String time = "00:" + secondsRemaining.toString();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

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
                txt: AppStrings.OTP_VERIFICATION_TEXT,
                leadingicon: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              AppTextField(
                txtController: codeController,
                hinttxt: AppStrings.ENTER_CODE_TEXT,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    return null;
                  } else {
                    return AppStrings.REQUIRED_TEXT;
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          enableResend ? resendCode(widget.user_id) : null;
                        },
                        child: const Text(
                          AppStrings.DID_NOT_RECEIVE_CODE_TEXT,
                          style: TextStyle(
                            color: AppColors.WHITE_COLOR,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 22.0),
                        child: Text(
                          '00:$secondsRemaining',
                          style: const TextStyle(
                            color: AppColors.WHITE_COLOR,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AppButton(
                txt: AppStrings.CONTINUE_BUTTON_TEXT,
                color: AppColors.RED_COLOR,
                txtcolor: Colors.white,
                iconcolor: Colors.black,
                prefixicon: false,
                onclick: () {
                  if (_formKey.currentState!.validate()) {
                    otpVerification(widget.user_id, codeController.text);
                    setState(() {
                      _isLoading = true;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  otpVerification(
    String? user_id,
    String code,
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
      jsonData = json.decode(response.body);
      if (jsonData['status'] == 1) {
        Toast_Message(jsonData['message']);
        setState(() {
          var body = jsonDecode(response.body);
          //user_id = body['data']['user_id'].toString();
          //print(user_id);
          print("code sent");
          _isLoading = false;
        });
        AppNavigation.navigateTo(
          context,
          AppRouteName.RESET_PASSWORD_SCREEN_ROUTE,
          arguments: user_id,
        );
      } 
      else {
        Toast_Message(jsonData['message']);
      }
    } 
    else {
      Toast_Message(jsonData['message']);
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  resendCode(String? user_id) async {
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
      jsonData = json.decode(response.body);
      Toast_Message(jsonData['message']);
      setState(() {
        var body = jsonDecode(response.body);
        user_id = body['data']['user_id'].toString();
        // String code = body['data']['code'].toString();
        //print("=============" + code + "=============");
        print(response.body);
        print("code sent");
        _isLoading = false;
      });
    } else {
      Toast_Message(jsonData['message']);
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
}
