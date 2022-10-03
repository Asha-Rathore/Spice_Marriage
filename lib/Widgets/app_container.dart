import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';

class AppContainer extends StatefulWidget {
  final Color conColor;
  final String txt;
  final Function()? onclick;
  const AppContainer({
    Key? key,
    required this.conColor,
    required this.txt,
    this.onclick,
  }) : super(key: key);

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onclick,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.40,
        width: MediaQuery.of(context).size.width * 0.42,
        decoration: BoxDecoration(
          color: widget.conColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            widget.txt,
            style: const TextStyle(
              color: AppColors.WHITE_COLOR,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
