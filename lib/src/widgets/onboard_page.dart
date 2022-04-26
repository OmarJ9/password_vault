import 'package:flutter/material.dart';
import '../constants/consts_variables.dart';
import 'package:sizer/sizer.dart';

class OnBoardPage extends StatelessWidget {
  final int index;

  const OnBoardPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          onboardlist[index].image,
          fit: BoxFit.cover,
          height: 20.h,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          onboardlist[index].title,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: 3.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            onboardlist[index].description,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
