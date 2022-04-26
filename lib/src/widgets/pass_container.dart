import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';
import 'package:pass_vault/src/widgets/mysnackbar.dart';
import '../services/firestore_service.dart';
import 'package:sizer/sizer.dart';

class PassContainer extends StatelessWidget {
  final String icon;
  final String website;
  final String category;
  final String password;
  final String id;
  const PassContainer(
      {Key? key,
      required this.icon,
      required this.website,
      required this.category,
      required this.password,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (direction) {
        FirestoreSerivice().deletePass(id);
      },
      background: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerLeft,
      ),
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
            children: [
              Image.asset(
                'assets/icons/${icon.toLowerCase()}.png',
                height: 8.h,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          website,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const Spacer(),
                        Text(
                          category,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 9.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Row(
                      children: [
                        Text(
                          password,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 9.sp, color: Colors.white),
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
