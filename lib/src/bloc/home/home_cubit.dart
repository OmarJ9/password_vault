import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../constants/consts_variables.dart';
import '../../screens/tabs/addpass_screen.dart';
import '../../screens/tabs/passgen_screen.dart';
import '../../screens/tabs/passwords_screen.dart';
import '../../screens/tabs/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  int navcurruntindex = 0;

  List<Widget> screens = [
    const PasswordScreen(),
    const PassGenScreen(false),
    const AddPassScreen(),
    const SettingsScreen()
  ];

  Future addStorage(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(key, value);
  }

  Future addSecureStorage(String key, String value) async {
    const storage = FlutterSecureStorage();

    await storage.write(key: key, value: value);
  }

  void getSecureStorageData(String key) async {
    const storage = FlutterSecureStorage();

    await storage.read(key: key);
  }

  void removeSecureStorageData() async {
    const storage = FlutterSecureStorage();

    pin = null;

    await storage.deleteAll();
  }

  bool isDark = true;

  void changeAppMode(bool value) async {
    if (value) {
      isDark = true;
      emit(ChangeThemeDarkState());
    } else {
      isDark = false;
      emit(ChangeThemeLightState());
    }
  }
}
