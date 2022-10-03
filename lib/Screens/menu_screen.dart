import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import 'package:spice_marriage/Widgets/app_button.dart';
import 'package:spice_marriage/Widgets/app_container.dart';
import 'package:spice_marriage/Widgets/app_logo.dart';
import 'package:spice_marriage/Widgets/app_template.dart';
import 'package:spice_marriage/Widgets/screen_appbar.dart';
import '../Utils/app_navigation.dart';
import '../Utils/app_route_name.dart';
import '../Utils/app_strings.dart';
import '../Utils/assets_paths.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  AssetPaths.ARROW_BACK_ICON,
                  color: AppColors.WHITE_COLOR,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const AppLogo(),
          const ScreenAppBar(
            txt: AppStrings.SWIPE_FOR_SELECTION_TEXT,
            leadingicon: false,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppContainer(
                conColor: AppColors.RED_COLOR,
                txt: AppStrings.STANDARD_TEXT,
                onclick: () {
                  AppNavigation.navigateTo(context, AppRouteName.GAME_SETTING_SCREEN_ROUTE);
                },
              ),
              const AppContainer(
                conColor: AppColors.BLACK_COLOR,
                txt: AppStrings.THEMED_TEXT,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          AppButton(
            txt: AppStrings.MY_ACTIVITY_TEXT,
            color: AppColors.RED_COLOR,
            txtcolor: Colors.white,
            iconcolor: Colors.black,
            prefixicon: false,
            onclick: () {
              AppNavigation.navigateTo(context, AppRouteName.DETAILS_SCREEN_ROUTE);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          AppButton(
            txt: AppStrings.LOGOUT_TEXT,
            color: AppColors.RED_COLOR,
            txtcolor: Colors.white,
            iconcolor: Colors.black,
            prefixicon: false,
            onclick: () async {
              sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.clear();
              sharedPreferences.commit();
              AppNavigation.navigateTo(context, AppRouteName.PRE_LOGIN_SCREEN_ROUTE);
            },
          ),
        ],
      ),
    );
  }
}
