import 'package:flutter/material.dart';
import '../Utils/assets_paths.dart';

class AppLogo extends StatefulWidget {
  const AppLogo({ Key? key }) : super(key: key);

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70,
      child: Image.asset(AssetPaths.LOGO_IMAGE),
    );
  }
}