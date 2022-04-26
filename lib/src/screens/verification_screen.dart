import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_vault/src/constants/consts_variables.dart';
import 'package:pass_vault/src/widgets/mypincodetextfield.dart';
import '../bloc/auth/auth_cubit.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/flat_button.dart';
import '../widgets/mysnackbar.dart';
import 'package:sizer/sizer.dart';

import '../bloc/connectivity/connectivity_cubit.dart';

class VerificationScreen extends StatefulWidget {
  final String mynumber;
  const VerificationScreen({Key? key, required this.mynumber})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // When you dispose it an error happen !!
    // _controller.dispose();
    pin = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = BlocProvider.of(context);
    ConnectivityCubit connectivitycubit = BlocProvider.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushReplacementNamed(context, pinscreen);
        }
        if (state is AuthErrorState) {
          MySnackBar.error(message: state.error, context: context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Enter Your \nVerification Code',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        wordSpacing: 1,
                        letterSpacing: 1.3,
                        height: 1.5,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text.rich(
                    TextSpan(
                        text:
                            'A text message with 6 digits code \nwas sent to ',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              wordSpacing: 1,
                              letterSpacing: 1.3,
                              height: 1.5,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                            ),
                        children: [
                          TextSpan(
                              text: widget.mynumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: MyColors.green,
                                    fontWeight: FontWeight.w700,
                                  ))
                        ]),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyPinCodeTextField(
                      controller: _controller,
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Please enter a 6 digits number';
                        }
                        return null;
                      },
                      lenght: 6),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: MyFlatButton(
                      func: () {
                        validate(context, cubit, connectivitycubit);
                      },
                      title: 'Verify',
                      color: MyColors.green,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validate(BuildContext context, AuthCubit cubit,
      ConnectivityCubit connectivityCubit) {
    if (_formKey.currentState!.validate()) {
      if (connectivityCubit.state is ConnectivityOnlineState) {
        cubit.submitOTP(smsCode: _controller.text);
      } else {
        MySnackBar.error(
            message: 'Please Check your Connection', context: context);
      }
    }
  }
}
