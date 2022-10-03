import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';

class ProfileContainer extends StatefulWidget {
  final Widget child;
  const ProfileContainer({ Key? key, required this.child }) : super(key: key);

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.WHITE_COLOR
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}