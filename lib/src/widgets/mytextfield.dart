import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final FormFieldValidator<String> validator;
  final void Function(String) onchange;
  final TextInputType keyboardtype;
  const MyTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.validator,
    required this.onchange,
    required this.keyboardtype,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 2, 53, 21),
              Color.fromARGB(255, 194, 157, 8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(3)),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardtype,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 10.sp,
                color: Colors.grey,
              ),
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          errorMaxLines: 4,
        ),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onchange,
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }
}
