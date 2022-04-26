import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';
import '../../constants/colors.dart';
import '../../constants/consts_variables.dart';
import '../../widgets/flat_button.dart';
import '../../widgets/mysnackbar.dart';
import 'package:sizer/sizer.dart';

class PassGenScreen extends StatefulWidget {
  final bool fromaddpass;
  const PassGenScreen(this.fromaddpass, {Key? key}) : super(key: key);

  @override
  State<PassGenScreen> createState() => _PassGenScreenState();
}

class _PassGenScreenState extends State<PassGenScreen> {
  int passlenght = 6;
  List<bool> checklist = [true, false, true];
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              (widget.fromaddpass) ? _buildcustomappbar(context) : Container(),
              Text(
                ' Password Lenght',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 10.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              DropdownButtonFormField(
                value: passlenght,
                items: passlenghtitems,
                onChanged: (int? value) {
                  setState(() {
                    passlenght = value!;
                  });
                },
                focusColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  fillColor: Theme.of(context).backgroundColor,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                ' Symbols',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 10.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              _buildcontainer(text: '!@#\$%^&*()_+}|?><:', index: 0),
              SizedBox(
                height: 2.h,
              ),
              Text(
                ' Numbers',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 10.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              _buildcontainer(text: '2452563678475', index: 1),
              SizedBox(
                height: 2.h,
              ),
              Text(
                ' UpperCase',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 10.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              _buildcontainer(text: 'ABCDEFGHIJKLMN', index: 2),
              SizedBox(
                height: 3.h,
              ),
              Text(
                '  Generated Password',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 10.sp),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                padding: const EdgeInsets.all(2),
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
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).backgroundColor),
                    child: Row(
                      children: [
                        Text(
                          password,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: password))
                                  .then((value) {
                                MySnackBar.note(
                                    message: 'Data Copied to Clpboard',
                                    context: context);
                              });
                            },
                            child: LineIcon.copy()),
                      ],
                    )),
              ),
              SizedBox(
                height: 3.h,
              ),
              Center(
                child: MyFlatButton(
                    func: () {
                      setState(() {
                        password = generatePassword();
                      });
                    },
                    title: 'Generate Password',
                    color: MyColors.green),
              ),
              SizedBox(
                height: 3.h,
              ),
              (widget.fromaddpass)
                  ? Center(
                      child: MyFlatButton(
                          func: () {
                            Navigator.pop(context, password);
                          },
                          title: 'Add Password',
                          color: MyColors.green),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _buildcustomappbar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context, password);
            },
            child: LineIcon.angleLeft(
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text('Pass Generator', style: Theme.of(context).textTheme.subtitle1),
        ],
      ),
    );
  }

  bool isDarkMode(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  _buildcontainer({required String text, required int index}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
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
              width: 63.w,
              padding: EdgeInsets.symmetric(vertical: 1.4.h, horizontal: 6.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).backgroundColor),
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              )),
        ),
        const Spacer(),
        _buildcheckbox(index)
      ],
    );
  }

  _buildcheckbox(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          checklist[index] = !checklist[index];
        });
      },
      child: Container(
        height: 6.5.h,
        width: 6.5.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.yellow),
          color: (checklist[index])
              ? Colors.green
              : Theme.of(context).backgroundColor,
        ),
        child: LineIcon.check(
          color: Colors.white,
        ),
      ),
    );
  }

  generatePassword() {
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    const special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (checklist[2]) chars += '$letterLowerCase$letterUpperCase';
    if (checklist[1]) chars += number;
    if (checklist[0]) chars += special;

    return List.generate(passlenght, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
