import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/app/app.dart';
import 'package:pokemon_time/app/bloc/screen_nav_cubit.dart';
import 'package:pokemon_time/app/bloc/theme_cubit.dart';
import 'package:pokemon_time/config/theme/dark_theme.dart';
import 'package:pokemon_time/core/services/share_prerences.dart';
import 'package:pokemon_time/presentation/bloc/list_pokemon_cubit/get_list_pokemon_cubit.dart';
import 'package:pokemon_time/presentation/bloc/pokemon_cubit/get_pokemon_cubit.dart';
import 'package:pokemon_time/presentation/bloc/pokemon_page_cubit/pokemon_page_cubit.dart';

import 'config/theme/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // SystemChrome.setSystemUIOverlayStyle(
  //     );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetListPokemonCubit(),
        ),
        BlocProvider(
          create: (context) => GetPokemonCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(ThemeSharePrerences()),
        ),
        BlocProvider(
          create: (context) => ScreenNavCubit(),
        ),
        BlocProvider(
          create: (context) => PokemonPageCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const App(),
        );
      }),
    );
  }
}
