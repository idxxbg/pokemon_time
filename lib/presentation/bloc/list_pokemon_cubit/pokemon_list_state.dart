import '../../../data/models/pokemon_list_models.dart';

abstract class PokemonListState {}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListLoaded extends PokemonListState {
  PokemonListLoaded(this.pokemonList);
  final List<PokemonBasicInfo> pokemonList;
}

class PokemonListError extends PokemonListState {
  PokemonListError(this.error);
  final String error;
}
