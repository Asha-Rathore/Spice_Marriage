import 'package:fluttertoast/fluttertoast.dart';
import 'package:spice_marriage/Utils/app_colors.dart';


class Toast_Message{
  Toast_Message(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: AppColors.BLACK_COLOR,
      textColor: AppColors.WHITE_COLOR,
    );
  }
}