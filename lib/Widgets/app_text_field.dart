import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spice_marriage/Utils/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String hinttxt;
  final TextEditingController? txtController;
  final bool? obscuretxt;
  final String? Function(String?)? validator;
  const AppTextField({
    Key? key,
    required this.hinttxt,
    this.txtController,
    this.obscuretxt = false,
    this.validator,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: MediaQuery.of(context).size.width * 0.85.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.WHITE_COLOR.withOpacity(0.5),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 5.h),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            obscureText: widget.obscuretxt!,
            controller: widget.txtController,
            style: TextStyle(
              color: AppColors.BLACK_COLOR,
              fontSize: 25.sp,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.w),
              border: InputBorder.none,
              hintText: widget.hinttxt,
              hintStyle: TextStyle(
                color: AppColors.BLACK_COLOR,
                fontSize: 25.sp,
              ),
            ),
            validator: widget.validator
          ),
        ),
      ),
    );
  }
}
