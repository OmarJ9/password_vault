import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../bloc/home/home_cubit.dart';
import '../constants/colors.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of(context);
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            decoration: BoxDecoration(
              //color: MyColors.gray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GNav(
              activeColor: MyColors.green,
              textStyle: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: 9.sp),
              padding: EdgeInsets.zero,
              iconSize: 22.sp,
              gap: 5,
              tabBorderRadius: 5,
              tabActiveBorder: Border.all(color: MyColors.yellow, width: 0.2),
              onTabChange: (index) {
                setState(() {
                  homeCubit.navcurruntindex = index;
                });
              },
              tabs: [
                GButton(
                  icon: LineIcons.key,
                  text: 'Pass',
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 6.sp),
                  iconColor: Colors.grey,
                ),
                GButton(
                  icon: LineIcons.lock,
                  text: 'Generator',
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 6.sp),
                  iconColor: Colors.grey,
                ),
                GButton(
                  icon: LineIcons.plusSquare,
                  text: 'Add Pass',
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 6.sp),
                  iconColor: Colors.grey,
                ),
                GButton(
                  icon: LineIcons.cog,
                  text: 'Settings',
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 6.sp),
                  iconColor: Colors.grey,
                ),
              ],
            ),
          ),
          body: homeCubit.screens[homeCubit.navcurruntindex]),
    );
  }
}
