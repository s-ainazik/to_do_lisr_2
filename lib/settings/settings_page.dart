import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_2/settings/setting_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocBuilder<SettingCubit, bool>(
        builder: (context, isDarkTheme) {
          return Scaffold(
            backgroundColor: isDarkTheme
                ? const Color(0xff1b1726)
                : const Color(0xfff5f3fa),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: isDarkTheme
                  ? const Color(0xff282338)
                  : const Color(0xfff5f3fa),
              foregroundColor: isDarkTheme
                  ? Colors.white
                  : const Color(0xff222222),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              ),
              title: const Text(
                'Настройки',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 22),
              child: Container(
                height: 70,
                padding: const EdgeInsets.only(left: 14, right: 12),
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? const Color(0xff322d3d)
                      : const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Тёмная тема',
                            style: TextStyle(
                              color: isDarkTheme ? Colors.white : Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            isDarkTheme
                                ? 'Использовать светлое\nОформление приложения'
                                : 'Использовать тёмное\nОформление приложения',
                            style: TextStyle(
                              color: isDarkTheme
                                  ? Colors.white
                                  : const Color(0xff555555),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: isDarkTheme,
                      activeThumbColor: Colors.white,
                      activeTrackColor: const Color(0xff0d83f6),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xffd8dce2),
                      onChanged: (value) {
                        context.read<SettingCubit>().changeTheme(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
