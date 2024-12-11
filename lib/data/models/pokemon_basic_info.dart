import 'package:pokemon_time/core/constants/constants.dart';
import 'package:pokemon_time/data/models/pokemon_model.dart';

class PokemonBasicInfo {
  PokemonBasicInfo({
    required this.name,
    required this.url,
    this.pokemon,
  });
  final String name;
  final String url;
  final PokemonModel? pokemon;

  factory PokemonBasicInfo.fromJson(Map<String, dynamic> json) {
    return PokemonBasicInfo(
      name: json[kname],
      url: json[kurl],
    );
  }
}
