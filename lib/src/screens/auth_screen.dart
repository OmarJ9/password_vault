import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_cubit.dart';
import '../constants/colors.dart';
import '../widgets/flat_button.dart';
import '../widgets/mysnackbar.dart';
import 'package:sizer/sizer.dart';
import '../bloc/connectivity/connectivity_cubit.dart';
import '../constants/strings.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _numbercontroller;
  CountryCode _countrycode = CountryCode(
    code: 'MA',
    dialCode: '+212',
  );
  var numberwithcode = '';

  @override
  void initState() {
    _numbercontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _numbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle mysubline = Theme.of(context).textTheme.subtitle1!.copyWith(
        wordSpacing: 1,
        letterSpacing: 1.3,
        height: 1.5,
        fontSize: 10.sp,
        fontWeight: FontWeight.w300);

    AuthCubit cubit = BlocProvider.of(context);
    ConnectivityCubit connectivitycubit = BlocProvider.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PhoneNumberSubmittedState) {
          Navigator.pushNamed(context, verificationscreen,
              arguments: numberwithcode);
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
                    'Enter Your \nPhone Number',
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
                  Text('Your phone number won\'t be \nbe shown publicly.',
                      style: mysubline),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Phone Number', style: mysubline),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextFormField(
                    controller: _numbercontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      hintStyle: TextStyle(
                        fontSize: 10.sp,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: CountryCodePicker(
                        initialSelection: 'MA',
                        dialogBackgroundColor:
                            Theme.of(context).backgroundColor,
                        dialogTextStyle: Theme.of(context).textTheme.subtitle1,
                        onChanged: (code) {
                          _countrycode = code;
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.length <= 8) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: MyColors.green),
                              );
                            } else {
                              return MyFlatButton(
                                  func: () {
                                    validate(cubit, connectivitycubit);
                                  },
                                  title: 'Send Code',
                                  color: MyColors.green);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: 'By continuing, you agree on our, ',
                          style: mysubline.copyWith(fontSize: 13.sp),
                          children: [
                            TextSpan(
                                text: 'Terms of service, ',
                                style: TextStyle(
                                    color: MyColors.green,
                                    decoration: TextDecoration.underline,
                                    fontSize: 13.sp),
                                children: [
                                  TextSpan(
                                      text: 'and confirming that you read, ',
                                      style: mysubline.copyWith(
                                          decoration: TextDecoration.none,
                                          fontSize: 13.sp),
                                      children: [
                                        TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                                color: MyColors.green,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 13.sp)),
                                      ])
                                ])
                          ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validate(AuthCubit cubit, ConnectivityCubit connectivityCubit) {
    numberwithcode = '${_countrycode.dialCode}${_numbercontroller.text}';
    if (_formKey.currentState!.validate()) {
      if (connectivityCubit.state is ConnectivityOnlineState) {
        cubit.verify(phonenumber: numberwithcode);
      } else {
        MySnackBar.error(
            message: 'Please Check your Connection', context: context);
      }
    }
  }
}
