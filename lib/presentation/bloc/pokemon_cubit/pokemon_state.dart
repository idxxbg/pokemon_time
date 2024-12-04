import 'package:pokemon_time/data/models/pokemon_model.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  PokemonLoaded(this.pokemon);
  final PokemonModel pokemon;
}

class PokemonError extends PokemonState {
  PokemonError(this.error);
  final String error;
}
