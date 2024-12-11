import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/app/bloc/theme_cubit.dart';
import 'package:pokemon_time/common/style/text_styles.dart';
import 'package:pokemon_time/app/bloc/pokemon_image_3d_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
        bool isDark = state == ThemeMode.dark;
        final themeCubit = context.read<ThemeCubit>();
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Setting Space',
              style: TextStyles.appBarTitle,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CupertinoFormSection.insetGrouped(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  header: const Text('Setting'),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                  children: [
                    ListTile(
                      title: const Text('Dark mode IOS'),
                      trailing: CupertinoSwitch(
                        value: isDark,
                        onChanged: (isDark) {
                          themeCubit.changeThemeMode();
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Dark mode Material 3'),
                      trailing: Switch(
                        thumbIcon: WidgetStatePropertyAll(
                          Icon(isDark
                              ? Icons.nightlight_round
                              : Icons.wb_sunny_rounded),
                        ),
                        value: isDark,
                        onChanged: (value) {
                          themeCubit.changeThemeMode();
                        },
                      ),
                    ),
                    BlocBuilder<PokemonImage3DCubit, bool>(
                      builder: (context, is3D) {
                        return ListTile(
                          title: const Text('3D Image'),
                          trailing: Switch(
                            thumbIcon: WidgetStatePropertyAll(
                              Icon(is3D
                                  ? Icons.catching_pokemon
                                  : CupertinoIcons.view_2d),
                            ),
                            value: is3D,
                            onChanged: (value) {
                              context
                                  .read<PokemonImage3DCubit>()
                                  .onChange3Dstyle();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
