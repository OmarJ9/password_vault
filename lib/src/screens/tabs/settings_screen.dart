import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/home/home_cubit.dart';
import '../../constants/assets_path.dart';
import '../../constants/consts_variables.dart';
import '../../widgets/mysnackbar.dart';
import '../../widgets/mytextfield.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../widgets/flat_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _bottomsheetformkey = GlobalKey<FormState>();
  late TextEditingController _oldpasswordcontroller;
  late TextEditingController _newpasswordcontroller;
  late TextEditingController _newpincontroller;
  late TextEditingController _oldpincontroller;

  @override
  void initState() {
    super.initState();
    _oldpasswordcontroller = TextEditingController();
    _newpasswordcontroller = TextEditingController();
    _oldpincontroller = TextEditingController();
    _newpincontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _oldpasswordcontroller.dispose();
    _newpasswordcontroller.dispose();
    _oldpincontroller.dispose();
    _newpincontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    AuthCubit authcubit = BlocProvider.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is UnAuthState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, authscreen, (route) => false);
            }
          },
        ),
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                _buildcard(context),
                SizedBox(
                  height: 6.h,
                ),
                _buildrowSetting(
                  context,
                  title: 'Change Password',
                  icon: LineIcons.lock,
                  color: Colors.green,
                  func: () async {
                    await _showBottomSheet(
                      context: context,
                      error: 'Password is Short',
                      firstcontroller: _oldpasswordcontroller,
                      secondcontroller: _newpasswordcontroller,
                      hintone: 'Enter Old Password',
                      hinttwo: 'Enter New Password',
                      func: () {
                        verifyBottomsheetPassword(cubit);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                _buildrowSetting(
                  context,
                  title: 'Change Pin',
                  icon: LineIcons.key,
                  color: Colors.green,
                  func: () async {
                    await _showBottomSheet(
                      context: context,
                      error: 'Pin is Short',
                      firstcontroller: _oldpincontroller,
                      secondcontroller: _newpincontroller,
                      hintone: 'Enter Old Pin',
                      hinttwo: 'Enter New Pin',
                      func: () {
                        verifyBottomsheetPin(cubit);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                _builddarkswitchTile(context, cubit),
                SizedBox(
                  height: 2.h,
                ),
                _buildrowSetting(
                  context,
                  title: 'Log Out',
                  icon: LineIcons.alternateSignOut,
                  color: Colors.red,
                  func: () {
                    cubit.removeSecureStorageData();
                    cubit.navcurruntindex = 0;
                    authcubit.logOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _builddarkswitchTile(BuildContext context, HomeCubit cubit) {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 2, 53, 21),
            Color.fromARGB(255, 194, 157, 8),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor),
        child: Row(
          children: [
            LineIcon.adjust(
              color: Colors.green,
            ),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: SwitchListTile(
                value: cubit.isDark,
                onChanged: (value) {
                  setState(() {
                    cubit.changeAppMode(value);
                  });
                },
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        wordSpacing: 1,
                        letterSpacing: 1.3,
                        height: 1.5,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildrowSetting(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required Function() func}) {
    return InkWell(
      onTap: func,
      child: Container(
        padding: const EdgeInsets.all(2),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 2, 53, 21),
              Color.fromARGB(255, 194, 157, 8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).backgroundColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: color,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      wordSpacing: 1,
                      letterSpacing: 1.3,
                      height: 1.5,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              const Spacer(),
              LineIcon.arrowRight()
            ],
          ),
        ),
      ),
    );
  }

  _buildcard(BuildContext context) {
    return Bounce(
      infinite: true,
      duration: const Duration(milliseconds: 2000),
      delay: const Duration(seconds: 2),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green,
        ),
        child: Row(children: [
          Image.asset(
            MyAssets.profileicon,
            height: 8.h,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome User number ',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        wordSpacing: 1,
                        letterSpacing: 1.3,
                        height: 1.5,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                ),
                SizedBox(
                  height: 0.3.h,
                ),
                Text(
                  user!.phoneNumber!,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        wordSpacing: 1,
                        color: Colors.black,
                        letterSpacing: 1.3,
                        height: 1.5,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future<dynamic> _showBottomSheet(
      {required BuildContext context,
      required TextEditingController firstcontroller,
      required TextEditingController secondcontroller,
      required String hintone,
      required String hinttwo,
      required String error,
      required Function() func}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green),
            color: Colors.black,
          ),
          child: Form(
            key: _bottomsheetformkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  keyboardtype: TextInputType.visiblePassword,
                  controller: firstcontroller,
                  hint: hintone,
                  icon: Icons.lock,
                  validator: (value) {
                    if (value!.length < 4) {
                      return error;
                    }
                    return null;
                  },
                  onchange: (value) {},
                ),
                SizedBox(
                  height: 2.h,
                ),
                MyTextField(
                  keyboardtype: TextInputType.visiblePassword,
                  controller: secondcontroller,
                  hint: hinttwo,
                  icon: Icons.lock,
                  validator: (value) {
                    if (value!.length < 4) {
                      return error;
                    }
                    return null;
                  },
                  onchange: (value) {},
                ),
                SizedBox(
                  height: 4.h,
                ),
                MyFlatButton(
                  func: func,
                  title: 'Verify',
                  color: MyColors.green,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void verifyBottomsheetPassword(HomeCubit cubit) {
    if (_bottomsheetformkey.currentState!.validate()) {
      if (_oldpasswordcontroller.text == backuppass) {
        cubit
            .addSecureStorage('mybackuppass', _newpasswordcontroller.text)
            .then((value) {
          MySnackBar.success(
              message: 'Password Changed Successfully', context: context);
        });
        Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      } else {
        MySnackBar.error(message: 'Wrong Old Password', context: context);
      }
    }
  }

  void verifyBottomsheetPin(HomeCubit cubit) {
    if (_bottomsheetformkey.currentState!.validate()) {
      if (_oldpincontroller.text == pin) {
        cubit.addSecureStorage('mypin', _newpincontroller.text).then((value) {
          MySnackBar.success(
              message: 'Pin Changed Successfully', context: context);
        });
        Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      } else {
        MySnackBar.error(message: 'Wrong Old Pin', context: context);
      }
    }
  }
}
