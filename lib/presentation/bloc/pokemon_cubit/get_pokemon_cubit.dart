import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/data/models/pokemon_model.dart';

import 'pokemon_state.dart';

class GetPokemonCubit extends Cubit<PokemonState> {
  GetPokemonCubit() : super(PokemonInitial());

  Future<void> getPokemon(String url) async {
    emit(PokemonLoading());
    final dio = Dio();
    final response = await dio.get(url);

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final PokemonModel pokemon = PokemonModel.fromJson(data);
        emit(PokemonLoaded(pokemon));
      } else {
        throw Exception('failed to get data!');
      }
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }
}
