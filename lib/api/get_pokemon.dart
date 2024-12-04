import 'package:dio/dio.dart';

import '../data/models/pokemon_model.dart';

Future<PokemonModel> getPokemon({required String url}) async {
  final dio = Dio();
  final response = await dio.get(url);

  try {
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final PokemonModel pokemon = PokemonModel.fromJson(data);
      return pokemon;
    } else {
      throw Exception();
    }
  } catch (e) {
    throw Exception();
  }
}
