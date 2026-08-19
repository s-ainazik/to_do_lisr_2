import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingCubit extends Cubit<bool> {
  SettingCubit() : super(false);

  Future<void> getTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final isDarkTheme = preferences.getBool('isDarkTheme') ?? false;

    emit(isDarkTheme);
  }

  Future<void> changeTheme(bool value) async {
    emit(value);

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isDarkTheme', value);
  }
}