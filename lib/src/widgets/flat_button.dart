import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:sizer/sizer.dart';

class MyFlatButton extends StatelessWidget {
  final Function()? func;
  final String title;
  final Color color;
  const MyFlatButton(
      {Key? key, required this.func, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(70.w, 7.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        primary: color,
      ),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: MyColors.white),
      ),
    );
  }
}
