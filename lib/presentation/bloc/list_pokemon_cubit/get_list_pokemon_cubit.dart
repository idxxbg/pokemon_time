import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/data/models/pokemon_list_models.dart';

import '../../../core/constants/constants.dart';
import '../../../data/models/pokemon_model.dart';
import 'pokemon_list_state.dart';

class GetListPokemonCubit extends Cubit<PokemonListState> {
  GetListPokemonCubit() : super(PokemonListInitial());

  Future<void> fetchPokemonList(int offset) async {
    final dio = Dio();
    final List<PokemonBasicInfo> _cachedPokemonList = [];
    if (_cachedPokemonList.isNotEmpty) {
      emit(PokemonListLoaded(_cachedPokemonList)); // Sử dụng cache nếu có
      return;
    }
    emit(PokemonListLoading());

    try {
      final baseUrl =
          'https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=20';
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<dynamic> results = data[kresults];
        List<PokemonBasicInfo> pokemonList = results
            .map((e) => PokemonBasicInfo.fromJson(e as Map<String, dynamic>))
            .toList();

        final detailedPokemonList = await Future.wait(
          pokemonList.map((pokemon) async {
            final detailResponse = await dio.get(pokemon.url);
            final detailedPokemon = PokemonModel.fromJson(detailResponse.data);
            return PokemonBasicInfo(
              name: pokemon.name,
              url: pokemon.url,
              pokemon: detailedPokemon,
            );
          }),
        );

        _cachedPokemonList.addAll(detailedPokemonList); // Lưu vào cache
        emit(PokemonListLoaded(detailedPokemonList));
      } else {
        throw Exception('fail to Load pokemon');
      }
    } catch (e) {
      emit(PokemonListError(e.toString()));
    }
  }
}
