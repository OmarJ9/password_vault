import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_vault/src/bloc/connectivity/connectivity_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../models/pass_model.dart';
import '../../services/firestore_service.dart';
import '../../widgets/flat_button.dart';
import '../../widgets/mysnackbar.dart';
import '../../widgets/mytextfield.dart';
import 'package:sizer/sizer.dart';

import '../../constants/consts_variables.dart';

class AddPassScreen extends StatefulWidget {
  const AddPassScreen({Key? key}) : super(key: key);

  @override
  State<AddPassScreen> createState() => _AddPassScreenState();
}

class _AddPassScreenState extends State<AddPassScreen> {
  String _selectedcategory = 'Social';

  int _selectedcategoryindex = 0;
  String _selectedsubcategory = selectedcategoryvalues[0];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConnectivityCubit connectivityCubit = BlocProvider.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  '  Category',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 10.sp),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                _buildDropDownMenu(
                    context, categories, _selectedcategory, true),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  '  Websites',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 10.sp),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                _buildDropDownMenu(
                    context,
                    subcategories[_selectedcategoryindex],
                    _selectedsubcategory,
                    false),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  '  Passwords',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 10.sp),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                MyTextField(
                  keyboardtype: TextInputType.text,
                  controller: _controller,
                  hint: "Enter your Password here.",
                  icon: Icons.password,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password too short';
                    }
                    return null;
                  },
                  onchange: (query) {},
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyFlatButton(
                        func: () {
                          addPass(connectivityCubit);
                        },
                        title: 'Add Pass',
                        color: MyColors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, passgenscreen,
                              arguments: true)
                          .then((value) {
                        _controller.text = value as String;
                      });
                    },
                    child: Center(
                      child: Text(
                        'Generate Password',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: MyColors.green, wordSpacing: 1),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addPass(ConnectivityCubit connectivityCubit) {
    FirestoreSerivice firestoreSerivice = FirestoreSerivice();
    if (_formkey.currentState!.validate()) {
      if (connectivityCubit.state is ConnectivityOnlineState) {
        PassModel passModel = PassModel(
            id: '',
            icon: _selectedsubcategory,
            website: _selectedsubcategory,
            password: _controller.text,
            category: _selectedcategory);

        firestoreSerivice.addPass(passModel).then((value) {
          MySnackBar.success(
              message: 'Password Added Successfully', context: context);
          Future.delayed(const Duration(seconds: 2)).then((value) {
            _controller.clear();
          });
        }).onError((error, stackTrace) {
          MySnackBar.error(message: error.toString(), context: context);
        });
      } else {
        MySnackBar.error(
            message: 'Please Check Your Connection!!', context: context);
      }
    }
  }

  DropdownButtonFormField<String> _buildDropDownMenu(
      BuildContext context,
      List<DropdownMenuItem<String>> items,
      String selectedcategory,
      bool iscategory) {
    return DropdownButtonFormField(
      items: items,
      onChanged: (String? value) {
        setState(() {
          // selectedcategory = value!;

          if (iscategory) {
            _selectedcategory = value!;

            _selectedcategoryindex = categorytoindex(_selectedcategory);
            _selectedsubcategory =
                selectedcategoryvalues[_selectedcategoryindex];
          } else {
            _selectedsubcategory = value!;
          }
        });
      },
      value: selectedcategory,
      focusColor: Colors.green,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
      ),
    );
  }

  int categorytoindex(String cateegory) {
    switch (cateegory) {
      case 'Social':
        {
          return 0;
        }
      case 'Finance':
        {
          return 1;
        }
      case 'Others':
        {
          return 2;
        }

      default:
        {
          return 0;
        }
    }
  }
}
