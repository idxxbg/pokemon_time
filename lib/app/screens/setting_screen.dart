import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/app/bloc/theme_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
        bool isDark = state == ThemeMode.dark;
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight),
              ListTile(
                title: const Text('Dark mode'),
                trailing: CupertinoSwitch(
                  value: isDark,
                  onChanged: (isDark) {
                    context.read<ThemeCubit>().changeThemeMode();
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
