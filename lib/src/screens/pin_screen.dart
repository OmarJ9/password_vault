import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pass_vault/src/widgets/mypincodetextfield.dart';
import '../bloc/home/home_cubit.dart';
import '../constants/colors.dart';
import '../constants/consts_variables.dart';
import '../constants/strings.dart';
import '../widgets/flat_button.dart';
import '../widgets/mysnackbar.dart';
import '../widgets/mytextfield.dart';
import 'package:sizer/sizer.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  late final TextEditingController myfirstcontroller;
  late final TextEditingController _secondpincontroller;
  late final TextEditingController _backuppasscontroller;
  late final TextEditingController _dialogcontroller;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dialogformkey = GlobalKey<FormState>();

  @override
  void initState() {
    myfirstcontroller = TextEditingController();
    _secondpincontroller = TextEditingController();
    _backuppasscontroller = TextEditingController();
    _dialogcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // myfirstcontroller.dispose();
    // _secondpincontroller.dispose();
    // _backuppasscontroller.dispose();
    // _dialogcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of<HomeCubit>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: (pin != null) ? 10.h : 6.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    (pin != null)
                        ? 'Enter Your 4 \nDigits Passkey'
                        : 'Create Your 4 \nDigits Passkey',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        wordSpacing: 1,
                        letterSpacing: 1.3,
                        height: 1.7,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: (pin != null) ? 15.h : 5.h,
                ),
                Text(
                  'Enter Key',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        wordSpacing: 1,
                        letterSpacing: 1.3,
                        height: 1.5,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: 60.w,
                  child: MyPinCodeTextField(
                    controller: myfirstcontroller,
                    lenght: 4,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                (pin != null)
                    ? Container()
                    : Text(
                        'Verify Key',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              wordSpacing: 1,
                              letterSpacing: 1.3,
                              height: 1.5,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                SizedBox(
                  height: 2.h,
                ),
                (pin != null)
                    ? Container()
                    : SizedBox(
                        width: 60.w,
                        child: MyPinCodeTextField(
                          controller: _secondpincontroller,
                          lenght: 4,
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                (pin != null)
                    ? Container()
                    : SizedBox(
                        height: 3.h,
                      ),
                (pin != null)
                    ? InkWell(
                        onTap: () {
                          _builddialog(context, _dialogcontroller);
                        },
                        child: Center(
                          child: Text(
                            'Forget Password',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: MyColors.green),
                          ),
                        ))
                    : Container(),
                (pin != null)
                    ? SizedBox(
                        height: 2.h,
                      )
                    : Container(),
                (pin != null)
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: Text(
                          'Please Enter Your Backup Pass ,you will need it if you forget your Pin.',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    wordSpacing: 1,
                                    letterSpacing: 1.3,
                                    height: 1.5,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                      ),
                (pin == null)
                    ? MyTextField(
                        keyboardtype: TextInputType.visiblePassword,
                        controller: _backuppasscontroller,
                        hint: 'Please Enter a Backup Pass',
                        icon: Icons.email,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password is short';
                          }
                          return null;
                        },
                        onchange: (value) {})
                    : Container(),
                (pin != null)
                    ? Container()
                    : SizedBox(
                        height: 4.h,
                      ),
                Center(
                  child: MyFlatButton(
                    func: () {
                      verifypins(cubit);
                    },
                    title: 'Verify PIN',
                    color: MyColors.green,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _builddialog(
      BuildContext context, TextEditingController controller) {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: _dialogformkey,
            child: SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              children: [
                Text(
                  'Please Enter Your Backup Password.',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        wordSpacing: 1,
                        letterSpacing: 1.3,
                        height: 1.5,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                MyTextField(
                    keyboardtype: TextInputType.visiblePassword,
                    controller: controller,
                    hint: 'Enter your password',
                    icon: Icons.email,
                    validator: (value) {
                      if (value!.length < 4) {
                        return 'Password is short';
                      }
                      return null;
                    },
                    onchange: (value) {}),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: MyFlatButton(
                    func: () {
                      verifydialog();
                    },
                    title: 'Verify',
                    color: MyColors.green,
                  ),
                )
              ],
            ),
          );
        });
  }

  verifydialog() async {
    if (_dialogformkey.currentState!.validate()) {
      if (_dialogcontroller.text == backuppass) {
        const storage = FlutterSecureStorage();
        pin = null;
        backuppass = null;
        await storage.delete(key: 'mypin');
        await storage.delete(key: 'mybackuppass').then((value) {
          Navigator.pushNamed(context, pinscreen);
        });
      } else {
        MySnackBar.error(message: 'Wrong BuckUp Password!', context: context);
      }
    }
  }

  verifypins(HomeCubit cubit) {
    if (pin == null) {
      if (_formkey.currentState!.validate()) {
        if (myfirstcontroller.text == _secondpincontroller.text &&
            myfirstcontroller.text.isNotEmpty &&
            _secondpincontroller.text.isNotEmpty) {
          cubit.addSecureStorage('mypin', _secondpincontroller.text);
          cubit.addSecureStorage('mybackuppass', _backuppasscontroller.text);
          Navigator.pushNamed(context, homescreen);
        } else {
          MySnackBar.error(
              message: 'Passwords are not the same', context: context);
        }
      }
    } else {
      if (pin == myfirstcontroller.text) {
        Navigator.pushNamed(context, homescreen);
      } else {
        MySnackBar.error(message: 'Wrong Password', context: context);
      }
    }
  }
}
