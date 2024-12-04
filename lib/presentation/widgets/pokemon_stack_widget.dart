import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/common/extenstions/extenstions.dart';
import 'package:pokemon_time/data/models/pokemon_list_models.dart';
import 'package:pokemon_time/presentation/bloc/pokemon_cubit/get_pokemon_cubit.dart';
import 'package:pokemon_time/presentation/bloc/pokemon_cubit/pokemon_state.dart';
import 'package:pokemon_time/presentation/screens/pokemon_detail_screen.dart';

class PokemonStackWidget extends StatelessWidget {
  const PokemonStackWidget({super.key, required this.pokemon});
  final PokemonBasicInfo pokemon;

  @override
  Widget build(BuildContext context) {
    context.read<GetPokemonCubit>().getPokemon(pokemon.url);
    return BlocBuilder<GetPokemonCubit, PokemonState>(
      builder: (context, state) {
        return SizedBox(
          height: 200,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PokemonDetailScreen(
                            pokemon: pokemon.pokemon!,
                          ),
                        ),
                      );
                      context.read<GetPokemonCubit>().getPokemon(pokemon.url);
                    },
                    title: Material(
                      color: Colors.transparent,
                      child: Text(pokemon.name.capitalize()),
                    ),
                    trailing: Card(
                        color: Theme.of(context).secondaryHeaderColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(pokemon.pokemon!.baseExperience.toString()),
                        )),
                  ),
                ),
              ),
              Positioned(
                right: 40,
                child: Hero(
                  tag: pokemon
                      .pokemon!.sprites.other.officialArtwork.frontDefault,
                  child: IgnorePointer(
                    child: CachedNetworkImage(
                      imageUrl: pokemon
                          .pokemon!.sprites.other.officialArtwork.frontDefault,
                      height: 200,
                      // height: MediaQuery.sizeOf(context).height * 0.2,

                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
