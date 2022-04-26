import 'package:flutter/material.dart';
import '../bloc/home/home_cubit.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/flat_button.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/onboard_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;
  int currentpage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: 3,
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return OnBoardPage(
                  index: index,
                );
              },
              onPageChanged: (page) {
                setState(() {
                  currentpage = page;
                });
              },
            ),
          ),
          SizedBox(
              height: 33.h,
              child: currentpage != 2
                  ? SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: const SwapEffect(
                          activeDotColor: MyColors.green, dotWidth: 20),
                    )
                  : _buildbutton(cubit)),
        ],
      ),
    );
  }

  Widget _buildbutton(HomeCubit cubit) {
    return Column(
      children: [
        SizedBox(
          height: 9.h,
        ),
        MyFlatButton(
            func: () {
              cubit.addStorage('onboardinseen', true);
              Navigator.pushNamed(context, authscreen);
            },
            title: 'Get Started',
            color: Colors.green),
        SizedBox(
          height: 9.h,
        ),
      ],
    );
  }
}
