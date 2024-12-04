import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/app/bloc/screen_nav_cubit.dart';
import 'package:pokemon_time/app/screens/setting_screen.dart';
import 'package:pokemon_time/presentation/screens/pokemon_list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    List screens = const [
      PokemonListScreen(),
      Test(),
      SettingScreen(),
    ];
    return BlocBuilder<ScreenNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) =>
                context.read<ScreenNavCubit>().onChangeScreen(value),
            currentIndex: state,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.catching_pokemon),
                label: 'Pokémon',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(),
    );
  }
}
