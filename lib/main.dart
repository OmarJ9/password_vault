import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'src/bloc/auth/auth_cubit.dart';
import 'src/bloc/connectivity/connectivity_cubit.dart';
import 'src/bloc/home/home_cubit.dart';
import 'src/constants/consts_variables.dart';
import 'src/route.dart';
import 'src/screens/auth_screen.dart';
import 'src/screens/onboarding_screen.dart';
import 'src/screens/pin_screen.dart';
import 'src/utils/bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'src/constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  const storage = FlutterSecureStorage();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  pin = await storage.read(key: 'mypin');
  backuppass = await storage.read(key: 'mybackuppass');
  onboardingseen = prefs.getBool('onboardinseen') ?? false;

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (context) =>
                  ConnectivityCubit()..initializeConnectivity(),
            ),
            BlocProvider(
              create: (context) => HomeCubit(),
            ),
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
          ],
          child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                HomeCubit cubit = HomeCubit.get(context);
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Pass Vault',
                  theme: MyThemes.light,
                  darkTheme: MyThemes.dark,
                  themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
                  onGenerateRoute: AppRoute().generateRoute,
                  home: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return const PinScreen();
                      }

                      if (onboardingseen == true) {
                        return const AuthScreen();
                      }
                      return const OnboardingScreen();
                    },
                  ),
                );
              }),
        );
      },
    );
  }
}
