import 'package:pokemon_time/core/constants/constants.dart';

import 'sub_models.dart';

class PokemonModel {
  PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.types,
    required this.sprites,
  });
  final int id;
  final String name;
  final int height;
  final int weight;
  final int baseExperience;
  final SpritesModel sprites;
  final List<TypesModel> types;

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json[kid],
      name: json[kname],
      height: json[kheight],
      weight: json[kweight],
      baseExperience: json[kbexperience],
      sprites: SpritesModel.fromJson(json[ksprites]),
      types: TypesModel.fromJson(json[ktypes]),
    );
  }
}
