import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  final String spiceImg;
  final String txt;
  final String switchImg;
  final double? imgWidth;
  const SwitchWidget(
      {Key? key,
      required this.spiceImg,
      required this.txt,
      required this.switchImg,
      this.imgWidth})
      : super(key: key);

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
        children: [
          Container(
            alignment: Alignment.topRight,
            width: 60,
            child: Image.asset(
              widget.spiceImg,
              width: widget.imgWidth,
            ),
          ),
          Text(
            widget.txt,
            style: const TextStyle(fontSize: 25),
          ),
          const Spacer(),
          Image.asset(
            widget.switchImg,
            height: 40,
            width: 40,
          )
        ],
      ),
    );
  }
}
