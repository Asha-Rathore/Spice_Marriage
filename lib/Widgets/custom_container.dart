import 'package:flutter/material.dart';
import 'package:spice_marriage/Utils/app_colors.dart';

class CustomContainer extends StatefulWidget {
  final Widget child;
  final String containerHeading;
  const CustomContainer(
      {Key? key, required this.child, required this.containerHeading})
      : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.WHITE_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: const BoxDecoration(
                color: AppColors.BLACK_COLOR,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  widget.containerHeading,
                  style: const TextStyle(
                    color: AppColors.WHITE_COLOR,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}
