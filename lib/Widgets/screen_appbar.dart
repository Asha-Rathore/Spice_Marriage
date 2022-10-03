import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import 'package:spice_marriage/Utils/app_navigation.dart';
import '../Utils/assets_paths.dart';

class ScreenAppBar extends StatefulWidget {
  final String? img;
  final String txt;
  final bool? leadingicon;
  const ScreenAppBar({
    Key? key,
    required this.txt,
    this.leadingicon = true,
    this.img
  }) : super(key: key);

  @override
  State<ScreenAppBar> createState() => _ScreenAppBarState();
}

class _ScreenAppBarState extends State<ScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Visibility(
        visible: widget.leadingicon!,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: InkWell(
            onTap: () {
              AppNavigation.navigatorPop(context);
              //Navigator.pop(context);
            }, 
            child: Image.asset(
              AssetPaths.ARROW_BACK_ICON,
              color: AppColors.WHITE_COLOR,
            ) != null
            ? Image.asset(
              AssetPaths.ARROW_BACK_ICON,
              color: AppColors.WHITE_COLOR,
            )
            : const SizedBox(),
          ),
        )
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: Text(
        widget.txt,
        style: const TextStyle(
            fontSize: 45,
           // decoration: TextDecoration.underline,
            decorationThickness: 0.6,
            color: AppColors.WHITE_COLOR),
      ),
      centerTitle: true,
    );
  }
}
