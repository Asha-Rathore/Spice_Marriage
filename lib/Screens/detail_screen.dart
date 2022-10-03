import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import 'package:spice_marriage/Utils/app_strings.dart';
import 'package:spice_marriage/Utils/assets_paths.dart';
import 'package:spice_marriage/Widgets/app_button.dart';
import 'package:spice_marriage/Widgets/profile_container.dart';
import 'package:spice_marriage/Widgets/profile_details.dart';
import 'package:spice_marriage/Widgets/screen_appbar.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPaths.DETAILS_BACKGROUND_IMAGE),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.008,
            ),
            const ScreenAppBar(
              txt: AppStrings.DETAILS_TEXT,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              child: ProfileContainer(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.11,
                    ),
                    const Text(
                      AppStrings.USER_NAME_TEXT,
                      style:
                          TextStyle(color: AppColors.BLACK_COLOR, fontSize: 40),
                    ),
                    const Text(
                      AppStrings.USER_EMAIL_TEXT,
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const ProfileDetails(
                      firsttxt: AppStrings.NAME_TEXT,
                      lasttxt: AppStrings.USER_NAME_TEXT,
                    ),
                    const ProfileDetails(
                      firsttxt: AppStrings.EMAIL_TEXT,
                      lasttxt: AppStrings.USER_EMAIL_TEXT,
                    ),
                    const ProfileDetails(
                      firsttxt: AppStrings.PASSWORD_TEXT,
                      lasttxt: AppStrings.ASTERISK_TEXT,
                    ),
                    const AppButton(
                      txt: AppStrings.SAVE_BUTTON_TEXT,
                      color: AppColors.BLACK_COLOR,
                      txtcolor: Colors.white,
                      iconcolor: Colors.black,
                      prefixicon: false,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              child: const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 65,
                  backgroundImage: AssetImage(
                    AssetPaths.PROFILE_IMAGE,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
