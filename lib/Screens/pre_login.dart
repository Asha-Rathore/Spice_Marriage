import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import 'package:spice_marriage/Utils/app_strings.dart';
import 'package:spice_marriage/Widgets/app_button.dart';
import 'package:spice_marriage/Widgets/app_logo.dart';
import 'package:spice_marriage/Widgets/app_template.dart';
import 'package:spice_marriage/Widgets/screen_appbar.dart';
import '../Utils/app_navigation.dart';
import '../Utils/app_route_name.dart';
import '../Utils/assets_paths.dart';

class PreLogin extends StatefulWidget {
  const PreLogin({Key? key}) : super(key: key);

  @override
  State<PreLogin> createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {
  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const AppLogo(),
          const ScreenAppBar(txt: AppStrings.PRELOGIN_TEXT, leadingicon: false,),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          AppButton(
            txt: AppStrings.EMAIL_AUTH_TEXT,
            color: AppColors.WHITE_COLOR,
            txtcolor: AppColors.BLACK_COLOR,
            img: AssetPaths.EMAIL_ICON,
            iconcolor: AppColors.BLACK_COLOR,
            onclick: () {
              AppNavigation.navigateTo(context, AppRouteName.LOGIN_SCREEN_ROUTE);
              },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const AppButton(
            txt: AppStrings.FACEBOOK_AUTH_TEXT,
            color: Colors.blueAccent,
            txtcolor: AppColors.WHITE_COLOR,
            img: AssetPaths.FACEBOOK_ICON,
            iconcolor: AppColors.WHITE_COLOR,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const AppButton(
            txt: AppStrings.GOOGLE_AUTH_TEXT,
            color: AppColors.RED_COLOR,
            txtcolor: AppColors.WHITE_COLOR,
            img: AssetPaths.GOOGLE_ICON,
            iconcolor: AppColors.WHITE_COLOR,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const AppButton(
            txt: AppStrings.APPLE_AUTH_TEXT,
            color: AppColors.BLACK_COLOR,
            txtcolor: AppColors.WHITE_COLOR,
            img: AssetPaths.APPLE_LOGO_ICON,
            iconcolor: AppColors.WHITE_COLOR,
          )
        ],
      ),
    );
  }
}
