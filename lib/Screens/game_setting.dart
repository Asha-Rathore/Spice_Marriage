import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import 'package:spice_marriage/Utils/app_strings.dart';
import 'package:spice_marriage/Utils/constants.dart';
import 'package:spice_marriage/Widgets/app_button.dart';
import 'package:spice_marriage/Widgets/app_template.dart';
import 'package:spice_marriage/Widgets/custom_container.dart';
import 'package:spice_marriage/Widgets/screen_appbar.dart';
import 'package:spice_marriage/Widgets/switch_widget.dart';
import '../Utils/assets_paths.dart';

class GameSetting extends StatefulWidget {
  const GameSetting({Key? key}) : super(key: key);

  @override
  State<GameSetting> createState() => _GameSettingState();
}

class _GameSettingState extends State<GameSetting> {
  //final List<String> values = [AppStrings.WIFE_TEXT, AppStrings.HUSBAND_TEXT, AppStrings.BOTH_TEXT];
  String dropdownValue = AppStrings.WIFE_TEXT;
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const ScreenAppBar(
                txt: AppStrings.GAME_SETTING_TEXT,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const CustomContainer(
                containerHeading: AppStrings.YOUR_ACTIVITY_TEXT,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                      AppStrings.LOREM_TEXT,
                      style: TextStyle(
                        color: AppColors.BLACK_COLOR,
                        fontFamily: Constants.NUNITO_FONT_FAMILY,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              CustomContainer(
                containerHeading: AppStrings.SPICE_LEVEL_TEXT,
                child: Column(
                  children: [
                    const SwitchWidget(
                      spiceImg: AssetPaths.SPICE1_IMAGE,
                      txt: AppStrings.MILD_TEXT,
                      switchImg: AssetPaths.SWITCH_IMAGE,
                      imgWidth: 30,
                    ),
                    const SwitchWidget(
                      spiceImg: AssetPaths.SPICE2_IMAGE,
                      txt: AppStrings.MEDIUM_TEXT,
                      switchImg: AssetPaths.SWITCH_OFF_IMAGE,
                      imgWidth: 40,
                    ),
                    const SwitchWidget(
                      spiceImg: AssetPaths.SPICE3_IMAGE,
                      txt: AppStrings.HOT_TEXT,
                      switchImg: AssetPaths.SWITCH_OFF_IMAGE,
                      imgWidth: 50,
                    ),
                    const SwitchWidget(
                      spiceImg: AssetPaths.SPICE4_IMAGE,
                      txt: AppStrings.EXTRA_TEXT,
                      switchImg: AssetPaths.SWITCH_OFF_IMAGE,
                      imgWidth: 60,
                    ),
                    const Text(
                      AppStrings.WHO_PERFORMS_THIS_ACTIVITY_TEXT,
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.14,
                          right: MediaQuery.of(context).size.width * 0.14,
                          bottom: 8),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.BLACK_COLOR),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValue,
                              icon: const Icon(Icons.keyboard_arrow_down,),
                              elevation: 16,
                              style: const TextStyle(
                                fontSize: 25,
                                color: AppColors.BLACK_COLOR,
                                fontFamily: Constants.APP_FONT_FAMILY,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                AppStrings.WIFE_TEXT,
                                AppStrings.HUSBAND_TEXT,
                                AppStrings.BOTH_TEXT,
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.14,
                  right: MediaQuery.of(context).size.width * 0.14,
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                child: Image.asset(AssetPaths.CLOCK_IMAGE),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    AppStrings.MINUTS_TEXT,
                    style: TextStyle(
                      color: AppColors.WHITE_COLOR,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    AppStrings.SECONDS_TEXT,
                    style: TextStyle(
                      color: AppColors.WHITE_COLOR,
                      fontSize: 40,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const AppButton(
                txt: AppStrings.CONTINUE_BUTTON_TEXT,
                color: AppColors.RED_COLOR,
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
    );
  }
}
