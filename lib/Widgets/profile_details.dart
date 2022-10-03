import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';
import '../Utils/assets_paths.dart';

class ProfileDetails extends StatefulWidget {
  final String firsttxt;
  final String lasttxt;
  const ProfileDetails({Key? key, required this.firsttxt, required this.lasttxt}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.firsttxt,
                style: const TextStyle(
                  color: AppColors.BLACK_COLOR,
                  fontSize: 35,
                ),
              ),
              Text(
                widget.lasttxt,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Image.asset(
            AssetPaths.EDIT_ICON,
            height: 20,
            width: 20,
          )
        ],
      ),
    );
  }
}
