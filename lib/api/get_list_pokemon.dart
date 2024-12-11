import 'package:dio/dio.dart';
import 'package:pokemon_time/core/constants/constants.dart';
import 'package:pokemon_time/data/models/pokemon_basic_info.dart';

// class GetListPokemon {
//   GetListPokemon({required this.dio, required this.offset});
//   final Dio dio;
//   final int offset;

//   Future<Either<Failure,PokemonListModels>> fetListPokemon(int offset)
// }

Future<List<PokemonBasicInfo>> getListPokemon({required int offset}) async {
  final dio = Dio();
  final baseUrl = 'https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=20';
  final response = await dio.get(baseUrl);
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = response.data;
    final List<dynamic> results = data[kresults];

    // Chuyển đổi rõ ràng từ List<dynamic> sang List<PokemonBasicInfo>
    final List<PokemonBasicInfo> pokemonList = results
        .map((e) => PokemonBasicInfo.fromJson(e as Map<String, dynamic>))
        .toList();
    return pokemonList;
  } else {
    throw Exception('Failed to load Pokemon list');
  }
}
