import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constants/colors.dart';

class MyPinCodeTextField extends StatelessWidget {
  final int lenght;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  const MyPinCodeTextField(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.lenght})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: lenght,
      appContext: context,
      controller: controller,
      onChanged: (code) {},
      autoFocus: false,
      validator: validator,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      obscureText: true,
      animationType: AnimationType.scale,
      pinTheme: PinTheme.defaults(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: Colors.black,
        inactiveColor: Colors.blue,
        inactiveFillColor: Colors.white,
        activeFillColor: MyColors.deepgray,
        selectedColor: Colors.blue,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (submitedCode) {},
    );
  }
}
