import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../models/onaboard_model.dart';
import 'assets_path.dart';

String? backuppass;
String? pin;
bool? onboardingseen;

List<OnBoardModel> onboardlist = [
  OnBoardModel(
      image: MyAssets.onboradingtwo,
      title: 'Welcome to PassVault',
      description:
          'PassVault stores all your passwords in one place,they will be available for all youe devices.'),
  OnBoardModel(
      image: MyAssets.onboradingone,
      title: 'Strong Passwords',
      description:
          'PassVault will generate a strong and safe password for all your websites.'),
  OnBoardModel(
      image: MyAssets.onboradingthree,
      title: 'Let\'s get started',
      description:
          'Login or Create an account to start saving your passwords in a secured place on the Cloud.'),
];

final List<DropdownMenuItem<String>> categories = [
  const DropdownMenuItem(
    child: Text('Social'),
    value: 'Social',
  ),
  const DropdownMenuItem(
    child: Text('Finance'),
    value: 'Finance',
  ),
  const DropdownMenuItem(
    child: Text('Others'),
    value: 'Others',
  ),
];

final List<DropdownMenuItem<int>> passlenghtitems = [
  const DropdownMenuItem(
    child: Text('6 Items'),
    value: 6,
  ),
  const DropdownMenuItem(
    child: Text('8 Items'),
    value: 8,
  ),
  const DropdownMenuItem(
    child: Text('16 Items'),
    value: 16,
  ),
];
final List<List<DropdownMenuItem<String>>> subcategories = [
  [
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.facebookicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Facebook'),
        ],
      ),
      value: 'Facebook',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.instagramicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Instagram'),
        ],
      ),
      value: 'Instagram',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.twittericon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Twitter'),
        ],
      ),
      value: 'Twitter',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.tiktokicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('TikTok'),
        ],
      ),
      value: 'TikTok',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.linkdenicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Linkedin'),
        ],
      ),
      value: 'Linkedin',
    ),
  ],
  [
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.amazonpayicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('AmazonPay'),
        ],
      ),
      value: 'AmazonPay',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.applepayicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('ApplePay'),
        ],
      ),
      value: 'ApplePay',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.ebayicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Ebay'),
        ],
      ),
      value: 'Ebay',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.paypalicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Paypal'),
        ],
      ),
      value: 'Paypal',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.stripeicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Stripe'),
        ],
      ),
      value: 'Stripe',
    ),
  ],
  [
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.netflixicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Netflix'),
        ],
      ),
      value: 'Netflix',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.spotifyicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Spotify'),
        ],
      ),
      value: 'Spotify',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.driveicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Drive'),
        ],
      ),
      value: 'Drive',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Image.asset(
            MyAssets.megaicon,
            height: 3.h,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Mega'),
        ],
      ),
      value: 'Mega',
    ),
  ]
];

List selectedcategoryvalues = ['Facebook', 'AmazonPay', 'Netflix'];
