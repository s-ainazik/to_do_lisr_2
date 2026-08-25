import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_2/home/home_page.dart';
import 'package:to_do_list_2/onboarding/onboarding_page.dart';
import 'package:to_do_list_2/settings/setting_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isOnboardingWatched = false;
  bool isLoading = true;

  final SettingCubit settingCubit = SettingCubit();

  @override
  void initState() {
    super.initState();

    getOnboardingInfo();
    settingCubit.getTheme();
  }

  Future<void> getOnboardingInfo() async {
    final preferences =
    await SharedPreferences.getInstance();

    isOnboardingWatched =
        preferences.getBool(onboardingKey) ?? false;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingCubit,
      child: BlocBuilder<SettingCubit, bool>(
        builder: (context, isDarkTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'To Do List',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
              ),
              scaffoldBackgroundColor:
              const Color(0xfff5f3fa),
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              scaffoldBackgroundColor:
              const Color(0xff1b1726),
              brightness: Brightness.dark,
            ),
            themeMode: isDarkTheme
                ? ThemeMode.dark
                : ThemeMode.light,
            home: isLoading
                ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
                : isOnboardingWatched
                ? const HomePage()
                : const OnboardingPage(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    settingCubit.close();

    super.dispose();
  }
}