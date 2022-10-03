import 'package:flutter/material.dart'; 

class AppButton extends StatefulWidget {
  final String? txt;
  final Color? color;
  final Color? txtcolor;
  final bool? prefixicon;
  final Color? iconcolor;
  final String? img;
  final Function()? onclick;
  const AppButton({
    Key? key,
    this.onclick,
    this.prefixicon = true,
    this.iconcolor,
    this.img,
    this.txt,
    this.color,
    this.txtcolor,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.color!),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.prefixicon!,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 55,
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: widget.img != null
                        ? Image.asset(
                            widget.img!,
                            fit: BoxFit.contain,
                            color: widget.iconcolor,
                          )
                        : SizedBox(),
                  ),
                ),
              ),
            ),
            Text(
              widget.txt!,
              style: TextStyle(
                color: widget.txtcolor,
                fontSize: 30,
              ),
            ),
          ],
        ),
        onPressed: widget.onclick,
      ),
    );
  }
}
