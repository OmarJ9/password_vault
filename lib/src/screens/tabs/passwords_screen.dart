import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home/home_cubit.dart';
import '../../models/pass_model.dart';
import '../../services/firestore_service.dart';
import '../../widgets/mytextfield.dart';
import '../../widgets/pass_container.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late TextEditingController _controller;
  late Stream<List<PassModel>> mystream;

  final List<String> _categories = ['All', 'Social', 'Finance', 'Others'];

  @override
  void initState() {
    _controller = TextEditingController();
    mystream = FirestoreSerivice().getPasswords();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyTextField(
              keyboardtype: TextInputType.text,
              controller: _controller,
              hint: 'Search Websites',
              icon: Icons.search,
              validator: (value) {
                return null;
              },
              onchange: (query) {
                setState(() {
                  if (query.isNotEmpty) {
                    mystream = FirestoreSerivice().searchByName(query);
                  } else {
                    homeCubit.currentindex = 0;
                    mystream = FirestoreSerivice().getPasswords();
                  }
                });
              },
            ),
            SizedBox(
              height: 3.h,
            ),
            SizedBox(
              height: 5.h,
              child: ListView.builder(
                itemCount: _categories.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    return BounceInUp(
                        duration: const Duration(milliseconds: 500),
                        child: _buildcategory(
                            _categories[index], index, homeCubit));
                  } else {
                    return BounceInDown(
                        duration: const Duration(milliseconds: 500),
                        child: _buildcategory(
                            _categories[index], index, homeCubit));
                  }
                },
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            Expanded(
                child: StreamBuilder(
              stream: mystream,
              builder: (context, AsyncSnapshot<List<PassModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'No Data',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return snapshot.data!.isEmpty
                    ? const Center(
                        child: Text('No Data '),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          PassModel passModel = snapshot.data![index];
                          Widget mywidget = PassContainer(
                            id: passModel.id,
                            icon: passModel.icon,
                            website: passModel.website,
                            category: passModel.category,
                            password: passModel.password,
                          );
                          if (index % 2 == 0) {
                            return BounceInLeft(
                                duration: const Duration(milliseconds: 1000),
                                child: mywidget);
                          } else {
                            return BounceInRight(
                                duration: const Duration(milliseconds: 1000),
                                child: mywidget);
                          }
                        },
                      );
              },
            ))
          ],
        ),
      ),
    );
  }

  Container _buildcategory(String name, int index, HomeCubit cubit) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 2, 53, 21),
              Color.fromARGB(255, 194, 157, 8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 0.3.w, vertical: 0.3.w),
      margin: EdgeInsets.symmetric(horizontal: 1.5.w),
      child: GestureDetector(
        onTap: () {
          setState(() {
            cubit.currentindex = index;
            if (_categories[cubit.currentindex] == 'All') {
              mystream = FirestoreSerivice().getPasswords();
            } else {
              mystream = FirestoreSerivice()
                  .getPasswordsByCategory(_categories[cubit.currentindex]);
            }
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 3.5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == cubit.currentindex
                ? MyColors.green
                : Theme.of(context).backgroundColor,
          ),
          child: Text(name,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 9.sp,
                    color: index == cubit.currentindex
                        ? Colors.white
                        : Colors.grey,
                  )),
        ),
      ),
    );
  }
}
