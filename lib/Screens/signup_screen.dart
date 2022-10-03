import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import 'package:spice_marriage/Utils/app_strings.dart';
import 'package:spice_marriage/Utils/regex_methods.dart';
import 'package:spice_marriage/Widgets/app_button.dart';
import 'package:spice_marriage/Widgets/app_logo.dart';
import 'package:spice_marriage/Widgets/app_template.dart';
import 'package:spice_marriage/Widgets/app_text_field.dart';
import 'package:spice_marriage/Widgets/bottom_container.dart';
import 'package:spice_marriage/Widgets/screen_appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utils/app_navigation.dart';
import '../Utils/app_route_name.dart';
import '../Widgets/flutter_toast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reTypePasswordController = TextEditingController();

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
              AppLogo(),
              const ScreenAppBar(
                txt: AppStrings.SIGNUP_TEXT,
                leadingicon: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              AppTextField(
                txtController: nameController,
                hinttxt: AppStrings.FULL_NAME_TEXT,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    if (!val.isValidName) {
                      return AppStrings.EMIAL_VALIDATION_TEXT;
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
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AppTextField(
                txtController: passwordController,
                hinttxt: AppStrings.PASSWORD_TEXT,
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
                txtController: reTypePasswordController,
                hinttxt: AppStrings.RE_TYPE_PASSWORD_TEXT,
                obscuretxt: true,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    if (passwordController.text != reTypePasswordController.text) {
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
                txt: AppStrings.SIGNUP_BUTTON_TEXT,
                color: AppColors.RED_COLOR,
                txtcolor: Colors.white,
                iconcolor: Colors.black,
                prefixicon: false,
                onclick: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    signUp(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                    );
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 10.0, top: MediaQuery.of(context).size.height * 0.10),
                child: BottomContainer(
                  firsttxt: AppStrings.HAVE_ACC_TEXT,
                  sectxt: AppStrings.LOGIN_BUTTON_TEXT,
                  onclick: () {
                    AppNavigation.navigateTo(context, AppRouteName.LOGIN_SCREEN_ROUTE);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signUp(
    String name,
    String email,
    String password,
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
}
