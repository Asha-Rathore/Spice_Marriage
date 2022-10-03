import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import 'package:spice_marriage/Utils/app_navigation.dart';
import 'package:spice_marriage/Utils/app_route_name.dart';
import 'package:spice_marriage/Utils/app_strings.dart';
import 'package:spice_marriage/Widgets/app_button.dart';
import 'package:spice_marriage/Widgets/app_logo.dart';
import 'package:spice_marriage/Widgets/app_template.dart';
import 'package:spice_marriage/Widgets/app_text_field.dart';
import 'package:spice_marriage/Widgets/bottom_container.dart';
import 'package:spice_marriage/Widgets/flutter_toast.dart';
import 'package:spice_marriage/Widgets/screen_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spice_marriage/Utils/regex_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.RED_COLOR,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    const AppLogo(),
                    const ScreenAppBar(
                      txt: AppStrings.LOGIN_TEXT,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 22.0),
                        child: InkWell(
                          onTap: () {
                            AppNavigation.navigateTo(context, AppRouteName.FORGOT_PASSWORD_SCREEN_ROUTE);
                          },
                          child: const Text(
                            AppStrings.FORGOT_YOUR_PASSWORD_TEXT,
                            style: TextStyle(
                              color: AppColors.WHITE_COLOR,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    AppButton(
                      txt: AppStrings.LOGIN_BUTTON_TEXT,
                      color: AppColors.RED_COLOR,
                      txtcolor: Colors.white,
                      iconcolor: Colors.black,
                      prefixicon: false,
                      onclick: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          signIn(emailController.text, passwordController.text);
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.0,
                          top: MediaQuery.of(context).size.height * 0.19),
                      child: BottomContainer(
                        firsttxt: AppStrings.DONT_HAVE_ACC_TEXT,
                        sectxt: AppStrings.SIGNUP_BUTTON_TEXT,
                        onclick: () {
                          AppNavigation.navigateTo(context, AppRouteName.SIGNUP_SCREEN_ROUTE);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
      //const Spacer(),
    );
  }

  signIn(String email, String password) async {
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
